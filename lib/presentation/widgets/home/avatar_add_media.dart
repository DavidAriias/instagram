import 'package:flutter/material.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class AvatarAddMedia extends StatelessWidget {
  const AvatarAddMedia({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.background;
    return Stack(children: [
      const AvatarFetchMedia(username: 'Your story'),
      Positioned(
          top: 60,
          left: 53,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.add_circle,
                color: color,
                size: 35,
              ),
              const Icon(
                Icons.add_circle_outline_sharp,
                color: Colors.white,
                size: 25,
              ),
              const Icon(
                Icons.add_circle,
                color: Colors.blue,
                size: 25,
              ),
            ],
          ))
    ]);
  }
}
