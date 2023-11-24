import 'package:flutter/material.dart';
import 'package:instagram/presentation/widgets/shared/avatar/user_avatar_without_gradient.dart';

class AvatarWithGradient extends StatefulWidget {
  const AvatarWithGradient(
      {super.key, required this.radius, required this.radiusOutline});
  final double radius;
  final double radiusOutline;

  final List<Color> gradientColors = const [
    Color(0xFFFCAF45),
    Color(0xFFFFDC80),
    Color(0xFFF56040),
    Color(0xFFF77737),
    Color(0xFFFD1D1D),
    Color(0xFFE1306C),
    Color(0xFFC13584),
    Color(0xFFDF00FF),
    Color(0xFF833ABA)
  ];

  @override
  State<AvatarWithGradient> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<AvatarWithGradient> {
  @override
  Widget build(BuildContext context) {
    final deviceColor = Theme.of(context).colorScheme.background;
    final bool storyAvailable = false;
    return Container(
      width: widget.radius * 2,
      height: widget.radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: widget.radiusOutline,
          color: Colors.transparent,
        ),
        gradient: (!storyAvailable == true)
            ? null
            : LinearGradient(
                colors: widget.gradientColors,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: widget.radiusOutline,
            color: deviceColor,
          ),
        ),
        child: UserAvatarWithoutGradient(),
      ),
    );
  }
}
