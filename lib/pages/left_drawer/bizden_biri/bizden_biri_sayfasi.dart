import 'package:flutter/material.dart';
import 'bizden_biri_detay_sayfasi.dart';

class BizdenBiriSayfasi extends StatelessWidget {
  final List<Map<String, String>> kisiler = [
    {
      "ad": "Zeynep Polat",
      "unvan": "Yazılımcı",
      "aciklama": "Zeynep Hanım 10 yıldır belediyede aktif projeler geliştiriyor.",
      "videoUrl": "https://www.youtube.com/watch?v=tRnopGEY0c0"
    },
    {
      "ad": "Ahmet Yılmaz",
      "unvan": "Şoför",
      "aciklama": "Ahmet Bey 20 yıldır Konya Büyükşehir’de ulaşım alanında çalışıyor.",
      "videoUrl": "https://www.youtube.com/watch?v=abc123"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bizden Biri"),
        backgroundColor: const Color(0xFFFEB716),
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: kisiler.length,
        itemBuilder: (context, index) {
          final kisi = kisiler[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${kisi['ad']} - ${kisi['unvan']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Container(
                    height: 180,
                    color: const Color(0xFFE0E0E0),
                    child: const Center(child: Icon(Icons.play_circle_outline, size: 60, color: Colors.black54)),
                  ),
                  const SizedBox(height: 12),
                  Text(kisi['aciklama'] ?? ""),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BizdenBiriDetaySayfasi(
                              ad: kisi['ad']!,
                              unvan: kisi['unvan']!,
                              aciklama: kisi['aciklama']!,
                              videoUrl: kisi['videoUrl']!,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text("Devamını Oku"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
