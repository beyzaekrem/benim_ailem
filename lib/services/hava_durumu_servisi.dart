import 'dart:convert';
import 'package:http/http.dart' as http;

class HavaDurumuServisi {
  final String apiKey = "20c605811c5014a719bfa14576fa5e83";
  final String sehir = "Konya";

  Future<Map<String, dynamic>?> bugununHavaDurumuGetir() async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$sehir&appid=$apiKey&units=metric&lang=tr";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final durum = data["weather"][0]["description"];
        final ikon = data["weather"][0]["icon"];
        final sicaklik = data["main"]["temp"];

        return {
          "sicaklik": sicaklik,
          "durum": durum,
          "ikon": ikon,
        };
      } else {
        print("API Hata: ${response.statusCode}");
      }
    } catch (e) {
      print("Hava durumu verisi alınamadı: $e");
    }

    return null;
  }
}
