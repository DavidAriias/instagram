import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReelButtons extends StatelessWidget {
  const ReelButtons({super.key});

  final Color iconColor = Colors.white;
  final double iconSize = 28;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CustomIconButton(iconColor: iconColor, iconSize: iconSize, iconData: Icons.favorite_border),
        const Text('560'),
        const SizedBox(height: 5),
         _CustomIconButton(iconColor: iconColor, iconSize: iconSize, iconData: CupertinoIcons.chat_bubble),
        const Text('560'),
        const SizedBox(height: 5),
        _CustomIconButton(iconData: Icons.more_horiz, iconColor: iconColor, iconSize: iconSize)
      ],
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  const _CustomIconButton({
    required this.iconData,
    required this.iconColor,
    required this.iconSize,
  });

  final Color iconColor;
  final double iconSize;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: Icon(iconData,
            color: iconColor, size: iconSize));
  }
}
