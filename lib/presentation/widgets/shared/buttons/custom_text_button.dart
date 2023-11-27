import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.textButton,
      this.color,
      required this.onPressed, this.padding});

  final String textButton;
  final Color? color;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return CupertinoButton(
        padding: padding,
        onPressed: onPressed,
        child: Text(textButton,
            style: TextStyle(
                color: (color == null) ? textStyle.titleMedium?.color : color,
                fontWeight: FontWeight.w600)));
  }
}
