import 'package:flutter/material.dart';


import '../../widgets/widgets.dart';

class VideoScrollableView extends StatelessWidget {
  const VideoScrollableView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (context, index) => Stack(
     fit: StackFit.expand,
        children: [
          CustomVideoPlayer(aspectRadio: 9 / 16),
          Positioned(bottom: 80, left: 20,child:  DataUnderReel()),
          Positioned(bottom: 80, right: 20, child: ReelButtons()),
          
        ],
      ),
    );
  }
}
