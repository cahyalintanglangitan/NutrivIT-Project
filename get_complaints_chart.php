<?php
require_once 'koneksi.php';

header('Content-Type: application/json');

// Ambil bulan dari query string (misalnya: "juli")
$month = isset($_GET['month']) ? $_GET['month'] : '';
$monthMap = [
  'januari' => '01', 'februari' => '02', 'maret' => '03',
  'april' => '04', 'mei' => '05', 'juni' => '06',
  'juli' => '07', 'agustus' => '08', 'september' => '09',
  'oktober' => '10', 'november' => '11', 'desember' => '12'
];

if (!array_key_exists($month, $monthMap)) {
  echo json_encode(['error' => 'Invalid month']);
  exit;
}

$selectedMonth = $monthMap[$month];
$currentYear = date('Y'); // misalnya 2025

// Query keluhan berdasarkan bulan
$sql = "
  SELECT complaint_type, COUNT(*) as total
  FROM user_complaints
  WHERE MONTH(created_at) = ? AND YEAR(created_at) = ?
  GROUP BY complaint_type
";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $selectedMonth, $currentYear);
$stmt->execute();
$result = $stmt->get_result();

$labels = [];
$data = [];
$total = 0;
$topComplaint = '';
$max = 0;

while ($row = $result->fetch_assoc()) {
  $labels[] = ucfirst($row['complaint_type']);
  $data[] = (int)$row['total'];
  $total += $row['total'];
  if ($row['total'] > $max) {
    $max = $row['total'];
    $topComplaint = ucfirst($row['complaint_type']);
  }
}

// Output data JSON
echo json_encode([
  'labels' => $labels,
  'data' => $data,
  'total' => $total,
  'topComplaint' => $topComplaint
]);
?>

