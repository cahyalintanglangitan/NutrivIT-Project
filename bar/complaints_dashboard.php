<?php
session_start();
require_once '../database/koneksi.php';

$query = "SELECT uc.*, u.name, u.email 
          FROM user_complaints uc 
          LEFT JOIN users u ON uc.user_id = u.id 
          ORDER BY uc.created_at DESC";

$result = $conn->query($query);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Daftar Komplain</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">Daftar Komplain Pengguna</h2>
    <?php if ($result && $result->num_rows > 0): ?>
        <table class="table table-bordered table-hover bg-white">
            <thead class="thead-dark">
                <tr>
                    <th>Nama</th>
                    <th>Email</th>
                    <th>Jenis Komplain</th>
                    <th>Isi Komplain</th>
                    <th>Status</th>
                    <th>Tanggal</th>
                </tr>
            </thead>
            <tbody>
            <?php while ($row = $result->fetch_assoc()): ?>
                <tr>
                    <td><?= htmlspecialchars($row['name']) ?></td>
                    <td><?= htmlspecialchars($row['email']) ?></td>
                    <td><?= htmlspecialchars($row['complaint_type']) ?></td>
                    <td><?= htmlspecialchars($row['complaint_text']) ?></td>
                    <td><?= htmlspecialchars($row['status']) ?></td>
                    <td><?= htmlspecialchars($row['created_at']) ?></td>
                </tr>
            <?php endwhile; ?>
            </tbody>
        </table>
    <?php else: ?>
        <div class="alert alert-info">Belum ada komplain ditemukan di database.</div>
    <?php endif; ?>
</div>
</body>
</html>
