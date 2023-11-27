import 'package:flutter/material.dart';

class CustomButtonRectanguleGrey extends StatelessWidget {
  const CustomButtonRectanguleGrey({
  super.key, 
  required this.width,
  required this.height,
  this.child, 
  this.onPressed,
  this.alignment});

  final double width;
  final double height;
  final Widget? child;
  final void Function()? onPressed;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: alignment,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: child,
      ),
    );
  }
}
