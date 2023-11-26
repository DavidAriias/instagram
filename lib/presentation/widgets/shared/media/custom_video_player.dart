import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../widgets.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({super.key, this.aspectRadio, this.videoController});

  final double? aspectRadio;
  final VideoPlayerController? videoController;

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
    //widget.videoController?.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.videoController?.initialize() ?? _controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
              child: CircularProgressIndicator.adaptive(strokeWidth: 2));
        }
        return AspectRatio(
          aspectRatio: widget.videoController?.value.aspectRatio ??
              _controller.value.aspectRatio,
          child: Stack(children: [
            VideoPlayer(widget.videoController ?? _controller),
            CustomGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.8, 1.0],
                colors: const [Colors.transparent, Colors.black87]),
          ]),
        );
      },
    );
  }
}
