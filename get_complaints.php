<?php
require 'koneksi.php';
header('Content-Type: application/json');

// Map nama bulan ke angka
$monthMap = [
  'januari' => 1,
  'februari' => 2,
  'maret' => 3,
  'april' => 4,
  'mei' => 5,
  'juni' => 6,
  'juli' => 7,
  'agustus' => 8,
  'september' => 9,
  'oktober' => 10,
  'november' => 11,
  'desember' => 12
];


$bulan = $_GET['month'] ?? 'januari';
$bulanNum = $monthMap[strtolower($bulan)] ?? 1;
$tahun = 2025;

// Nama-nama keluhan
$complaintTypes = [
  'energy' => 'Kelelahan Kronis',
  'weight' => 'Obesitas',
  'digestion' => 'Gangguan Pencernaan',
  'immunity' => 'Imunitas Rendah',
  'sleep' => 'Stress & Insomnia',
  'other' => 'Lainnya'
];

// Ambil data dari database
$sql = "
  SELECT complaint_type, COUNT(*) as total
  FROM user_complaints
  WHERE MONTH(created_at) = ? AND YEAR(created_at) = ?
  GROUP BY complaint_type
";

$stmt = $conn->prepare($sql);
$stmt->bind_param("ii", $bulanNum, $tahun);
$stmt->execute();
$result = $stmt->get_result();

// Inisialisasi semua jenis dengan nilai 0
$dataMap = [];
foreach ($complaintTypes as $key => $label) {
  $dataMap[$key] = 0;
}

// Timpa nilai berdasarkan hasil query
$total = 0;
while ($row = $result->fetch_assoc()) {
  $type = $row['complaint_type'];
  $count = (int)$row['total'];
  $dataMap[$type] = $count;
  $total += $count;
}

// Bentuk array hasil akhir
$finalData = [];
foreach ($complaintTypes as $key => $label) {
  $count = $dataMap[$key];
  $percentage = $total > 0 ? round(($count / $total) * 100, 1) : 0;
  $finalData[] = [
    'label' => $label,
    'count' => $count,
    'percentage' => $percentage
  ];
}

// Tentukan keluhan tertinggi
usort($finalData, fn($a, $b) => $b['count'] - $a['count']);
$top = $finalData[0];

echo json_encode([
  'labels' => array_column($finalData, 'label'),
  'data' => array_column($finalData, 'count'),
  'percentages' => array_column($finalData, 'percentage'),
  'total' => $total,
  'topComplaint' => $total > 0 ? $top['label'] . ' (' . $top['percentage'] . '%)' : 'Tidak ada data'
]);

$stmt->close();
$conn->close();
?>
