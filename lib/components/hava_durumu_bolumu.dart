import 'package:flutter/material.dart';
import 'package:benim_ailem/services/hava_durumu_servisi.dart';

class HavaDurumuBolumu extends StatefulWidget {
  @override
  _HavaDurumuBolumuState createState() => _HavaDurumuBolumuState();
}

class _HavaDurumuBolumuState extends State<HavaDurumuBolumu> {
  Map<String, dynamic>? havaDurumu;

  @override
  void initState() {
    super.initState();
    veriyiGetir();
  }

  void veriyiGetir() async {
    final servis = HavaDurumuServisi();
    final veri = await servis.bugununHavaDurumuGetir();

    if (veri != null) {
      setState(() {
        havaDurumu = veri;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Başlık + çizgi
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hava Durumu',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFEB716),
                ),
              ),
              SizedBox(height: 4),
              SizedBox(
                width: 130,
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
        ),

        const SizedBox(height: 8),

        // İçerik
        havaDurumu == null
            ? const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              )
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                height: 150,
                child: Stack(
                  children: [
                    // Arka plan
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/picture/hava_arka_plan.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black.withOpacity(0.3),
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                    // İçerik kutusu
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Sol taraf: şehir ve tarih
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Konya",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              Text(
                                "${DateTime.now().day} ${_ayAdi(DateTime.now().month)} ${DateTime.now().year}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          // Sağ taraf: ikon + sıcaklık + durum (yan yana)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/picture/${havaDurumu!["ikon"]}@2x.png",
                                width: 48,
                                height: 48,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.cloud_off, color: Colors.white, size: 48),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${havaDurumu!["sicaklik"]}°C",
                                    style: const TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  Text(
                                    "${havaDurumu!["durum"]}",
                                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  String _ayAdi(int ay) {
    const aylar = [
      "", "Ocak", "Şubat", "Mart", "Nisan", "Mayıs", "Haziran",
      "Temmuz", "Ağustos", "Eylül", "Ekim", "Kasım", "Aralık"
    ];
    return aylar[ay];
  }
}
