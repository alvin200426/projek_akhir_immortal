<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: POST");
$koneksi = mysqli_connect("localhost", "root", "", "penilaian_kinerja");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nama = $_POST['nama'];
    $bulan = $_POST['bulan'];
    $kedisiplinan = $_POST['kedisiplinan'];
    $produktivitas = $_POST['produktivitas'];
    $kualitas_kerja = $_POST['kualitas_kerja'];
    $kerjasama_tim = $_POST['kerjasama_tim'];
    $total_nilai = $_POST['skor']; // ambil dari frontend
    $komentar = $_POST['komentar'];

    $tanggal_input = date('Y-m-d');

    $query = "INSERT INTO penilaian_pegawai 
    (nama_pegawai, bulan, kedisiplinan, produktivitas, kualitas_kerja, kerjasama_tim, total_nilai, komentar, tanggal_input)
    VALUES 
    ('$nama', '$bulan', '$kedisiplinan', '$produktivitas', '$kualitas_kerja', '$kerjasama_tim', '$total_nilai', '$komentar', '$tanggal_input')";

    if (mysqli_query($koneksi, $query)) {
        echo "Berhasil";
    } else {
        echo "Gagal: " . mysqli_error($koneksi);
    }
} else {
    echo "Metode tidak diizinkan";
}
?>
