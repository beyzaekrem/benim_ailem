import 'package:flutter/material.dart';
import 'dogum_gunu.dart';
import 'evlenenler.dart';
import 'cocugu_olanlar.dart';
import 'vefat_edenler.dart';

class BugunBolumu extends StatefulWidget {
  const BugunBolumu({super.key});

  @override
  State<BugunBolumu> createState() => _BugunBolumuState();
}

class _BugunBolumuState extends State<BugunBolumu> {
  bool _gosterAltSecmeler = false;
  List<bool> _kutucukGoster = [false, false, false, false];

  void _animasyonuBaslat() {
    setState(() {
      _gosterAltSecmeler = true;
    });

    for (int i = 0; i < _kutucukGoster.length; i++) {
      Future.delayed(Duration(milliseconds: 150 * i), () {
        setState(() {
          _kutucukGoster[i] = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ekranGenisligi = MediaQuery.of(context).size.width;
    final kutucukSayisi = 4;
    const spacing = 8.0;
    final toplamSpacing = spacing * (kutucukSayisi - 1);
    final kutuGenisligi = (ekranGenisligi - 32 - toplamSpacing) / kutucukSayisi;
    const kutuYuksekligi = 60.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: ekranGenisligi - 32, // Hava durumu ile aynı genişlik
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFEB716),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
              ),
              onPressed: () {
                if (!_gosterAltSecmeler) {
                  _animasyonuBaslat();
                } else {
                  setState(() {
                    _gosterAltSecmeler = false;
                    _kutucukGoster = [false, false, false, false];
                  });
                }
              },
              child: const Text(
                "Bugüne Ait Bilgiler İçin Tıklayınız",
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _gosterAltSecmeler
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) {
                      final basliklar = ["Doğum Günü", "Evlenenler", "Çocuğu Olanlar", "Vefat Haberleri"];
                      final sayfalar = [
                        DogumGunuSayfasi(),
                        EvlenenlerSayfasi(),
                        CocuguOlanlarSayfasi(),
                        VefatEdenlerSayfasi()
                      ];
                      return AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: _kutucukGoster[index] ? 1 : 0,
                        child: _altKutucuk(context, basliklar[index], sayfalar[index], kutuGenisligi, kutuYuksekligi),
                      );
                    }),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _altKutucuk(BuildContext context, String baslik, Widget sayfa, double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => sayfa),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFDEA5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFFDEA5)),
          ),
          child: Center(
            child: Text(
              baslik,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
