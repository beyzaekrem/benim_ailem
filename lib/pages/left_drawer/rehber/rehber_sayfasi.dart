import 'package:flutter/material.dart';
import 'package:benim_ailem/widgets/CustomAppBar.dart';
import 'package:benim_ailem/services/rehber_servisi.dart';

class RehberSayfasi extends StatefulWidget {
  @override
  _RehberSayfasiState createState() => _RehberSayfasiState();
}

class _RehberSayfasiState extends State<RehberSayfasi> {
  String aramaGirdisi = '';
  String aktifArama = '';
  bool _yukleniyor = true;
  final Color mainColor = Color(0xFFFEB716);

  List<RehberServisi> tumKisiler = [];

  @override
  void initState() {
    super.initState();
    _rehberVerisiniYukle();
  }

  Future<void> _rehberVerisiniYukle() async {
    final kisiler = await RehberServisi.getRehberListesi();
    setState(() {
      tumKisiler = kisiler;
      _yukleniyor = false;
    });
  }

  List<RehberServisi> get filtrelenmisListe {
    if (aktifArama.isEmpty) return tumKisiler;
    return tumKisiler.where((kisi) {
      return (kisi.adsoy ?? '').toLowerCase().contains(aktifArama.toLowerCase());
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
      body: _yukleniyor
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Arama kutusu ve Ara butonu
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
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Sonuç Listesi
                  Expanded(
                    child: filtrelenmisListe.isEmpty
                        ? const Center(child: Text('Kayıt bulunamadı.'))
                        : ListView.builder(
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
                                        kisi.adsoy ?? '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(kisi.mudurluk ?? '-'),
                                      const SizedBox(height: 6),
                                      Text("Dahili: ${kisi.telefon ?? '-'}"),
                                      Text("E-posta: ${kisi.eposta?.isNotEmpty == true ? kisi.eposta! : '-'}"),
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
