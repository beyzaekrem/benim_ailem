// lib/components/haberler_bolumu.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:benim_ailem/models/haber_model.dart';
import 'package:benim_ailem/services/haber_servisi.dart';
import 'package:benim_ailem/pages/right_drawer/haberler/haber_detay_sayfasi.dart';
import 'package:benim_ailem/pages/right_drawer/bildirimler_sayfasi.dart';

class HaberlerBolumu extends StatefulWidget {
  const HaberlerBolumu({super.key});

  @override
  State<HaberlerBolumu> createState() => _HaberlerBolumuState();
}

class _HaberlerBolumuState extends State<HaberlerBolumu> {
  final PageController _page = PageController(viewportFraction: 0.85); // kartları biraz dar göster
  int _current = 0;
  bool _loading = true;
  List<HaberModel> _haberler = [];

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  String _dateKey(String? raw) {
    if (raw == null || raw.isEmpty) return '0000-00-00';
    try {
      final s = raw.trim();
      if (RegExp(r'^\d{8}(\d{4})?$').hasMatch(s)) {
        final y = int.parse(s.substring(0, 4));
        final m = int.parse(s.substring(4, 6));
        final d = int.parse(s.substring(6, 8));
        return DateFormat('yyyy-MM-dd').format(DateTime(y, m, d));
      }
      final dt = DateTime.parse(s);
      return DateFormat('yyyy-MM-dd').format(dt);
    } catch (_) {
      return raw!;
    }
  }

  Future<void> _yukle() async {
    final list = await HaberServisi.getHaberListesi();
    list.sort((a, b) => _dateKey(b.haber_tarih).compareTo(_dateKey(a.haber_tarih)));
    setState(() {
      _haberler = list.take(3).toList();
      _loading = false;
    });
  }

  String? _firstImageUrl(List<dynamic>? list) {
    if (list == null) return null;
    for (final item in list) {
      if (item is String && item.trim().isNotEmpty) return item;
      if (item is Map && item['url'] is String && (item['url'] as String).isNotEmpty) {
        return item['url'] as String;
      }
    }
    return null;
  }

  void _go(int dir) {
    if (_haberler.isEmpty) return;
    final next = (_current + dir).clamp(0, _haberler.length - 1);
    _page.animateToPage(next, duration: const Duration(milliseconds: 280), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Başlık + alt çizgi (metnin hemen altında) + Tümü
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Haberler',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFEB716),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 110, // Hava Durumu ile orantılı
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEB716),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BildirimlerSayfasi(aktifSekmeIndex: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.grid_view_rounded, color: Color(0xFFF3BE38)),
                label: const Text(
                  'Tümü',
                  style: TextStyle(color: Color(0xFFF3BE38), fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),

        if (_loading)
          const SizedBox(height: 220, child: Center(child: CircularProgressIndicator()))
        else if (_haberler.isEmpty)
          const SizedBox(height: 220, child: Center(child: Text('Gösterilecek haber bulunamadı')))
        else
          Column(
            children: [
              SizedBox(
                height: 210,
                child: Stack(
                  children: [
                    // Slider
                    PageView.builder(
                      controller: _page,
                      itemCount: _haberler.length,
                      onPageChanged: (i) => setState(() => _current = i),
                      itemBuilder: (context, index) {
                        final h = _haberler[index];
                        final img = _firstImageUrl(h.haber_ust_resim);
                        final heroTag = 'anasayfa_haber_${h.haber_id ?? index}';

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => HaberDetaySayfasi(haber: h)),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x1A000000),
                                    blurRadius: 16,
                                    offset: Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(22),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    if (img != null)
                                      Hero(
                                        tag: heroTag,
                                        child: Image.network(
                                          img,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              Container(color: const Color(0xFFEDEDED)),
                                        ),
                                      )
                                    else
                                      Container(color: const Color(0xFFEDEDED)),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: 70,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFF9D27A),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          h.haber_baslik ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    // Şeffaf dairesiz (sadece ikon) ok butonları
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _CircleNavButton(
                              icon: Icons.chevron_left,
                              enabled: _current > 0,
                              onTap: _current > 0 ? () => _go(-1) : null,
                            ),
                            _CircleNavButton(
                              icon: Icons.chevron_right,
                              enabled: _current < _haberler.length - 1,
                              onTap: _current < _haberler.length - 1 ? () => _go(1) : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Nokta indikatörü
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_haberler.length, (i) {
                  final aktif = i == _current;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: aktif ? 10 : 7,
                    height: aktif ? 10 : 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: aktif ? const Color(0xFFF3BE38) : Colors.grey[400],
                    ),
                  );
                }),
              ),
            ],
          ),
      ],
    );
  }
}

class _CircleNavButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;

  const _CircleNavButton({
    required this.icon,
    required this.enabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = enabled ? Colors.white : Colors.white.withOpacity(0.4);

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Icon(
          icon,
          size: 28,
          color: iconColor,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}
