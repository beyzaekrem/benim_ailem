import 'package:flutter/material.dart';

class HaberKarti extends StatelessWidget {
  final String baslik;
  final int index;
  final List<Map<String, dynamic>> tumHaberler; // <--- güncellendi

  const HaberKarti({
    super.key,
    required this.baslik,
    required this.index,
    required this.tumHaberler,
  });

  @override
  Widget build(BuildContext context) {
    final haber = tumHaberler[index];

    return GestureDetector(
      onTap: () {
        // Habere tıklanınca detay sayfasına yönlendirme yapılabilir
        print("Seçilen haber: ${haber['baslik']}");
      },
      child: Card(
        color: Colors.amber[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.image, size: 40), // örnek görsel
              const SizedBox(height: 12),
              Text(
                haber['baslik'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                haber['tarih'] ?? '',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
