<?php

// --- Konfigurasi Database ---
$servername = "127.0.0.1";
$username   = "root";
$password   = "";
$dbname     = "nutrivit";

// --- Membuat Koneksi ---
$conn = new mysqli($servername, $username, $password, $dbname);

// --- Memeriksa Koneksi ---
if ($conn->connect_error) {
    die("Koneksi ke database gagal: " . $conn->connect_error);
}

// Mengatur character set ke utf8mb4
if (!$conn->set_charset("utf8mb4")) {
    die("Error mengatur charset: " . $conn->error);
}

// Koneksi berhasil, siap digunakan

?>
