//backend ile frontend arasındaki haberleşmeyi sağlayan servis
//api istek yaparak gelen işlemleri ön yüze yansıtacağız.
import 'package:http/http.dart' as http;
import 'dart:convert';

class HaberServisi {
  final String url = "https://api.konya.bel.tr/apigateway/kurumsal-api/son-haberler";

  final String? haber_id;
  final String? haber_baslik;
  final String? haber_spot;
  final String? haber_metin;
  final String? haber_tarih;
  final String? haber_url;
  final String? haber_ust_resim;

  HaberServisi({this.haber_id, this.haber_baslik, this.haber_spot, this.haber_metin, this.haber_tarih, this.haber_url, this.haber_ust_resim});

  factory HaberServisi.fromJson(Map<String, dynamic> json) {
    return HaberServisi(
      haber_id: json['haber_id'] as String?,
      haber_baslik: json['haber_baslik'] as String?,
      haber_spot: json['haber_spot'] as String?,
      haber_metin: json['haber_metin'] as String?,
      haber_tarih: json['haber_tarih'] as String?,
      haber_url: json['haber_url'] as String?,
      haber_ust_resim: json['haber_ust_resim'] as String?,
    );
  }

  static Future<List<HaberServisi>> getHaberListesi() async {
    try {
      final response = await http.post(
        Uri.parse("https://api.konya.bel.tr/apigateway/kurumsal-api/son-haberler"),
        headers: {
          'username': 'dev_staj_2025',
          'password': '3e07c1e1-b3fd-4a46-934b-85a5b7c414f4',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'text': 'a' 
        }),
      );

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => HaberServisi.fromJson(item)).toList();
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
void main() async {
  final liste = await HaberServisi.getHaberListesi();
  for (var kisi in liste) {
    print('${kisi.haber_id} - ${kisi.haber_baslik} - ${kisi.haber_spot} - ${kisi.haber_metin} - ${kisi.haber_tarih} - ${kisi.haber_spot} - ${kisi.haber_url} - ${kisi.haber_ust_resim}');
  }
}