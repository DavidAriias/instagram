import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key, this.width, this.height, this.borderRadius, this.child});

  final double? width;
  final double? height;
  final double? borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.white70,
      child: Container(
        decoration: BoxDecoration(
          color: Colors
              .white, // Este color no afecta el efecto Shimmer, pero debe ser diferente del baseColor
          borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
        ),
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
