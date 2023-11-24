import 'package:flutter/material.dart';

class CustomIconRowButton extends StatelessWidget {
  const CustomIconRowButton({
    super.key,
    required this.icon,
    required this.label,
    this.style,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 10)});

  final Widget icon;
  final String label;
  final TextStyle? style;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 8),
            Text(label, style: style)
          ],
        ),
      ),
    );
  }
}
