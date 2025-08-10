import 'package:flutter/material.dart';
import 'package:benim_ailem/splash/splash_video_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'services/haber_servisi.dart';

void main() async {
  final liste = await HaberServisi.getHaberListesi();
  runApp(BenimAilemApp());
}

class BenimAilemApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Benim Ailem',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('tr', 'TR')],
      theme: ThemeData(primarySwatch: Colors.amber),
      home: SplashVideoPage(),
    );
  }
}

//0xFFFEB716 koyu sarı
//0xFFFFDEA5 açık sarı
