import 'package:flutter/material.dart';
import 'package:benim_ailem/pages/duyurular/bildirimler_sayfasi.dart';
import 'package:benim_ailem/services/bildirim_servisi.dart';

class HaberlerBolumu extends StatefulWidget {
  const HaberlerBolumu({super.key});

  @override
  State<HaberlerBolumu> createState() => _HaberlerBolumuState();
}

class _HaberlerBolumuState extends State<HaberlerBolumu> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, dynamic>> getSon3Haber() {
    final List<Map<String, dynamic>> tumHaberler = List.from(BildirimServisi.haberler);
    tumHaberler.sort((a, b) => b['tarih'].compareTo(a['tarih']));
    return tumHaberler.take(3).toList();
  }

  void _goToPage(int index, int maxLength) {
    if (index >= 0 && index < maxLength) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final haberler = getSon3Haber();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Haberler',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFEB716),
                    ),
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    width: 90,
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BildirimlerSayfasi(aktifSekmeIndex: 2),
                    ),
                  );
                },
                child: Row(
                  children: const [
                    Icon(Icons.grid_view, size: 20, color: Color(0xFFFEB716)),
                    SizedBox(width: 4),
                    Text(
                      'Tümü',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFEB716),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => _goToPage(_currentPage - 1, haberler.length),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() {
                    _currentPage = index;
                  }),
                  itemCount: haberler.length,
                  itemBuilder: (context, index) {
                    final haber = haberler[index];
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: const Color(0xFFFFDEA5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 90,
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            child: const Center(
                              child: Icon(Icons.image, size: 40, color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              child: Center(
                                child: Text(
                                  haber['baslik'] ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              width: 40,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () => _goToPage(_currentPage + 1, haberler.length),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            haberler.length,
            (index) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? const Color(0xFFFEB716) : Colors.grey[400],
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
