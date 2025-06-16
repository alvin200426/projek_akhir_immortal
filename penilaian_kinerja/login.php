<?php
// Aktifkan CORS untuk semua origin (jangan digunakan di produksi)
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST");

// Lanjutkan dengan kode PHP kamu
include 'koneksi.php';

$username = $_POST['username'];
$password = md5($_POST['password']); // atau password_hash() kalau versi aman

$query = "SELECT * FROM users WHERE username = '$username' AND password = '$password'";
$result = mysqli_query($conn, $query);
$data = mysqli_fetch_assoc($result);

if ($data) {
    echo json_encode([
        "success" => true,
        "user" => [
            "id" => $data['id'],
            "username" => $data['username'],
            "role" => $data['role'],
        ]
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Login gagal. Periksa kembali username dan password."
    ]);
}
?>
