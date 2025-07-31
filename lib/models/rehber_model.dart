class RehberServisi {
  RehberServisi({
    required this.adsoy,
    required this.eposta,
    required this.mudurluk,
    required this.telefon,
  });

  String? adsoy;
  String? eposta;
  String? mudurluk;
  int? telefon;


 
RehberServisi.fromJson(Map<String, dynamic> json)
      : adsoy = json['adsoy'],
        eposta = json['eposta'],
        mudurluk = json['mudurluk'],
        telefon = json['telefon'];

  Map<String, dynamic> toJson() {
    return {
      'adsoy': adsoy,
      'eposta': eposta,
      'mudurluk': mudurluk,
      'telefon': telefon,
    };
  }
}