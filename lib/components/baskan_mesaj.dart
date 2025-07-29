import 'package:flutter/material.dart';
import 'package:benim_ailem/widgets/youtube_widget.dart'; // YoutubeDialog dosyasını import et

class BaskanKutucugu extends StatelessWidget {
  const BaskanKutucugu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => const YoutubeDialog(videoId: 'tRnopGEY0c0'),
          );
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFEB716),
                  width: 3,
                ),
              ),
              child: const CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage('assets/picture/baskan.jpg'),
              ),
            ),
            const SizedBox(width: 16),
            const Expanded( 
              child: Text(
                'Başkanımızdan Size Bir Mesaj Var!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
