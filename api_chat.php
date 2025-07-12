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
    // Fungsi ini sama seperti sebelumnya, tidak perlu diubah
    $context = "";
    try {
        $total_users = $conn->query("SELECT COUNT(id) as total FROM users WHERE status = 'active'")->fetch_assoc()['total'];
        $total_products = $conn->query("SELECT COUNT(id) as total FROM products WHERE product_status = 'Active'")->fetch_assoc()['total'];
        $total_revenue_h1_2025 = $conn->query("SELECT SUM(total_price) as total FROM sales WHERE sale_date BETWEEN '2025-01-01' AND '2025-06-30'")->fetch_assoc()['total'];

        $complaints_query = $conn->query("SELECT complaint_type, COUNT(id) as total FROM user_complaints GROUP BY complaint_type ORDER BY total DESC LIMIT 3");
        $top_complaints = [];
        while($row = $complaints_query->fetch_assoc()) {
            $top_complaints[] = "{$row['complaint_type']} ({$row['total']} kasus)";
        }

        $bestsellers_query = $conn->query("SELECT p.name, SUM(s.quantity) as total_sold FROM sales s JOIN products p ON s.product_id = p.id GROUP BY p.name ORDER BY total_sold DESC LIMIT 3");
        $best_sellers = [];
        while($row = $bestsellers_query->fetch_assoc()) {
            $best_sellers[] = "{$row['name']} ({$row['total_sold']} unit)";
        }
        
        $nutrition_gap_query = $conn->query("SELECT * FROM nutrition_needs WHERE month = 'Jun'")->fetch_assoc();
        $fat_gap = $nutrition_gap_query['fat_kg'];
        $protein_gap = $nutrition_gap_query['protein_kg'];

        $context .= "Ringkasan Bisnis H1 2025:\n";
        $context .= "- Total Pengguna Aktif: " . number_format($total_users) . "\n";
        $context .= "- Total Produk Aktif: " . number_format($total_products) . "\n";
        $context .= "- Total Pendapatan H1 2025: Rp " . number_format($total_revenue_h1_2025, 2, ',', '.') . "\n";
        $context .= "- Produk Terlaris: " . implode(', ', $best_sellers) . "\n";
        $context .= "- Keluhan Pengguna Teratas: " . implode(', ', $top_complaints) . "\n";
        $context .= "- Kebutuhan Nutrisi Belum Terpenuhi (Juni): Defisit Lemak {$fat_gap} kg, Defisit Protein {$protein_gap} kg.\n";

    } catch (Exception $e) {
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


// Menerima input dari JavaScript
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);

if (!isset($input['prompt']) || empty(trim($input['prompt']))) {
    echo json_encode(['error' => 'Input prompt tidak boleh kosong.']);
    exit;
}

$userPrompt = strtolower(trim($input['prompt']));

// =================================================================================
// PERUBAHAN LOGIKA DIMULAI DARI SINI
// =================================================================================

// Daftar respons sederhana yang tidak memerlukan AI
$simple_responses = [
    "halo" => "Halo! Ada yang bisa saya bantu untuk analisis bisnis hari ini?",
    "hai" => "Hai! Ada yang bisa saya bantu untuk analisis bisnis hari ini?",
    "hi" => "Hi! Ada yang bisa saya bantu untuk analisis bisnis hari ini?",
    "selamat pagi" => "Selamat pagi! Siap untuk menganalisis data hari ini?",
    "selamat siang" => "Selamat siang! Ada data yang perlu kita diskusikan?",
    "selamat sore" => "Selamat sore! Ada insight menarik yang ingin Anda gali?",
    "selamat malam" => "Selamat malam! Siap untuk review performa bisnis?",
    "terima kasih" => "Sama-sama! Senang bisa membantu.",
    "makasih" => "Sama-sama! Jika ada hal lain, beri tahu saya.",
    "thanks" => "Dengan senang hati!",
    "oke" => "Baik.",
    "ok" => "Baik."
];

// Cek apakah pesan pengguna adalah sapaan atau ucapan terima kasih
if (array_key_exists($userPrompt, $simple_responses)) {
    // Jika ya, langsung balas tanpa ke AI
    echo json_encode(['reply' => $simple_responses[$userPrompt]]);
    exit(); // Hentikan eksekusi skrip
}

// --- JIKA BUKAN SAPAAN, BARU JALANKAN LOGIKA AI ---

// Ambil konteks database (ini bisa disempurnakan lagi nanti menjadi dinamis)
$databaseContext = get_database_context($conn);

// PERUBAHAN KEDUA: Prompt diperkuat dengan peraturan yang sangat jelas
$finalPrompt = "Anda adalah AI manajerial untuk perusahaan suplemen bernama NutrivIT. Anda SANGAT PROFESIONAL dan FOKUS.

PERATURAN PENTING:
1. JAWAB HANYA pertanyaan yang berhubungan dengan analisis bisnis NutrivIT, penjualan, produk, keluhan pengguna, atau data yang disediakan.
2. JIKA pengguna bertanya pertanyaan di luar topik (misal: 'siapa presiden?', 'ceritakan lelucon', cuaca, atau pertanyaan umum lainnya), JANGAN DIJAWAB. Balas secara sopan dengan SATU KALIMAT INI SAJA: 'Maaf, saya adalah AI yang dirancang khusus untuk membantu analisis bisnis NutrivIT. Saya tidak bisa menjawab pertanyaan di luar topik tersebut.'
3. JANGAN PERNAH menyapa kembali (misal: 'Halo!', 'Tentu!'). Langsung berikan jawaban analisisnya.

Berikut adalah data real-time sebagai KONTEKS UTAMA Anda:
--- DATA REAL-TIME DARI DATABASE ---
{$databaseContext}
--- AKHIR DATA ---

Pertanyaan Pengguna: \"{$input['prompt']}\"

Jawaban Anda:";


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
// Hapus baris di bawah ini jika Anda sudah memperbaiki masalah sertifikat SSL
// curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
// curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);

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