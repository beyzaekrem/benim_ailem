import 'package:flutter/material.dart';

class BildirimDetaySayfasi extends StatelessWidget {
  final String baslik;
  final String aciklama;
  final String tarih;

  const BildirimDetaySayfasi({
    super.key,
    required this.baslik,
    required this.aciklama,
    required this.tarih,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(baslik, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(aciklama, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            Text(tarih, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
