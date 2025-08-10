import 'package:flutter/material.dart';
import 'package:benim_ailem/widgets/CustomAppBar.dart'; 

class DokumanlarSayfasi extends StatefulWidget {
  @override
  _DokumanlarSayfasiState createState() => _DokumanlarSayfasiState();
}

class _DokumanlarSayfasiState extends State<DokumanlarSayfasi> {
  String selectedCategory = 'Tümü';
  String searchQuery = '';

  final List<Map<String, String>> allDocuments = [
    {"title": "Kadrolu İşçi İzin Formu", "category": "İzin Belgeleri"},
    {"title": "Memur Hastalık İzin Formu", "category": "İzin Belgeleri"},
    {"title": "Taşıt Görev Emri Formu", "category": "İzin Belgeleri"},
    {"title": "Şirket Personeli İzin Talep Formu", "category": "İzin Belgeleri"},
    {"title": "Memur İzin Formu", "category": "İzin Belgeleri"},
    {"title": "Mal Bildirimi (Arkalı-Önlü Çıktı Alınması Gerekiyor)", "category": "Diğer Belgeler"},
    {"title": "Aile Bildirimi Formu", "category": "Diğer Belgeler"},
  ];

  List<String> categories = ['Tümü', 'İzin Belgeleri', 'Diğer Belgeler'];

  List<Map<String, String>> get filteredDocuments {
    return allDocuments.where((doc) {
      final matchesCategory = selectedCategory == 'Tümü' || doc['category'] == selectedCategory;
      final matchesSearch = doc['title']!.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  final Color mainColor = Color(0xFFFEB716);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Dökümanlar'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Kategori Seçimi Dropdown
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                labelText: "Kategori seçin",
                labelStyle: TextStyle(color: mainColor),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: mainColor, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: categories.map((kategori) {
                return DropdownMenuItem<String>(
                  value: kategori,
                  child: Text(kategori),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
            SizedBox(height: 12),

            // Arama Alanı
            TextField(
              decoration: InputDecoration(
                labelText: 'Belge Ara',
                labelStyle: TextStyle(color: mainColor),
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                border: OutlineInputBorder(),
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
                  searchQuery = value;
                });
              },
            ),
            SizedBox(height: 16),

            // Filtrelenmiş Belgeler Listesi
            Expanded(
              child: ListView.builder(
                itemCount: filteredDocuments.length,
                itemBuilder: (context, index) {
                  final belge = filteredDocuments[index];
                  return Card(
                    child: ListTile(
                      title: Text(belge['title']!),
                      onTap: () {
                        // TODO: PDF açma veya indirme işlemi
                      },
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
