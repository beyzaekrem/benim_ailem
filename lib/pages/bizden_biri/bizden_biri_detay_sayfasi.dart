import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BizdenBiriDetaySayfasi extends StatefulWidget {
  final String ad;
  final String unvan;
  final String aciklama;
  final String videoUrl;

  const BizdenBiriDetaySayfasi({
    Key? key,
    required this.ad,
    required this.unvan,
    required this.aciklama,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<BizdenBiriDetaySayfasi> createState() => _BizdenBiriDetaySayfasiState();
}

class _BizdenBiriDetaySayfasiState extends State<BizdenBiriDetaySayfasi> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.ad} - ${widget.unvan}"),
        backgroundColor: const Color(0xFFFEB716),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
            const SizedBox(height: 16),
            Text(
              widget.aciklama,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
