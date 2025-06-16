<?php
$host = "localhost";
$user = "root";
$password = "";
$database = "penilaian_kinerja";

// Membuat koneksi
$conn = new mysqli($host, $user, $password, $database);

// Cek koneksi
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}
?>
