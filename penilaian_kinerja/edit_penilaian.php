<?php
header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');
include 'koneksi.php';

$id = $_POST['id'];
$nama = $_POST['nama_pegawai'];
$bulan = $_POST['bulan'];
$kedisiplinan = $_POST['kedisiplinan'];
$produktivitas = $_POST['produktivitas'];
$kualitas_kerja = $_POST['kualitas_kerja'];
$kerjasama_tim = $_POST['kerjasama_tim'];
$komentar = $_POST['komentar'];

$total = $kedisiplinan + $produktivitas + $kualitas_kerja + $kerjasama_tim;

$sql = "UPDATE penilaian_pegawai SET 
        nama_pegawai='$nama',
        bulan='$bulan',
        kedisiplinan=$kedisiplinan,
        produktivitas=$produktivitas,
        kualitas_kerja=$kualitas_kerja,
        kerjasama_tim=$kerjasama_tim,
        total_nilai=$total,
        komentar='$komentar'
        WHERE id=$id";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["status" => "success", "message" => "Data berhasil diupdate"]);
} else {
    echo json_encode(["status" => "error", "message" => $conn->error]);
}
?>
