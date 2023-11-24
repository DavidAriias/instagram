import 'package:flutter/material.dart';

class ImageCounter extends StatelessWidget {
  const ImageCounter({
    super.key,
    required this.showCounter,
    required this.currentIndex,
    required this.imagesLength,
    this.top,
    this.left,
    this.right,
    this.bottom,
  });

  final bool showCounter;
  final int currentIndex;
  final int imagesLength;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showCounter,
      child: Positioned(
        top: top,
        right: right,
        left: left,
        bottom: bottom,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            '${currentIndex + 1} / $imagesLength',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }
}
