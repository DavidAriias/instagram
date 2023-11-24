import 'package:flutter/material.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class AppBarMainProfile extends StatelessWidget {
  const AppBarMainProfile({super.key, required this.username, this.iconColor, required this.isVerified});

  final String username;
  final Color? iconColor;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return CustomAppBar(
      pinned: true,
      leading: CustomRowVerified(
        username: username,
        isVerified: isVerified,
        textStyle: textStyle.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      actions: [
        AddPopUpSurface(
            iconColor: iconColor,
            dividerColor: Colors.grey.shade300.withOpacity(0.8)),
        OptionsPopUpSurface(
            iconColor: iconColor,
            dividerColor: Colors.grey.shade300.withOpacity(0.8))
      ],
    );
  }
}
