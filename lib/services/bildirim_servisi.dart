class BildirimServisi {
  static List<Map<String, dynamic>> _duyurular = [
    {
      'baslik': 'Su Kesintisi Bildirimi',
      'aciklama': 'Bugün 13:00-17:00 arasında bakım nedeniyle kesinti olacak.',
      'tarih': '2025-07-18',
      'okundu': false,
    },
  ];

  static List<Map<String, dynamic>> _haberler = [
    {
      'baslik': 'Etkinlik Daveti',
      'aciklama': 'Yarın saat 10:00\'da şehir meydanında konser var.',
      'tarih': '2025-07-17',
      'okundu': false,
    },
  {
    'baslik': 'Yeni Bisiklet Yolları Hizmete Açıldı',
    'aciklama': 'Konya Büyükşehir Belediyesi tarafından 12 km yeni bisiklet yolu tamamlanarak vatandaşların kullanımına sunuldu.',
    'tarih': '2025-07-27',
          'okundu': false,

  },
  {
    'baslik': 'Konya Bilim Merkezi Yaz Etkinlikleri Başladı',
    'aciklama': 'Öğrenciler için özel atölye çalışmaları ve bilim gösterileri ile dopdolu bir yaz programı hazırlandı.',
    'tarih': '2025-07-25',
          'okundu': false,

  },
  {
    'baslik': 'Konya’daki Parklara Güneş Enerjili Aydınlatma Sistemi',
    'aciklama': 'Çevreci yaklaşımı ile bilinen KBB, şehirdeki parklarda güneş enerjili aydınlatma sistemine geçiyor.',
    'tarih': '2025-07-23',
          'okundu': false,

  },
  {
    'baslik': 'Mobil Atık Getirme Merkezleri Faaliyete Geçti',
    'aciklama': 'Vatandaşlar artık evlerine en yakın noktada atıklarını çevre dostu şekilde teslim edebilecek.',
    'tarih': '2025-07-20',
          'okundu': false,

  },
  {
    'baslik': 'Selçuklu Sosyal Tesisi Törenle Açıldı',
    'aciklama': 'KBB tarafından inşa edilen yeni sosyal tesis, mahalle sakinlerinin hizmetine sunuldu.',
    'tarih': '2025-07-19',
          'okundu': false,

  },
  {
    'baslik': 'KOMEK Yaz Kursları Yoğun İlgi Gördü',
    'aciklama': 'Konya genelinde açılan KOMEK yaz kursları çocuklar ve gençler tarafından büyük ilgiyle karşılandı.',
    'tarih': '2025-07-18',
          'okundu': false,

  },
];

  static List<Map<String, dynamic>> get duyurular => _duyurular;
  static List<Map<String, dynamic>> get haberler => _haberler;

  static void isaretleOkundu(Map<String, dynamic> bildirim) {
    bildirim['okundu'] = true;
  }

  static int okunmamisSayisi() {
    final tum = [..._duyurular, ..._haberler];
    return tum.where((b) => b['okundu'] == false).length;
  }
}
