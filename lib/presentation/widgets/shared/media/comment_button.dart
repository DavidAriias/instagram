import 'package:flutter/material.dart';
import 'package:instagram/config/config.dart';

class CommentButton extends StatelessWidget {
  const CommentButton({super.key, required this.comments});

  final int comments;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {},
      child: Text('View all ${HumanFormatHelper.humanReadbleNumber(comments)} comments', 
      style: TextStyle(
        color: Colors.grey,
        fontSize: textStyle.bodyLarge?.fontSize
      )),
    );
  }
}
