<?php
// api_chat.php - Enhanced AI Chat API with Database-Only Responses

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

require_once 'koneksi.php';

// Check if cURL is available
if (!function_exists('curl_init')) {
    echo json_encode(['error' => 'Server Error: cURL extension tidak tersedia.']);
    exit;
}

// Function to get comprehensive database context
function get_comprehensive_database_context($conn) {
    $context = "";
    
    try {
        // Basic Statistics
        $stats = [];
        $stats['total_users'] = $conn->query("SELECT COUNT(*) as count FROM users WHERE status = 'active'")->fetch_assoc()['count'];
        $stats['total_products'] = $conn->query("SELECT COUNT(*) as count FROM products WHERE product_status = 'Active'")->fetch_assoc()['count'];
        $stats['total_orders'] = $conn->query("SELECT COUNT(*) as count FROM orders WHERE created_at >= '2025-01-01'")->fetch_assoc()['count'];
        
        // Revenue Analysis
        $revenue_query = "SELECT 
            SUM(total_amount) as total_revenue,
            COUNT(*) as total_orders,
            AVG(total_amount) as avg_order_value
            FROM orders 
            WHERE status IN ('delivered', 'paid') 
            AND created_at >= '2025-01-01'";
        $revenue_data = $conn->query($revenue_query)->fetch_assoc();
        
        // Monthly Revenue Trend
        $monthly_revenue = $conn->query("
            SELECT 
                MONTH(created_at) as month,
                MONTHNAME(created_at) as month_name,
                SUM(total_amount) as revenue,
                COUNT(*) as orders
            FROM orders 
            WHERE status IN ('delivered', 'paid') 
            AND YEAR(created_at) = 2025
            GROUP BY MONTH(created_at), MONTHNAME(created_at)
            ORDER BY MONTH(created_at)
        ");
        
        // Top Selling Products
        $top_products = $conn->query("
            SELECT 
                p.name,
                p.category,
                p.price,
                SUM(oi.quantity) as total_sold,
                SUM(oi.total_price) as total_revenue
            FROM order_items oi
            JOIN products p ON oi.product_id = p.id
            JOIN orders o ON oi.order_id = o.id
            WHERE o.status IN ('delivered', 'paid')
            AND o.created_at >= '2025-01-01'
            GROUP BY p.id, p.name, p.category, p.price
            ORDER BY total_sold DESC
            LIMIT 5
        ");
        
        // User Complaints Analysis
        $complaints = $conn->query("
            SELECT 
                complaint_type,
                COUNT(*) as count,
                status,
                ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM user_complaints), 2) as percentage
            FROM user_complaints 
            WHERE created_at >= '2025-01-01'
            GROUP BY complaint_type, status
            ORDER BY count DESC
        ");
        
        // Nutrition Achievement Analysis
        $nutrition_stats = $conn->query("
            SELECT 
                AVG(percentage_achieved) as avg_achievement,
                COUNT(*) as total_records,
                AVG(calories_achieved/calories_target * 100) as avg_calorie_achievement,
                AVG(protein_achieved/protein_target * 100) as avg_protein_achievement
            FROM nutrition_achievements 
            WHERE date >= '2025-01-01'
        ")->fetch_assoc();
        
        // AI Consultations Analysis
        $ai_consultations = $conn->query("
            SELECT 
                consultation_type,
                COUNT(*) as count,
                AVG(satisfaction_rating) as avg_rating,
                AVG(consultation_duration) as avg_duration
            FROM ai_consultations 
            WHERE created_at >= '2025-01-01'
            GROUP BY consultation_type
            ORDER BY count DESC
        ");
        
        // Product Reviews Analysis
        $review_stats = $conn->query("
            SELECT 
                p.name as product_name,
                COUNT(pr.id) as review_count,
                AVG(pr.rating) as avg_rating
            FROM product_reviews pr
            JOIN products p ON pr.product_id = p.id
            WHERE pr.created_at >= '2025-01-01'
            GROUP BY p.id, p.name
            HAVING review_count >= 5
            ORDER BY avg_rating DESC, review_count DESC
            LIMIT 5
        ");
        
        // User Demographics
        $user_demographics = $conn->query("
            SELECT 
                member_type,
                gender,
                COUNT(*) as count,
                AVG(age) as avg_age,
                AVG(weight) as avg_weight,
                AVG(height) as avg_height
            FROM users 
            WHERE status = 'active'
            GROUP BY member_type, gender
        ");
        
        // Build comprehensive context
        $context .= "=== DATA PERUSAHAAN NUTRIVIT (REAL-TIME) ===\n\n";
        
        // Basic Stats
        $context .= "STATISTIK DASAR:\n";
        $context .= "- Total Pengguna Aktif: " . number_format($stats['total_users']) . "\n";
        $context .= "- Total Produk Aktif: " . number_format($stats['total_products']) . "\n";
        $context .= "- Total Pesanan 2025: " . number_format($stats['total_orders']) . "\n\n";
        
        // Revenue Analysis
        $context .= "ANALISIS PENDAPATAN 2025:\n";
        $context .= "- Total Revenue: Rp " . number_format($revenue_data['total_revenue'], 0, ',', '.') . "\n";
        $context .= "- Total Orders: " . number_format($revenue_data['total_orders']) . "\n";
        $context .= "- Average Order Value: Rp " . number_format($revenue_data['avg_order_value'], 0, ',', '.') . "\n\n";
        
        // Monthly Revenue Trend
        $context .= "TREN PENDAPATAN BULANAN 2025:\n";
        while ($row = $monthly_revenue->fetch_assoc()) {
            $context .= "- {$row['month_name']}: Rp " . number_format($row['revenue'], 0, ',', '.') . " ({$row['orders']} pesanan)\n";
        }
        $context .= "\n";
        
        // Top Products
        $context .= "PRODUK TERLARIS 2025:\n";
        $rank = 1;
        while ($row = $top_products->fetch_assoc()) {
            $context .= "- #{$rank}. {$row['name']} ({$row['category']}): " . number_format($row['total_sold']) . " unit, Revenue Rp " . number_format($row['total_revenue'], 0, ',', '.') . "\n";
            $rank++;
        }
        $context .= "\n";
        
        // Complaints Analysis
        $context .= "ANALISIS KELUHAN PENGGUNA 2025:\n";
        while ($row = $complaints->fetch_assoc()) {
            $context .= "- {$row['complaint_type']}: {$row['count']} kasus ({$row['percentage']}%) - Status: {$row['status']}\n";
        }
        $context .= "\n";
        
        // Nutrition Achievement
        $context .= "PENCAPAIAN NUTRISI PENGGUNA:\n";
        $context .= "- Rata-rata Pencapaian Target: " . number_format($nutrition_stats['avg_achievement'], 1) . "%\n";
        $context .= "- Pencapaian Kalori: " . number_format($nutrition_stats['avg_calorie_achievement'], 1) . "%\n";
        $context .= "- Pencapaian Protein: " . number_format($nutrition_stats['avg_protein_achievement'], 1) . "%\n";
        $context .= "- Total Records: " . number_format($nutrition_stats['total_records']) . "\n\n";
        
        // AI Consultations
        $context .= "KONSULTASI AI 2025:\n";
        while ($row = $ai_consultations->fetch_assoc()) {
            $context .= "- {$row['consultation_type']}: {$row['count']} sesi, Rating: " . number_format($row['avg_rating'], 1) . "/5, Durasi: " . number_format($row['avg_duration']) . " detik\n";
        }
        $context .= "\n";
        
        // Product Reviews
        $context .= "PRODUK DENGAN REVIEW TERBAIK:\n";
        while ($row = $review_stats->fetch_assoc()) {
            $context .= "- {$row['product_name']}: " . number_format($row['avg_rating'], 1) . "/5 ({$row['review_count']} reviews)\n";
        }
        $context .= "\n";
        
        // User Demographics
        $context .= "DEMOGRAFI PENGGUNA:\n";
        while ($row = $user_demographics->fetch_assoc()) {
            $context .= "- {$row['member_type']} {$row['gender']}: {$row['count']} orang, Usia rata-rata: " . number_format($row['avg_age'], 1) . " tahun\n";
        }
        
        $context .= "\n=== AKHIR DATA REAL-TIME ===\n";
        
    } catch (Exception $e) {
        $context = "Error mengambil data: " . $e->getMessage();
    }
    
    return $context;
}

// Check if question is database-related
function is_database_related_question($question) {
    $business_keywords = [
        // Business terms
        'penjualan', 'sales', 'revenue', 'pendapatan', 'omzet', 'keuntungan', 'profit',
        'produk', 'product', 'supplement', 'vitamin', 'protein', 'herbal', 'organic',
        'pengguna', 'user', 'customer', 'pelanggan', 'member', 'konsumen',
        'pesanan', 'order', 'transaksi', 'pembelian', 'beli',
        'keluhan', 'complaint', 'masalah', 'problem', 'issue',
        'nutrisi', 'nutrition', 'gizi', 'kalori', 'protein', 'karbohidrat', 'lemak',
        'konsultasi', 'consultation', 'saran', 'advice', 'rekomendasi',
        'review', 'rating', 'feedback', 'testimoni',
        'analisis', 'analysis', 'data', 'statistik', 'laporan', 'report',
        'tren', 'trend', 'pola', 'pattern',
        'strategi', 'strategy', 'bisnis', 'business', 'pemasaran', 'marketing',
        'nutrivit', 'nuvit', 'perusahaan', 'company',
        // Health terms
        'kesehatan', 'health', 'sehat', 'diet', 'fitness', 'olahraga',
        'berat badan', 'weight', 'tinggi', 'height', 'bmi',
        'energy', 'energi', 'stamina', 'kelelahan', 'lelah',
        'immunity', 'imunitas', 'daya tahan', 'sakit',
        'pencernaan', 'digestion', 'perut', 'mual',
        'tidur', 'sleep', 'insomnia', 'istirahat',
        // Time periods
        'hari', 'minggu', 'bulan', 'tahun', 'januari', 'februari', 'maret',
        'april', 'mei', 'juni', 'juli', 'agustus', 'september',
        'oktober', 'november', 'desember', '2025', '2024',
        // Question words
        'berapa', 'bagaimana', 'apa', 'kapan', 'dimana', 'mengapa', 'kenapa',
        'siapa', 'mana', 'how', 'what', 'when', 'where', 'why', 'who', 'which'
    ];
    
    $question_lower = strtolower($question);
    
    foreach ($business_keywords as $keyword) {
        if (strpos($question_lower, $keyword) !== false) {
            return true;
        }
    }
    
    return false;
}

// Load API key
$apiKey = trim(file_get_contents('api_key.txt'));
if (!$apiKey) {
    echo json_encode(['error' => 'API Key tidak ditemukan.']);
    exit;
}

$model = 'gemini-1.5-flash-latest';
$apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/{$model}:generateContent?key={$apiKey}";

// Get input
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);

if (!isset($input['prompt']) || empty(trim($input['prompt']))) {
    echo json_encode(['error' => 'Input prompt tidak boleh kosong.']);
    exit;
}

$userPrompt = trim($input['prompt']);

// Simple responses for greetings
$simple_responses = [
    "halo" => "Halo! Saya AI Assistant NutrivIT. Ada yang bisa saya bantu untuk analisis bisnis dan data perusahaan hari ini?",
    "hai" => "Hai! Saya siap membantu analisis data NutrivIT. Apa yang ingin Anda ketahui?",
    "hi" => "Hi! Ada pertanyaan tentang data bisnis NutrivIT yang bisa saya bantu?",
    "selamat pagi" => "Selamat pagi! Siap menganalisis data NutrivIT hari ini?",
    "selamat siang" => "Selamat siang! Ada data bisnis yang perlu kita bahas?",
    "selamat sore" => "Selamat sore! Bagaimana performa bisnis yang ingin dianalisis?",
    "selamat malam" => "Selamat malam! Mari review data bisnis NutrivIT.",
    "terima kasih" => "Sama-sama! Senang bisa membantu analisis bisnis NutrivIT.",
    "makasih" => "Dengan senang hati! Ada lagi yang perlu dianalisis?",
    "thanks" => "You're welcome! Anything else about NutrivIT data?",
];

$userPromptLower = strtolower($userPrompt);
if (array_key_exists($userPromptLower, $simple_responses)) {
    echo json_encode(['reply' => $simple_responses[$userPromptLower]]);
    exit;
}

// Check if question is related to database/business
if (!is_database_related_question($userPrompt)) {
    $rejection_message = "Maaf, saya adalah AI Assistant yang dirancang khusus untuk membantu analisis bisnis dan data NutrivIT. Saya hanya dapat menjawab pertanyaan yang berkaitan dengan:\n\n" .
                         "• Data penjualan dan revenue\n" .
                         "• Analisis produk dan performa\n" .
                         "• Data pengguna dan demografi\n" .
                         "• Keluhan dan feedback pelanggan\n" .
                         "• Statistik nutrisi dan kesehatan\n" .
                         "• Konsultasi dan review\n" .
                         "• Tren bisnis dan peluang pasar\n\n" .
                         "Silakan ajukan pertanyaan yang berkaitan dengan data bisnis NutrivIT.";
    
    echo json_encode(['reply' => $rejection_message]);
    exit;
}

// Get database context
$databaseContext = get_comprehensive_database_context($conn);

// Enhanced AI prompt
$finalPrompt = "Anda adalah AI Business Analyst untuk NutrivIT, perusahaan suplemen kesehatan Indonesia. Anda SANGAT PROFESIONAL dan FOKUS pada data bisnis.

ATURAN KETAT:
1. HANYA jawab pertanyaan tentang bisnis NutrivIT berdasarkan data yang disediakan
2. SELALU gunakan data real-time dari database, JANGAN buat data fiktif
3. Berikan insight yang actionable dan strategis
4. Gunakan format yang mudah dibaca dengan bullet points dan angka yang jelas
5. Jika data tidak tersedia, katakan dengan jujur
6. Fokus pada analisis yang membantu pengambilan keputusan manajerial

DATA REAL-TIME NUTRIVIT:
{$databaseContext}

PERTANYAAN MANAGER: \"{$userPrompt}\"

ANALISIS ANDA (berdasarkan data di atas):";

// Prepare data for Gemini API
$data = [
    'contents' => [
        [
            'parts' => [
                ['text' => $finalPrompt]
            ]
        ]
    ],
    'generationConfig' => [
        'temperature' => 0.7,
        'topK' => 40,
        'topP' => 0.95,
        'maxOutputTokens' => 2048,
    ]
];

$jsonData = json_encode($data);

// Send request to Gemini API
$ch = curl_init($apiUrl);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonData);
curl_setopt($ch, CURLOPT_TIMEOUT, 30);

$response = curl_exec($ch);
$httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

if (curl_errno($ch)) {
    echo json_encode(['error' => 'Koneksi ke AI gagal: ' . curl_error($ch)]);
    curl_close($ch);
    exit;
}
curl_close($ch);

// Process response
if ($httpcode == 200) {
    $result = json_decode($response, true);
    if (isset($result['error'])) {
        echo json_encode(['error' => 'AI Error: ' . $result['error']['message']]);
    } else {
        $aiReply = $result['candidates'][0]['content']['parts'][0]['text'] ?? 'Maaf, tidak mendapat respons yang valid dari AI.';
        echo json_encode(['reply' => $aiReply]);
    }
} else {
    $errorDetails = json_decode($response, true);
    $errorMessage = $errorDetails['error']['message'] ?? "HTTP Error {$httpcode}";
    echo json_encode(['error' => $errorMessage]);
}

$conn->close();
?>
