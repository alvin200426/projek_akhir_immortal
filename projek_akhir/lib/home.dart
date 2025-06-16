import 'package:flutter/material.dart';
import 'input_penilaian_page.dart';
import 'list_penilaian_page.dart';
import 'edit_hapus_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.assessment, color: Colors.black87),
            SizedBox(width: 8),
            Text(
              'Penilaian Kinerja',
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFF9F9F9), // latar belakang putih lembut
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeMenuButton(
                icon: Icons.edit,
                label: 'Input Penilaian',
                color: Color(0xFF1976D2), // biru terang
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InputPenilaianPage()),
                  );
                },
              ),
              SizedBox(height: 20),
              HomeMenuButton(
                icon: Icons.list,
                label: 'Lihat Data Penilaian',
                color: Color(0xFF1976D2),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PenilaianList()),
                  );
                },
              ),
              SizedBox(height: 20),
              HomeMenuButton(
                icon: Icons.delete_forever,
                label: 'Edit dan Hapus',
                color: Color(0xFF1976D2),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditHapusListPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeMenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const HomeMenuButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.color,
  });

  @override
  @override
Widget build(BuildContext context) {
  return Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500), // batas maksimum lebar 500px
      child: Container(
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
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton.icon(
            icon: Icon(icon, size: 26),
            label: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    ),
  );
}

}
