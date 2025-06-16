import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InputPenilaianPage extends StatefulWidget {
  @override
  InputPenilaianPageState createState() => InputPenilaianPageState();
}

class InputPenilaianPageState extends State<InputPenilaianPage> {
  final namaController = TextEditingController();
  final komentarController = TextEditingController();

  String selectedBulan = 'Januari';
  int kedisiplinan = 5;
  int produktivitas = 5;
  int kualitasKerja = 5;
  int kerjasamaTim = 5;
  int skor = 10;

  void updateSkor() {
    setState(() {
      skor = ((kedisiplinan + produktivitas + kualitasKerja + kerjasamaTim) / 2).round();
    });
  }

  Future<void> submitPenilaian() async {
    final url = Uri.parse('http://localhost/penilaian_kinerja/tambah_penilaian.php');

    final response = await http.post(url, body: {
      'nama': namaController.text,
      'bulan': selectedBulan,
      'kedisiplinan': kedisiplinan.toString(),
      'produktivitas': produktivitas.toString(),
      'kualitas_kerja': kualitasKerja.toString(),
      'kerjasama_tim': kerjasamaTim.toString(),
      'komentar': komentarController.text,
      'skor': skor.toString(),
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil dikirim!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengirim data')),
      );
    }
  }

  Widget buildDropdown(String label, int value, Function(int?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          DropdownButton<int>(
            value: value,
            items: [5, 4, 3, 2, 1].map((val) {
              return DropdownMenuItem(
                value: val,
                child: Text('$val'),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text("Input Penilaian"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextField(
                    controller: namaController,
                    decoration: InputDecoration(
                      labelText: 'Nama Pegawai',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Bulan',
                      border: OutlineInputBorder(),
                    ),
                    isExpanded: true,
                    value: selectedBulan,
                    items: [
                      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
                      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
                    ].map((bulan) => DropdownMenuItem(
                          value: bulan,
                          child: Text(bulan),
                        )).toList(),
                    onChanged: (val) => setState(() => selectedBulan = val!),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Kriteria Penilaian:\n"
                    "5 = Sangat Baik, 4 = Baik, 3 = Cukup, 2 = Kurang, 1 = Sangat Kurang",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12),
                  buildDropdown("Kedisiplinan", kedisiplinan, (val) {
                    kedisiplinan = val!;
                    updateSkor();
                  }),
                  buildDropdown("Produktivitas", produktivitas, (val) {
                    produktivitas = val!;
                    updateSkor();
                  }),
                  buildDropdown("Kualitas Kerja", kualitasKerja, (val) {
                    kualitasKerja = val!;
                    updateSkor();
                  }),
                  buildDropdown("Kerja Sama Tim", kerjasamaTim, (val) {
                    kerjasamaTim = val!;
                    updateSkor();
                  }),
                  SizedBox(height: 16),
                  Text(
                    "Skor Total: $skor",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: komentarController,
                    decoration: InputDecoration(
                      labelText: 'Komentar',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: submitPenilaian,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Simpan Penilaian",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
