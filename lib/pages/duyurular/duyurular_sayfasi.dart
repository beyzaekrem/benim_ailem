import 'package:flutter/material.dart';

class DuyurularSayfasi extends StatelessWidget {
  const DuyurularSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  Image.asset(
                    'assets/picture/benimailemlogo.png',
                    height: 40,
                  ),

                  const SizedBox(width: 40),
                ],
              ),
            ),

            // Buraya segmentli kontrol ve içerik kısmı eklenecek (sonraki adım)
          ],
        ),
      ),
    );
  }
}
