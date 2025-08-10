import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:benim_ailem/pages/home_page/ana_sayfa.dart';

class SplashVideoPage extends StatefulWidget {
  const SplashVideoPage({super.key});

  @override
  State<SplashVideoPage> createState() => _SplashVideoPageState();
}

class _SplashVideoPageState extends State<SplashVideoPage> {
  late VideoPlayerController _controller;
  bool hasNavigated = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset("assets/video/splash_intro.mp4");

    _controller.initialize().then((_) {
      setState(() {}); // UI'ı güncelle
      _controller.play();

      // Bu listener sadece video bittiyse çalışacak
      _controller.addListener(() {
        if (_controller.value.isInitialized &&
            !_controller.value.isPlaying &&
            _controller.value.position >= _controller.value.duration &&
            !hasNavigated) {
          hasNavigated = true;

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) =>  AnaSayfa()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: _controller.value.isInitialized
        ? SizedBox.expand( // Ekranı tamamen doldur
            child: FittedBox(
              fit: BoxFit.cover, // Video içeriğini ekranı dolduracak şekilde büyüt
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator()),
  );
}

}
