import 'package:flutter/material.dart';
import 'package:benim_ailem/widgets/bildirim_detay_sayfasi.dart';
import 'package:benim_ailem/services/bildirim_servisi.dart';

class BildirimlerSayfasi extends StatefulWidget {
  final int aktifSekmeIndex;

  const BildirimlerSayfasi({super.key, this.aktifSekmeIndex = 0});

  @override
  State<BildirimlerSayfasi> createState() => _BildirimlerSayfasiState();
}

class _BildirimlerSayfasiState extends State<BildirimlerSayfasi> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.aktifSekmeIndex, // ✅ Doğru kullanımı bu
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getSorted(List<Map<String, dynamic>> list) {
    list.sort((a, b) => b['tarih'].compareTo(a['tarih']));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final duyurular = BildirimServisi.duyurular;
    final haberler = BildirimServisi.haberler;
    final tumu = _getSorted([...duyurular, ...haberler]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Image.asset('assets/picture/benimailemlogo.png', height: 40),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          indicatorColor: const Color(0xFFF3BE38),
          tabs: const [
            Tab(text: 'Tümü'),
            Tab(text: 'Duyurular'),
            Tab(text: 'Haberler'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildListView(tumu),
          _buildListView(_getSorted(duyurular)),
          _buildListView(_getSorted(haberler)),
        ],
      ),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> data) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final bildirim = data[index];
        final isOkundu = bildirim['okundu'] ?? false;

        return GestureDetector(
          onTap: () async {
            if (!isOkundu) {
              BildirimServisi.isaretleOkundu(bildirim);
              setState(() {});
            }

            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BildirimDetaySayfasi(
                  baslik: bildirim['baslik'],
                  aciklama: bildirim['aciklama'],
                  tarih: bildirim['tarih'],
                ),
              ),
            );
          },
          child: Card(
            color: isOkundu ? Colors.grey[200] : Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bildirim['baslik'],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bildirim['aciklama'],
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      bildirim['tarih'],
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
