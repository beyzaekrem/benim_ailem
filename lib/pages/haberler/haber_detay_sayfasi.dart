import 'package:flutter/material.dart';

class HaberDetaySayfasi extends StatefulWidget {
  final int ilkIndex;

  const HaberDetaySayfasi({Key? key, required this.ilkIndex}) : super(key: key);

  @override
  State<HaberDetaySayfasi> createState() => _HaberDetaySayfasiState();
}

class _HaberDetaySayfasiState extends State<HaberDetaySayfasi> {
  late PageController _pageController;

  final List<Map<String, String>> haberler = [
    {
      "baslik": "Tarıma Dev Destek",
      "tarih": "9 Temmuz 2025",
      "icerik": "Konya’da tarıma yönelik yeni destekler açıklandı..."
    },
    {
      "baslik": "STK Proje Başvurusu",
      "tarih": "8 Temmuz 2025",
      "icerik": "STK’lar için proje destek süreci başladı..."
    },
    {
      "baslik": "Yeni Tramvay Açıldı",
      "tarih": "7 Temmuz 2025",
      "icerik": "Yeni hat şehir hastanesi ve sanayi bölgesini bağlayacak..."
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.ilkIndex,
      viewportFraction: 0.9,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: const Color(0xFFFEB716),
          elevation: 0,
          automaticallyImplyLeading: false, // elle buton ekleyeceğiz
          flexibleSpace: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/picture/story_icon.png',
                        height: 40,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Haberin Detayları",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 48), // sağ boşluk dengesi
              ],
            ),
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        itemCount: haberler.length,
        itemBuilder: (context, index) {
          final haber = haberler[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: const Center(
                      child: Icon(Icons.image, size: 80, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      haber["tarih"] ?? "",
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      haber["baslik"] ?? "",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      haber["icerik"] ?? "",
                      style: const TextStyle(fontSize: 16),
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
