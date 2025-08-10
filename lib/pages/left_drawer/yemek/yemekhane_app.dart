import 'package:flutter/material.dart';
import 'yemekhane_menusu_sayfasi.dart';

class YemekhaneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yemekhane Menüsü',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: YemekhaneMenusuSayfasi(),
    );
  }
}
