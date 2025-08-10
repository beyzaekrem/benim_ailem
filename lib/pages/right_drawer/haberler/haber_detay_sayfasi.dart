import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../models/haber_model.dart';

class HaberDetaySayfasi extends StatelessWidget {
  final HaberModel haber;
  const HaberDetaySayfasi({super.key, required this.haber});

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

  List<String> _allImageUrls(List<dynamic>? list) {
    if (list == null) return [];
    final urls = <String>[];
    for (final item in list) {
      if (item is String && item.trim().isNotEmpty) urls.add(item);
      if (item is Map && item['url'] is String && (item['url'] as String).isNotEmpty) {
        urls.add(item['url'] as String);
      }
    }
    return urls;
  }

  String _formatDateSmart(String? raw) {
    if (raw == null || raw.trim().isEmpty) return '';
    try {
      final s = raw.trim();
      if (RegExp(r'^\d{8}(\d{4})?$').hasMatch(s)) {
        final y = int.parse(s.substring(0, 4));
        final m = int.parse(s.substring(4, 6));
        final d = int.parse(s.substring(6, 8));
        return DateFormat('dd.MM.yyyy', 'tr_TR').format(DateTime(y, m, d));
      }
      return DateFormat('dd.MM.yyyy', 'tr_TR').format(DateTime.parse(s));
    } catch (_) {
      return raw!;
    }
  }

  void _openImageGallery(BuildContext context, List<String> images, int initialIndex) {
    showDialog(
      context: context,
      builder: (_) {
        PageController controller = PageController(initialPage: initialIndex);
        int currentIndex = initialIndex;

        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.black,
              insetPadding: EdgeInsets.zero,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: controller,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: InteractiveViewer(
                          child: Image.network(
                            images[index],
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => Container(
                              color: const Color(0xFF000000),
                              alignment: Alignment.center,
                              child: const Icon(Icons.image_not_supported, color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 40,
                    right: 20,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 30),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${currentIndex + 1} / ${images.length}',
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final heroTag = 'haber_${haber.haber_id}';
    final topImage = _firstImageUrl(haber.haber_ust_resim);
    final detayResimler = _allImageUrls(haber.haber_detay_resim);
    final tarih = _formatDateSmart(haber.haber_tarih);
    final haberUrl = (haber.haber_url ?? '').trim();

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/picture/benimailemlogo.png', height: 36),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          if (haberUrl.isNotEmpty)
            IconButton(
              tooltip: 'Bağlantıyı kopyala',
              icon: const Icon(Icons.link),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: haberUrl));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Haber bağlantısı kopyalandı')),
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (topImage != null)
              Hero(
                tag: heroTag,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(topImage, fit: BoxFit.cover),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    haber.haber_baslik ?? '',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, height: 1.2),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tarih,
                    style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280), fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  if ((haber.haber_spot ?? '').isNotEmpty)
                    Text(
                      haber.haber_spot ?? '',
                      style: const TextStyle(fontSize: 15, height: 1.55, fontWeight: FontWeight.w600),
                    ),
                  if ((haber.haber_spot ?? '').isNotEmpty) const SizedBox(height: 12),
                  SelectableText(
                    haber.haber_metin ?? '',
                    style: const TextStyle(fontSize: 15, height: 1.6, color: Color(0xFF333333)),
                  ),
                  const SizedBox(height: 24),

                  // Ek detay resimler
                  if (detayResimler.isNotEmpty) ...[
                    const Text(
                      'Diğer Görseller',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 180,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: detayResimler.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final imageUrl = detayResimler[index];
                          return GestureDetector(
                            onTap: () => _openImageGallery(context, detayResimler, index),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                imageUrl,
                                height: 180,
                                width: 240,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: const Color(0xFFF2F2F2),
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.image_not_supported),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
