import 'package:flutter/material.dart';

class CustomRowVerified extends StatelessWidget {
  const CustomRowVerified({
  super.key, 
  required this.username,
  required this.isVerified,
  this.textStyle});

  final String username;
  final bool isVerified;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(username,
            style: textStyle),
        const SizedBox(width: 8),
        (isVerified)
            ? const Icon(Icons.verified, color: Colors.blue, size: 18)
            : const SizedBox.shrink()
      ],
    );
  }
}
