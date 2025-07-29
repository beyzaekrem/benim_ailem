import 'package:flutter/material.dart';
import 'bugun_veri.dart';

class BugunKutucugu extends StatelessWidget {
  final String baslik;

  const BugunKutucugu({required this.baslik, super.key});

  @override
  Widget build(BuildContext context) {
    final liste = bugunKutulari[baslik] ?? [];

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(baslik,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ...liste.map((item) => ListTile(title: Text(item))),
                if (liste.isEmpty)
                  const Text("Bugün için kayıt bulunamadı."),
              ],
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.amber.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(baslik, textAlign: TextAlign.center),
      ),
    );
  }
}
