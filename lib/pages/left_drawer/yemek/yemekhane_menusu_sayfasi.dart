import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:benim_ailem/widgets/CustomAppBar.dart';

class YemekhaneMenusuSayfasi extends StatefulWidget {
  @override
  _YemekhaneMenusuSayfasiState createState() => _YemekhaneMenusuSayfasiState();
}

class _YemekhaneMenusuSayfasiState extends State<YemekhaneMenusuSayfasi> {
  int seciliIndex = 0;

  final List<Map<String, dynamic>> gunlukMenu = [
    {
      "tarih": DateTime(2025, 1, 6),
      "menu": ["Mercimek Çorbası", "Tavuk Sote", "Pilav"]
    },
    {
      "tarih": DateTime(2025, 1, 7),
      "menu": ["Ezogelin Çorbası", "Karnıyarık", "Bulgur"]
    },
    {
      "tarih": DateTime(2025, 1, 8),
      "menu": ["Domates Çorbası", "Köfte", "Patates Püre"]
    },
    {
      "tarih": DateTime(2025, 1, 9),
      "menu": ["Tarhana Çorbası", "Makarna", "Yoğurt"]
    },
    {
      "tarih": DateTime(2025, 1, 10),
      "menu": []
    },
  ];

  @override
  Widget build(BuildContext context) {
    final seciliGun = gunlukMenu[seciliIndex];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Yemekhane Menüsü'),
      

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔼 Gün Butonları
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              children: List.generate(gunlukMenu.length, (index) {
                final gun = gunlukMenu[index];
                final isSelected = index == seciliIndex;
                final tarih = gun["tarih"] as DateTime;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        seciliIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.amber : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            DateFormat('d').format(tarih),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat('E', 'tr_TR').format(tarih),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const Divider(thickness: 1),

          // 🔽 Gün Bilgisi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "${DateFormat('EEEE', 'tr_TR').format(seciliGun['tarih'])} - ${DateFormat('d MMMM y', 'tr_TR').format(seciliGun['tarih'])}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 12),

          // 🔽 Menü İçeriği
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: seciliGun["menu"].isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.no_food, size: 48, color: Colors.grey),
                          SizedBox(height: 8),
                          Text(
                            "Bugün menü bulunamadı.",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: seciliGun["menu"].length,
                      itemBuilder: (context, index) {
                        final yemek = seciliGun["menu"][index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 6,
                                offset: const Offset(2, 3),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.restaurant_menu,
                                  color: Color(0xFFFEB716)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(yemek,
                                    style: const TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),

          const SizedBox(height: 12),

          // 📌 Alt Bilgi
          Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Column(
                children: const [
                  Text("Yemekhane çalışma saatleri",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("12:00 – 14:00", style: TextStyle(color: Colors.black54)),
                  SizedBox(height: 6),
                  Text("Konum: Belediye A Blok - 1. Kat",
                      style: TextStyle(color: Colors.black45)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
