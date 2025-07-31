import 'package:flutter/material.dart';

class PersonelDetayModal extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String name;
  final String phone;
  final String internalNumber;
  final List<String> duties;

  const PersonelDetayModal({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.name,
    required this.phone,
    required this.internalNumber,
    required this.duties,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      builder: (_, controller) => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ListView(
          controller: controller,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(imageUrl),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            _infoRow(Icons.phone, 'Telefon', phone),
            _infoRow(Icons.dialpad, 'Dahili', internalNumber),
            const SizedBox(height: 16),
            const Text('Görev ve Sorumluluklar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...duties.map((duty) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(fontSize: 16)),
                      Expanded(child: Text(duty)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

