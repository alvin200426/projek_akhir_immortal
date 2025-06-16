import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PenilaianList extends StatefulWidget {
  const PenilaianList({super.key});

  @override
  State<PenilaianList> createState() => _PenilaianListState();
}

class _PenilaianListState extends State<PenilaianList> {
  List penilaianData = [];
  String? _selectedBulan;

  final List<String> _bulanOptions = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
  ];

  Future<void> fetchData() async {
    try {
      final url = _selectedBulan == null
          ? 'http://localhost/penilaian_kinerja/get_penilaian.php'
          : 'http://localhost/penilaian_kinerja/get_penilaian.php?bulan=$_selectedBulan';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          penilaianData = data;
        });
      } else {
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void _onBulanChanged(String? value) {
    setState(() {
      _selectedBulan = value;
    });
    fetchData();
  }

  Widget buildSkalaPenilaian() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1976D2),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: const [
            Icon(Icons.info_outline, color: Colors.white),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Skala Skor Pegawai:\n'
                '1–2: Sangat Kurang | 3–4: Kurang | 5–6: Cukup | 7–8: Baik | 9–10: Sangat Baik',
                style: TextStyle(fontSize: 14.5, color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          "List Penilaian",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedBulan,
                hint: const Text("Bulan"),
                icon: const Icon(Icons.arrow_drop_down),
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                dropdownColor: Colors.white,
                items: _bulanOptions.map((String bulan) {
                  return DropdownMenuItem<String>(
                    value: bulan,
                    child: Text(bulan),
                  );
                }).toList(),
                onChanged: _onBulanChanged,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          buildSkalaPenilaian(),
          Expanded(
            child: penilaianData.isEmpty
                ? const Center(
                    child: Text(
                      "Tidak ada data",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    itemCount: penilaianData.length,
                    itemBuilder: (context, index) {
                      final item = penilaianData[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['nama_pegawai'],
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.score, size: 18, color: Colors.blue),
                                  const SizedBox(width: 6),
                                  Text(
                                    "Skor: ${item['total_nilai']}",
                                    style: const TextStyle(fontSize: 14.5),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.comment, size: 18, color: Colors.orange),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      "Komentar: ${item['komentar']}",
                                      style: const TextStyle(fontSize: 14.5),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
