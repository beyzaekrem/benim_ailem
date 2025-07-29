import 'package:flutter/material.dart';
import 'haber_karti.dart';
import 'package:benim_ailem/services/bildirim_servisi.dart';

class HaberArsivSayfasi extends StatelessWidget {
  HaberArsivSayfasi({super.key});

  final List<Map<String, dynamic>> haberler = BildirimServisi.haberler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6FF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: const Color(0xFFFEB716),
          elevation: 0,
          automaticallyImplyLeading: false,
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
                        "Haberler",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: haberler.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 3 / 4,
          ),
          itemBuilder: (context, index) {
            return HaberKarti(
              baslik: haberler[index]['baslik'],
              index: index,
              tumHaberler: haberler,
            );
          },
        ),
      ),
    );
  }
}
