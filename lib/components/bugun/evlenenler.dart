import 'package:flutter/material.dart';

class EvlenenlerSayfasi extends StatelessWidget {
  final List<String> evlenenler = [
    "Zeynep & Mert",
    "Gamze & Tolga",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bugün Evlenen Çalışanlarımız")),
      body: ListView.builder(
        itemCount: evlenenler.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.favorite, color: Colors.redAccent),
            title: Text(evlenenler[index]),
          );
        },
      ),
    );
  }
}