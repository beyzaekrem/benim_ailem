import 'package:flutter/material.dart';
import 'package:benim_ailem/pages/left_drawer/personel/personel_detay_modal.dart';

class PersonelSemasiSayfasi extends StatelessWidget {
  const PersonelSemasiSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personel Şeması'),
        backgroundColor: const Color(0xFFFEB716),
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildBaskanTile(context),
          const SizedBox(height: 16),
          ExpansionTile(
            leading: const Icon(Icons.apartment),
            title: const Text('Satın Alma Dairesi'),
            children: [
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Satın Alma Şube Müdürlüğü'),
                onTap: () {
                  PersonelDetayModal(
                      imageUrl: 'assets/personel/zeynel_taspas.jpg',
                      title: 'Satın Alma Şube Müdürü',
                      name: 'Zeynel TAŞBAŞ',
                      phone: '444 55 42',
                      internalNumber: '5302',
                      duties: [
                        '4734 sayılı Kamu İhale Kanunu kapsamındaki satın alma işlemleri',
                        'Teknik şartname hazırlığı ve piyasa araştırması',
                        'Sözleşme hazırlanması ve takibi',
                        'Mal/hizmet teslimi ve kontrolü',
                      ]);
                },
              ),
            ],
          ),
          // Diğer birimler için ExpansionTile ekleyebilirsin
        ],
      ),
    );
  }

  Widget _buildBaskanTile(BuildContext context) {
    return Card(
      color: const Color(0xFFFFDEA5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage('assets/personel/baskan.jpg'),
        ),
        title: const Text(
          'Uğur İbrahim ALTAY',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('Konya Büyükşehir Belediye Başkanı'),
        onTap: () {
          PersonelDetayModal(
              imageUrl: 'assets/personel/baskan.jpg',
              title: 'Büyükşehir Belediye Başkanı',
              name: 'Uğur İbrahim ALTAY',
              phone: '444 55 42',
              internalNumber: '0000',
              duties: [
                'Belediyenin tüm idari ve mali işlerinden sorumludur.',
                'Birimler arası koordinasyonu sağlar.',
                'Halkla ilişkileri yürütür ve şehri temsil eder.',
              ]);
        },
      ),
    );
  }
}
