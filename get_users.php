<?php
include 'koneksi.php'; // pastikan file ini berisi koneksi DB

$query = "SELECT id, name, email, status, joining_date FROM users";
$result = $conn->query($query);

$users = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $users[] = $row;
    }
}

header('Content-Type: application/json');
echo json_encode($users);
?>
