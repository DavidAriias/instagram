import 'package:flutter/material.dart';
import 'package:instagram/presentation/widgets/shared/avatar/user_avatar.dart';

class AvatarFetchMedia extends StatelessWidget {
  const AvatarFetchMedia({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    bool storyAvailable = false;
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarWithGradient(radius: 40, radiusOutline: 3),
          Text(username, style: textStyle.bodyMedium)
        ],
      ),
    );
  }
}
