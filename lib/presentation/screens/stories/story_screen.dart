import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StoryScreen extends StatefulWidget {
  static const name = 'story-screen';
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  late PageController _pageController;
  late VideoPlayerController _videoController;
  int currentIndex = 0;

  static const image =
      'https://th.bing.com/th/id/OIP.ELLoKplBqCY-b-o3uCQASQHaJQ?pid=ImgDet&rs=1';

  List<String> posts = [
    image,
    image,
    image,
    image,
    image,
    image
    // Agrega las rutas de tus imágenes aquí
  ];

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _videoController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        setState(() {});
      });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
          controller: _pageController,
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return Image.network(
              posts[index],
              fit: BoxFit.cover,
            );
          }),
    );
  }
}
