import 'package:flutter/material.dart';

class BirimDetayModal extends StatelessWidget {
  final String title;
  final String name;
  final String role;
  final String imagePath;
  final String phone;
  final String internal;
  final List<String> duties;

  const BirimDetayModal({
    super.key,
    required this.title,
    required this.name,
    required this.role,
    required this.imagePath,
    required this.phone,
    required this.internal,
    required this.duties,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(imagePath),
                    radius: 48,
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(name),
                ),
                const SizedBox(height: 16),
                Text("İletişim: $phone", style: const TextStyle(fontSize: 16)),
                Text("Dahili: $internal", style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                const Text(
                  "GÖREVLER",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
                ),
                const SizedBox(height: 10),
                ...duties.map((duty) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text("• $duty"),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
