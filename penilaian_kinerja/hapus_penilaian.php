<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

include 'koneksi.php';

// Coba cek langsung isi POST
if (!isset($_POST['id'])) {
    echo json_encode(["status" => "error", "message" => "ID tidak dikirim"]);
    exit();
}

$id = $_POST['id'];

$sql = "DELETE FROM penilaian_pegawai WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id);

if ($stmt->execute()) {
    echo json_encode(["status" => "success", "message" => "Data berhasil dihapus"]);
} else {
    echo json_encode(["status" => "error", "message" => $conn->error]);
}
?>