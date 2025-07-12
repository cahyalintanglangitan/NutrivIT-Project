<?php
// api_chat.php

// Selalu mulai dengan header ini untuk memastikan outputnya JSON
header('Content-Type: application/json');

// 1. Sertakan file koneksi database
require_once 'koneksi.php';

// --- Pengecekan Kritis: Apakah cURL terinstall? ---
if (!function_exists('curl_init')) {
    echo json_encode(['error' => 'Server Error: Ekstensi cURL PHP tidak diaktifkan. Aktifkan di php.ini.']);
    exit;
}

// --- FUNGSI UNTUK MENGAMBIL DATA KONTEKS DARI DATABASE ---
function get_database_context($conn) {
    $context = "";
    try {
        // Ambil data ringkasan
        $total_users = $conn->query("SELECT COUNT(id) as total FROM users WHERE status = 'active'")->fetch_assoc()['total'];
        $total_products = $conn->query("SELECT COUNT(id) as total FROM products WHERE product_status = 'Active'")->fetch_assoc()['total'];
        $total_revenue_h1_2025 = $conn->query("SELECT SUM(total_price) as total FROM sales WHERE sale_date BETWEEN '2025-01-01' AND '2025-06-30'")->fetch_assoc()['total'];

        // Ambil top 3 keluhan
        $complaints_query = $conn->query("SELECT complaint_type, COUNT(id) as total FROM user_complaints GROUP BY complaint_type ORDER BY total DESC LIMIT 3");
        $top_complaints = [];
        while($row = $complaints_query->fetch_assoc()) {
            $top_complaints[] = "{$row['complaint_type']} ({$row['total']} kasus)";
        }

        // Ambil top 3 produk terlaris
        $bestsellers_query = $conn->query("SELECT p.name, SUM(s.quantity) as total_sold FROM sales s JOIN products p ON s.product_id = p.id GROUP BY p.name ORDER BY total_sold DESC LIMIT 3");
        $best_sellers = [];
        while($row = $bestsellers_query->fetch_assoc()) {
            $best_sellers[] = "{$row['name']} ({$row['total_sold']} unit)";
        }
        
        // Ambil gap nutrisi terbesar dari data bulan Juni
        $nutrition_gap_query = $conn->query("SELECT * FROM nutrition_needs WHERE month = 'Jun'")->fetch_assoc();
        $fat_gap = $nutrition_gap_query['fat_kg'];
        $protein_gap = $nutrition_gap_query['protein_kg'];


        // Format menjadi string konteks
        $context .= "Ringkasan Bisnis H1 2025:\n";
        $context .= "- Total Pengguna Aktif: " . number_format($total_users) . "\n";
        $context .= "- Total Produk Aktif: " . number_format($total_products) . "\n";
        $context .= "- Total Pendapatan H1 2025: Rp " . number_format($total_revenue_h1_2025, 2, ',', '.') . "\n";
        $context .= "- Produk Terlaris: " . implode(', ', $best_sellers) . "\n";
        $context .= "- Keluhan Pengguna Teratas: " . implode(', ', $top_complaints) . "\n";
        $context .= "- Kebutuhan Nutrisi Belum Terpenuhi (Juni): Defisit Lemak {$fat_gap} kg, Defisit Protein {$protein_gap} kg.\n";

    } catch (Exception $e) {
        // Jika ada error saat query, kembalikan string kosong
        return "";
    }
    return $context;
}


// --- Konfigurasi Gemini API ---
$apiKey = file_get_contents('api_key.txt');
if (!$apiKey) {
    echo json_encode(['error' => 'API Key tidak ditemukan atau tidak bisa dibaca.']);
    exit;
}
$model = 'gemini-1.5-flash-latest';
$apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/{$model}:generateContent?key={$apiKey}";


// 2. Menerima input dari JavaScript
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);

if (!isset($input['prompt']) || empty($input['prompt'])) {
    echo json_encode(['error' => 'Input prompt tidak boleh kosong.']);
    exit;
}

$userPrompt = $input['prompt'];

// 3. Ambil data konteks dari database
$databaseContext = get_database_context($conn);

// 4. Buat prompt yang sudah diperkaya dengan konteks
$finalPrompt = "Anda adalah AI manajerial untuk perusahaan suplemen bernama NutrivIT. Tugas Anda adalah menjawab pertanyaan pengguna dengan strategis, cerdas, dan berdasarkan data.
Gunakan data real-time berikut sebagai KONTEKS UTAMA untuk jawaban Anda. Jangan mengarang data di luar konteks ini.

--- DATA REAL-TIME DARI DATABASE ---
{$databaseContext}
--- AKHIR DATA ---

Pertanyaan Pengguna: \"{$userPrompt}\"

Jawaban Anda (berikan dalam format Markdown yang jelas dan profesional):";


// Menyiapkan data untuk dikirim ke Gemini API
$data = [
    'contents' => [['parts' => [['text' => $finalPrompt]]]]
];
$jsonData = json_encode($data);

// Menggunakan cURL untuk mengirim request
$ch = curl_init($apiUrl);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonData);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);

$response = curl_exec($ch);
$httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

if (curl_errno($ch)) {
    echo json_encode(['error' => 'cURL Error: ' . curl_error($ch)]);
    curl_close($ch);
    exit;
}
curl_close($ch);

// Memproses respons dari Gemini
if ($httpcode == 200) {
    $result = json_decode($response, true);
    if (isset($result['error'])) {
        echo json_encode(['error' => 'Gemini API Error: ' . $result['error']['message']]);
    } else {
        $aiReply = $result['candidates'][0]['content']['parts'][0]['text'] ?? 'Maaf, saya tidak mendapat balasan yang valid dari AI.';
        echo json_encode(['reply' => $aiReply]);
    }
} else {
    $errorDetails = json_decode($response, true);
    $errorMessage = $errorDetails['error']['message'] ?? "Terjadi kesalahan HTTP {$httpcode}.";
    echo json_encode(['error' => $errorMessage]);
}

// Tutup koneksi database
$conn->close();
?>