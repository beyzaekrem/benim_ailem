// lib/pages/right_drawer/haberler/haber_detay_sayfasi.dart
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

  @override
  Widget build(BuildContext context) {
    final heroTag = 'haber_${haber.haber_id}';
    final topImage = _firstImageUrl(haber.haber_ust_resim);
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
                // ignore: use_build_context_synchronously
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
                  child: Image.network(
                    topImage,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFF2F2F2),
                      alignment: Alignment.center,
                      child: const Icon(Icons.image_not_supported),
                    ),
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: const Color(0xFFF2F2F2),
                        alignment: Alignment.center,
                        child: const SizedBox(
                          width: 28, height: 28, child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Başlık
                  Text(
                    haber.haber_baslik ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Tarih
                  Text(
                    tarih,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  // Spot (varsa)
                  if ((haber.haber_spot ?? '').isNotEmpty)
                    Text(
                      haber.haber_spot ?? '',
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.55,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  if ((haber.haber_spot ?? '').isNotEmpty) const SizedBox(height: 12),
                  // Metin
                  SelectableText(
                    haber.haber_metin ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
