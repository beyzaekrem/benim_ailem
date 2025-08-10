// lib/widgets/haber_karti.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/haber_model.dart';

class HaberKarti extends StatelessWidget {
  final HaberModel haber;
  final VoidCallback? onTap;

  const HaberKarti({super.key, required this.haber, this.onTap});

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
        final dt = DateTime(y, m, d);
        return DateFormat('dd.MM.yyyy', 'tr_TR').format(dt);
      }
      final dt = DateTime.parse(s);
      return DateFormat('dd.MM.yyyy', 'tr_TR').format(dt);
    } catch (_) {
      return raw!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = _firstImageUrl(haber.haber_ust_resim);
    final tarih = _formatDateSmart(haber.haber_tarih);
    final heroTag = 'haber_${haber.haber_id ?? ''}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              blurRadius: 18,
              offset: Offset(0, 8),
              color: Color(0x1A000000),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      imageUrl,
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
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    haber.haber_baslik ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    (haber.haber_spot ?? '').isNotEmpty
                        ? (haber.haber_spot ?? '')
                        : (haber.haber_metin ?? ''),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.45,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        tarih,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF6B7280), 
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
