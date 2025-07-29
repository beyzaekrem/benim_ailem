import 'package:flutter/material.dart';

class StoryBileseni extends StatelessWidget {
  final List<Map<String, String>> storyList = [
    {
      'baslik': 'Yeni Duyuru',
      'aciklama': 'Bugün saat 16:00’da elektrik kesintisi olacak.',
    },
    {
      'baslik': 'Toplantı',
      'aciklama': 'Yarın saat 10:00’da Belediye Meclis Toplantısı var.',
    },
    {
      'baslik': 'Etkinlik',
      'aciklama': 'Bu hafta sonu konser var, kaçırmayın!',
    },
  ];

  StoryBileseni({super.key});

  void _showStoryModal(BuildContext context, int initialPage) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Görüntüle",
      pageBuilder: (context, anim1, anim2) {
        return StoryViewer(
          stories: storyList,
          initialIndex: initialPage,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 12.0, right: 12.0),
      child: Row(
        children: List.generate(storyList.length, (index) {
          final story = storyList[index]; // 💡 BU SATIR EKSİKTİ

          return GestureDetector(
            onTap: () => _showStoryModal(context, index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFFFB800), width: 3),
                      image: const DecorationImage(
                        image: AssetImage('assets/picture/story_icon.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    story['baslik'] ?? '',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class StoryViewer extends StatefulWidget {
  final List<Map<String, String>> stories;
  final int initialIndex;

  const StoryViewer({super.key, required this.stories, required this.initialIndex});

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: widget.initialIndex);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.95),
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.stories.length,
        itemBuilder: (context, index) {
          final story = widget.stories[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Icon(Icons.campaign, color: Colors.white, size: 60),
              const SizedBox(height: 20),
              Text(
                story['baslik'] ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  story['aciklama'] ?? '',
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Kapat", style: TextStyle(color: Colors.white70)),
              ),
              const SizedBox(height: 40),
            ],
          );
        },
      ),
    );
  }
}
