<?php
header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');

// Koneksi ke database
$conn = new mysqli("localhost", "root", "", "penilaian_kinerja");
if ($conn->connect_error) {
    die(json_encode(["error" => "Koneksi gagal: " . $conn->connect_error]));
}

$bulan = isset($_GET['bulan']) ? $_GET['bulan'] : null;

// Mulai query dasar
$sql = "SELECT * FROM penilaian_pegawai";

// Tambahkan filter jika bulan dipilih
if ($bulan) {
    $sql .= " WHERE bulan = ? ORDER BY total_nilai DESC";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $bulan);
} else {
    $sql .= " ORDER BY bulan DESC, total_nilai DESC";
    $stmt = $conn->prepare($sql);
}

$stmt->execute();
$result = $stmt->get_result();

$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode($data);
$conn->close();
?>
