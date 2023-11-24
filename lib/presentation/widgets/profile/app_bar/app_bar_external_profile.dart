import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets.dart';

class AppBarExternalProfile extends StatelessWidget {
  const AppBarExternalProfile(
      {super.key, this.iconColor, required this.username, required this.isVerified});

  final Color? iconColor;
  final String username;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return CustomAppBar(
      pinned: true,
      padding: const EdgeInsets.all(0),
      leadingWidth: 56,
      leading: CustomIconCupertinoButton(
          onPressed: () => context.pop(),
          child: Icon(Icons.arrow_back_ios_new, color: iconColor)),
      centerTitle: true,
      title: CustomRowVerified(
        textStyle: textStyle.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        username: username, isVerified: isVerified),
    );
  }
}
