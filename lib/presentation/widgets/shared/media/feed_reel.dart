import 'package:flutter/material.dart';
import 'package:instagram/presentation/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class FeedReel extends StatefulWidget {
  const FeedReel({super.key});

  @override
  State<FeedReel> createState() => _FeedReelState();
}

class _FeedReelState extends State<FeedReel> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          ResponsiveReel(),
         // const HeaderFeed()
        ]),
        ButtonsUnderMedia(),
        //ColumnDescription(),
      ],
    );
  }
}

class ResponsiveReel extends StatelessWidget {

  const ResponsiveReel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomVideoPlayer(),
          ),

          Positioned(
            bottom: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(Icons.volume_off, size: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
