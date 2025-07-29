import 'package:flutter/material.dart';

class DogumGunuSayfasi extends StatelessWidget {
  final List<String> dogumGunleri = [
    "Ahmet Yılmaz",
    "Elif Demir",
    "Zeynep Korkmaz",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doğum Günü Bugün Olan Çalışanlarımız")),
      body: ListView.builder(
        itemCount: dogumGunleri.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.cake, color: Colors.pink),
            title: Text(dogumGunleri[index]),
          );
        },
      ),
    );
  }
}