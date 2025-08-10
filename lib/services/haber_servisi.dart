//backend ile frontend arasındaki haberleşmeyi sağlayan servis
//api istek yaparak gelen işlemleri ön yüze yansıtacağız.
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/haber_model.dart';

class HaberServisi {
  final String url = "https://api.konya.bel.tr/apigateway/kurumsal-api/son-haberler";

  const HaberServisi();

  static Future<List<HaberModel>> getHaberListesi() async {
    try {
      final response = await http.post(
        Uri.parse("https://api.konya.bel.tr/apigateway/kurumsal-api/son-haberler"),
        headers: {
          'username': 'dev_staj_2025',
          'password': '3e07c1e1-b3fd-4a46-934b-85a5b7c414f4',
          'Content-Type': 'application/json',
        },
      );

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        var list = data.map((item) {
          return HaberModel.fromJson(item);
        }).toList();
        return list;
      } 
      else 
      {
        throw Exception('Failed to load haber listesi: ${response.statusCode}');
      }
    } 
    catch (e) 
    {
      print('Error fetching haber listesi: $e');
      return [];
    }
  }

}