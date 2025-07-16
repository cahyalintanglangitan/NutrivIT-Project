<?php
require 'koneksi.php';

// Kata sandi asli dari database Anda
$plainPassword = 'admin123';
// Email manajer yang ingin diupdate
$managerEmail = 'goyoonjung@nutrivit.com';

// Buat hash dari kata sandi
$hashedPassword = password_hash($plainPassword, PASSWORD_DEFAULT);

// Update password di database dengan versi hash
$stmt = $conn->prepare("UPDATE manager SET password = ? WHERE email_manager = ?");
$stmt->bind_param("ss", $hashedPassword, $managerEmail);

if ($stmt->execute()) {
    echo "Password untuk " . $managerEmail . " berhasil di-hash dan di-update di database.<br>";
    echo "Anda sekarang dapat menghapus file ini (hash_password.php).";
} else {
    echo "Error updating record: " . $conn->error;
}

$stmt->close();
$conn->close();
?>