class HaberModel {
  HaberModel({
    required this.haber_id,
    required this.haber_baslik,
    required this.haber_spot,
    required this.haber_metin,
    required this.haber_tarih, 
    required this.haber_url,
    required this.haber_ust_resim,
  });

  String? haber_id;
  String? haber_baslik;
  String? haber_spot;
  String? haber_metin;
  String? haber_tarih;
  String? haber_url;
  List<dynamic>? haber_ust_resim;

HaberModel.fromJson(Map<String, dynamic> json)
      : haber_id = json['haber_id'],
        haber_baslik = json['haber_baslik'],
        haber_spot = json['haber_spot'],
        haber_metin = json['haber_metin'],
        haber_tarih = json['haber_tarih'],
        haber_url = json['haber_url'],
        haber_ust_resim = json['haber_ust_resim'];

  Map<String, dynamic> toJson() {
    return {
      'haber_id': haber_id,
      'haber_baslik': haber_baslik,
      'haber_spot': haber_spot,
      'haber_metin': haber_metin,
      'haber_tarih': haber_tarih,
      'haber_url': haber_url,
      'haber_ust_resim': haber_ust_resim,
    };
  }
}