import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final bool isLiked;
  final double heartPositionX;
  final double heartPositionY;

  const LikeAnimation({
    super.key,
    required this.isLiked,
    required this.heartPositionX,
    required this.heartPositionY,
  });

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 1000),
      left: widget.heartPositionX,
      right: widget.heartPositionY,
      curve: Curves.easeOutCirc,
      top: widget.isLiked
          ? widget.heartPositionY - 100
          : MediaQuery.of(context).size.height,
      child: widget.isLiked
          ? const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 100,
            )
          : const SizedBox.shrink(),
    );
  }
}
