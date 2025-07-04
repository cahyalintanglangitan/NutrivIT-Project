<?php
// Selalu mulai dengan header ini untuk memastikan outputnya JSON
header('Content-Type: application/json');

// --- Pengecekan Kritis: Apakah cURL terinstall? ---
if (!function_exists('curl_init')) {
    // Jika tidak, kirim error JSON yang jelas dan hentikan skrip
    echo json_encode(['error' => 'Server Error: Ekstensi cURL PHP tidak diaktifkan atau tidak terinstall. Silakan aktifkan di file php.ini Anda.']);
    exit;
}

// --- Konfigurasi Penting ---
$apiKey = 'AIzaSyAM5UFIdh_fJRbVkGi6yF86bgi_nI1GdCA'; // PASTIKAN ANDA SUDAH MENGGANTI INI
$model = 'gemini-1.5-flash-latest';
$apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/{$model}:generateContent?key={$apiKey}";

// Menerima data JSON yang dikirim dari JavaScript
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);

// Validasi input
if (!isset($input['prompt']) || empty($input['prompt'])) {
    echo json_encode(['error' => 'Input prompt tidak boleh kosong.']);
    exit;
}

$userPrompt = $input['prompt'];

// Menyiapkan data untuk dikirim ke Gemini API
$data = [
    'contents' => [['parts' => [['text' => $userPrompt]]]]
];
$jsonData = json_encode($data);

// Menggunakan cURL untuk mengirim request ke Gemini API
$ch = curl_init($apiUrl);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonData);
// Tambahkan opsi ini untuk server lokal (seperti XAMPP) yang mungkin punya masalah sertifikat SSL
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); 
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);

$response = curl_exec($ch);
$httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

// Menangani error cURL jika terjadi (misal: tidak bisa konek ke internet)
if (curl_errno($ch)) {
    echo json_encode(['error' => 'cURL Error: ' . curl_error($ch)]);
    curl_close($ch);
    exit;
}
curl_close($ch);

// Memproses respons dari Gemini
if ($httpcode == 200) {
    $result = json_decode($response, true);
    // Cek jika respons dari Gemini adalah error (misal: API Key salah)
    if (isset($result['error'])) {
        echo json_encode(['error' => 'Gemini API Error: ' . $result['error']['message']]);
    } else {
        $aiReply = $result['candidates'][0]['content']['parts'][0]['text'] ?? 'Maaf, saya tidak mendapat balasan yang valid dari AI.';
        echo json_encode(['reply' => $aiReply]);
    }
} else {
    // Menangani error HTTP dari API Google
    $errorDetails = json_decode($response, true);
    $errorMessage = $errorDetails['error']['message'] ?? "Terjadi kesalahan HTTP {$httpcode} saat menghubungi server AI.";
    echo json_encode(['error' => $errorMessage]);
}
?>