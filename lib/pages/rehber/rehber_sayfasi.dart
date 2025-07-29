import 'package:flutter/material.dart';
import 'package:benim_ailem/widgets/CustomAppBar.dart'; 

class RehberSayfasi extends StatefulWidget {
  @override
  _RehberSayfasiState createState() => _RehberSayfasiState();
}

class _RehberSayfasiState extends State<RehberSayfasi> {
  String aramaGirdisi = '';
  String aktifArama = '';
  final Color mainColor = Color(0xFFFEB716);

  final List<Map<String, String>> rehberListesi = [
    {
      "isim": "Fatma UZMAN",
      "birim": "YAPI KONTROL DAİRESİ BAŞKANLIĞI",
      "dahili": "5857",
      "eposta": "fatma.uzman@konya.bel.tr"
    },
    {
      "isim": "Ahmet YILDIZ",
      "birim": "BİLGİ İŞLEM DAİRESİ BAŞKANLIĞI",
      "dahili": "5800",
      "eposta": "ahmet.yildiz@konya.bel.tr"
    },
    {
      "isim": "Hasan Hüseyin ŞAHİN",
      "birim": "BİLGİ İŞLEM DAİRESİ BAŞKANLIĞI",
      "dahili": "5877",
      "eposta": "hasan.sahin@konya.bel.tr"
    },
  ];

  List<Map<String, String>> get filtrelenmisListe {
    if (aktifArama.isEmpty) return rehberListesi;
    return rehberListesi.where((kisi) {
      return kisi["isim"]!.toLowerCase().contains(aktifArama.toLowerCase());
    }).toList();
  }

  void aramayiUygula() {
    setState(() {
      aktifArama = aramaGirdisi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Rehber'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Arama Satırı ve Ara Butonu
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Rehber\'de Ara',
                      labelStyle: TextStyle(color: mainColor),
                      prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        aramaGirdisi = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: aramayiUygula,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Ara',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0), 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Sonuçlar
            Expanded(
              child: ListView.builder(
                itemCount: filtrelenmisListe.length,
                itemBuilder: (context, index) {
                  final kisi = filtrelenmisListe[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            kisi["isim"]!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(kisi["birim"]!),
                          const SizedBox(height: 6),
                          Text("Dahili: ${kisi["dahili"]}"),
                          Text("E-posta: ${kisi["eposta"]}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
