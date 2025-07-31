//backend ile frontend arasındaki haberleşmeyi sağlayan servis
//api istek yaparak gelen işlemleri ön yüze yansıtacağız.
import 'package:http/http.dart' as http;
import 'dart:convert';

class RehberServisi {
  final String url = "https://api.konya.bel.tr/apigateway/telefon-rehber";

  final String? adsoy;
  final String? eposta;
  final String? mudurluk;
  final String? telefon;

  RehberServisi({this.adsoy, this.eposta, this.mudurluk, this.telefon});

  factory RehberServisi.fromJson(Map<String, dynamic> json) {
    return RehberServisi(
      adsoy: json['adsoy'] as String?,
      eposta: json['eposta'] as String?,
      mudurluk: json['mudurluk'] as String?,
      telefon: json['telefon'] as String?,
    );
  }

  static Future<List<RehberServisi>> getRehberListesi() async {
    try {
      final response = await http.post(
        Uri.parse("https://api.konya.bel.tr/apigateway/telefon-rehber"),
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
        return data.map((item) => RehberServisi.fromJson(item)).toList();
      } 
      else 
      {
        throw Exception('Failed to load rehber listesi: ${response.statusCode}');
      }
    } 
    catch (e) 
    {
      print('Error fetching rehber listesi: $e');
      return [];
    }
  }

}
void main() async {
  final liste = await RehberServisi.getRehberListesi();
  for (var kisi in liste) {
    print('${kisi.adsoy} - ${kisi.telefon}');
  }
}