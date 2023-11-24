import 'package:flutter/material.dart';

class CustomTitleText extends StatelessWidget {
  const CustomTitleText({super.key, required this.textButton});

  final String textButton;
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Text(textButton,
        style: TextStyle(
            color: textStyle.titleLarge?.color,
            fontWeight: FontWeight.w600,
            fontSize: textStyle.titleLarge?.fontSize
    ));
  }
}
