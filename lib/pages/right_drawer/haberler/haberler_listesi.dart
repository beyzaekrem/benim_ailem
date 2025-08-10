import 'package:benim_ailem/pages/right_drawer/haberler/haber_detay_sayfasi.dart';
import 'package:flutter/material.dart';
import '../../../models/haber_model.dart';
import '../../../services/haber_servisi.dart';
import '../../../widgets/haber_karti.dart';

class HaberlerListesi extends StatefulWidget {
  const HaberlerListesi({super.key});

  @override
  State<HaberlerListesi> createState() => _HaberlerListesiState();
}

class _HaberlerListesiState extends State<HaberlerListesi> {
  late Future<List<HaberModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = HaberServisi.getHaberListesi();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HaberModel>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // basit loading – istersen skeleton ekleriz
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Haberler yüklenirken bir sorun oluştu.\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        final haberler = snapshot.data ?? [];
        if (haberler.isEmpty) {
          return const Center(child: Text('Gösterilecek haber bulunamadı.'));
        }

        // Tasarımını bozmamak için her haberi HaberKarti ile çiziyoruz
        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 24),
          itemCount: haberler.length,
          itemBuilder: (context, i) {
            final h = haberler[i];
            return HaberKarti(
              haber: h,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HaberDetaySayfasi(haber: h)),
                );
              },
            );

          },
        );
      },
    );
  }
}
