import 'package:flutter/material.dart';

class VefatEdenlerSayfasi extends StatelessWidget {
  final List<String> vefatEdenler = [
    "Mehmet Kara",
    "Fatma Yıldız",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vefat Haberleri")),
      body: ListView.builder(
        itemCount: vefatEdenler.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.airline_seat_flat_angled, color: Colors.grey),
            title: Text(vefatEdenler[index]),
          );
        },
      ),
    );
  }
}