import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:benim_ailem/components/TakvimBolumu.dart';
import 'package:benim_ailem/components/gunun_menusu.dart';
import 'package:benim_ailem/components/bugun/bugun_bolumu.dart';
import 'package:benim_ailem/components/story_bileseni.dart';
import 'package:benim_ailem/components/haberler_bolumu.dart';
import 'package:benim_ailem/components/hava_durumu_bolumu.dart';
import 'package:benim_ailem/pages/left_drawer/dokumanlar/dokumanlar_sayfasi.dart';
import 'package:benim_ailem/pages/left_drawer/rehber/rehber_sayfasi.dart';
import 'package:benim_ailem/pages/left_drawer/personel/personel_semasi_sayfasi.dart';
import 'package:benim_ailem/pages/left_drawer/yemek/yemekhane_app.dart';
import 'package:benim_ailem/pages/left_drawer/bizden_biri/bizden_biri_sayfasi.dart';
import 'package:benim_ailem/pages/right_drawer/bildirimler_sayfasi.dart';
import 'package:benim_ailem/widgets/alt_bar.dart';
import 'package:benim_ailem/widgets/youtube_widget.dart';
import 'package:benim_ailem/services/bildirim_servisi.dart';
import 'package:url_launcher/url_launcher.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  Future<void> _openKbbAkademi() async {
    Navigator.pop(context); // önce drawer'ı kapat
    await Future.delayed(const Duration(milliseconds: 120));

    final url = Uri.parse("https://kbbakademi.edubiz.com.tr/Account/Login?ReturnUrl=%2f");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bağlantı açılamadı.')),
      );
    }
  }

  Future<void> _mailGonder() async {
    Navigator.pop(context); // önce drawer'ı kapat
    await Future.delayed(const Duration(milliseconds: 120));

    // 1) mailto
    final mailto = Uri(
      scheme: 'mailto',
      path: 'konyabuyuksehirbelediyesi@hs01.kep.tr',
      // queryParameters: {'subject': 'KBB İletişim', 'body': 'Merhaba,'},
    );
    if (await canLaunchUrl(mailto)) {
      await launchUrl(mailto, mode: LaunchMode.externalApplication);
      return;
    }

    // 2) Gmail web compose (simülatörde işe yarayabilir)
    final gmailWeb = Uri.parse(
      'https://mail.google.com/mail/?view=cm&to=konyabuyuksehirbelediyesi@hs01.kep.tr',
    );
    if (await canLaunchUrl(gmailWeb)) {
      await launchUrl(gmailWeb, mode: LaunchMode.externalApplication);
      return;
    }

    // 3) Son çare: e-posta adresini panoya kopyala
    await Clipboard.setData(const ClipboardData(text: 'konyabuyuksehirbelediyesi@hs01.kep.tr'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('E-posta uygulaması bulunamadı. Adres panoya kopyalandı.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int okunmamisBildirimSayisi = BildirimServisi.okunmamisSayisi();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/picture/benimailemlogo.png', height: 40),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BildirimlerSayfasi()),
                  );
                  setState(() {});
                },
              ),
              if (okunmamisBildirimSayisi > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF44336),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "$okunmamisBildirimSayisi",
                        style: const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFFF3BE38)),
              child: Row(
                children: [
                  Image.asset('assets/picture/logo2.jpg', height: 40),
                  const SizedBox(width: 10),
                  const Text('Hoş geldiniz!', style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Dokümanlar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  DokumanlarSayfasi()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_page),
              title: const Text('Rehber'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  RehberSayfasi()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Maaş'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: const Text('Yemekhane Menüsü'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  YemekhaneApp()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_tree),
              title: const Text('Personel Şeması'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonelSemasiSayfasi()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Bizden Biri'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  BizdenBiriSayfasi()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('KBB Akademi'),
              onTap: _openKbbAkademi,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.mail),
              title: const Text('Bize Ulaşın'),
              onTap: _mailGonder,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Başkan görseli + Story bileşeni
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => const YoutubeDialog(videoId: 'tRnopGEY0c0'),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFFEB716), width: 3),
                        ),
                        child: const CircleAvatar(
                          radius: 32,
                          backgroundImage: AssetImage('assets/picture/baskan.jpg'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(width: 1, height: 60, color: Colors.grey.shade400),
                    const SizedBox(width: 12),
                     Expanded(child: StoryBileseni()),
                  ],
                ),
              ),
              const HaberlerBolumu(),
               HavaDurumuBolumu(),
              const GununMenusuWidget(),
              const BugunBolumu(),
              const TakvimBolumu(),
            ],
          ),
        ),
      ),
      bottomNavigationBar:  AltBar(),
    );
  }
}
