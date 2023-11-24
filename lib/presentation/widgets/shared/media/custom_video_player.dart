import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../widgets.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({super.key, this.aspectRadio});

  final double? aspectRadio;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..setVolume(1);
    //..setLooping(true)
    //..play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
              child: CircularProgressIndicator.adaptive(strokeWidth: 2));
        }
        return GestureDetector(
          onTap: () {
            _controller.setVolume(0);
          },
          onTapUp: (_) {
            _controller.setVolume(1);
          },
          onLongPress: () {
            _controller.pause();
          },
          onLongPressEnd: (_) {
            _controller.play();
          },
          child: AspectRatio(
            aspectRatio: widget.aspectRadio ?? _controller.value.aspectRatio,
            child: Stack(
              children: [
              VideoPlayer(_controller),
              CustomGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.8, 1.0],
                  colors: const [Colors.transparent, Colors.black87]),
            ]),
          ),
        );
      },
    );
  }
}
