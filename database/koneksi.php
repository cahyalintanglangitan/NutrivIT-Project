<?php
$host = "localhost";
$user = "root";
$pass = "";
$db   = "nutrivit"; // Ganti jika nama database kamu berbeda

$koneksi = mysqli_connect($host, $user, $pass, $db);

if (!$koneksi) {
    die("Koneksi database gagal: " . mysqli_connect_error());
}
?>
