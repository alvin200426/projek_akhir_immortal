import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormEditPage extends StatefulWidget {
  final Map<String, dynamic> penilaian;

  const FormEditPage({super.key, required this.penilaian});

  @override
  State<FormEditPage> createState() => _FormEditPageState();
}

class _FormEditPageState extends State<FormEditPage> {
  late TextEditingController bulanController;
  late TextEditingController kedisiplinanController;
  late TextEditingController produktivitasController;
  late TextEditingController kualitasKerjaController;
  late TextEditingController kerjasamaTimController;
  late TextEditingController komentarController;

  @override
  void initState() {
    super.initState();
    bulanController = TextEditingController(text: widget.penilaian['bulan']);
    kedisiplinanController = TextEditingController(
        text: widget.penilaian['kedisiplinan'].toString());
    produktivitasController = TextEditingController(
        text: widget.penilaian['produktivitas'].toString());
    kualitasKerjaController = TextEditingController(
        text: widget.penilaian['kualitas_kerja'].toString());
    kerjasamaTimController = TextEditingController(
        text: widget.penilaian['kerjasama_tim'].toString());
    komentarController =
        TextEditingController(text: widget.penilaian['komentar'] ?? '');
  }

  @override
  void dispose() {
    bulanController.dispose();
    kedisiplinanController.dispose();
    produktivitasController.dispose();
    kualitasKerjaController.dispose();
    kerjasamaTimController.dispose();
    komentarController.dispose();
    super.dispose();
  }

  Future<void> updatePenilaian() async {
    final response = await http.post(
      Uri.parse('http://localhost/penilaian_kinerja/edit_penilaian.php'),
      body: {
        'id': widget.penilaian['id'].toString(),
        'nama_pegawai': widget.penilaian['nama_pegawai'],
        'bulan': bulanController.text,
        'kedisiplinan': kedisiplinanController.text,
        'produktivitas': produktivitasController.text,
        'kualitas_kerja': kualitasKerjaController.text,
        'kerjasama_tim': kerjasamaTimController.text,
        'komentar': komentarController.text,
      },
    );

    final jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Berhasil mengupdate data')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal update: ${jsonResponse['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text("Edit Penilaian"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
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
                  Text(
                    "Nama Pegawai: ${widget.penilaian['nama_pegawai']}",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: bulanController,
                    decoration: const InputDecoration(
                      labelText: 'Bulan',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: kedisiplinanController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Kedisiplinan',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: produktivitasController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Produktivitas',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: kualitasKerjaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Kualitas Kerja',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: kerjasamaTimController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Kerjasama Tim',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: komentarController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Komentar',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: updatePenilaian,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Simpan Perubahan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
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
