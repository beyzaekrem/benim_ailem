import 'package:flutter/material.dart';

class CocuguOlanlarSayfasi extends StatelessWidget {
  final List<String> yeniAnneBaba = [
    "Ayşe Aksoy",
    "Süleyman Koç",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yeni Ebeveyn Olan Çalışanlarımız")),
      body: ListView.builder(
        itemCount: yeniAnneBaba.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.child_friendly, color: Colors.blueAccent),
            title: Text(yeniAnneBaba[index]),
          );
        },
      ),
    );
  }
}