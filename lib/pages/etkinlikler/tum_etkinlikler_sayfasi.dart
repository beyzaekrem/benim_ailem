import 'package:flutter/material.dart';

class TumEtkinliklerSayfasi extends StatelessWidget {
  const TumEtkinliklerSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tüm Etkinlikler'),
        backgroundColor: Color(0xFFFEB716),
        foregroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Burada tüm etkinlikler listelenecek.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
