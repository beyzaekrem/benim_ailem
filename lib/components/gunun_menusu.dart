import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GununMenusuWidget extends StatefulWidget {
  const GununMenusuWidget({super.key});

  @override
  _GununMenusuWidgetState createState() => _GununMenusuWidgetState();
}

class _GununMenusuWidgetState extends State<GununMenusuWidget> {
  DateTime secilenTarih = DateTime.now();

  // Örnek menüler
  Map<String, List<String>> menuler = {
    '2025-07-23': [
      'Çorba: Mercimek',
      'Ana Yemek: Tavuk Sote',
      'Salata: Çoban Salata',
      'Tatlı: Kazandibi',
    ],
    '2025-07-24': [
      'Çorba: Ezogelin',
      'Ana Yemek: Karnıyarık',
      'Pilav: Bulgur Pilavı',
      'Tatlı: Sütlaç',
    ],
  };

  List<String> get gununMenusu {
    final key = secilenTarih.toIso8601String().substring(0, 10);
    return menuler[key] ?? ['Menü bulunamadı'];
  }

  void _tarihSec(BuildContext context) async {
    DateTime? yeniTarih = await showDatePicker(
      context: context,
      initialDate: secilenTarih,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
      locale: const Locale('tr', 'TR'),
    );

    if (yeniTarih != null && yeniTarih != secilenTarih) {
      setState(() {
        secilenTarih = yeniTarih;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık + alt çizgi + sağda takvim butonu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Başlık ve alt çizgi
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Günün Menüsü',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFEB716),
                    ),
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    width: 140,
                    height: 4,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0xFFFEB716),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                    ),
                  ),
                ],
              ),
              // Sağda takvim seçici butonu
              Row(
                children: [
                  Text(
                    '${secilenTarih.day}.${secilenTarih.month}.${secilenTarih.year}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFEB716),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _tarihSec(context),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Menü görseli + içerikler
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/picture/gunun_menusu.png',
                  height: 200,
                  width: screenWidth,
                  fit: BoxFit.contain,
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: Column(
                    key: ValueKey(secilenTarih.toIso8601String()),
                    mainAxisSize: MainAxisSize.min,
                    children: gununMenusu
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color.from(alpha: 0.867, red: 0, green: 0, blue: 0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
