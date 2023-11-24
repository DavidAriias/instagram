import 'package:flutter/material.dart';
import '../../../../config/constants/assets_consts.dart';

class ButtonsUnderMedia extends StatelessWidget {
  final Widget? optionalWidget;

  const ButtonsUnderMedia({super.key, this.optionalWidget});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).iconTheme.color;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        children: [
          Image.asset(AssetsConsts.heartIcon, width: 20, height: 20, color: color),
          const SizedBox(width: 15),
          Image.asset(AssetsConsts.chatIcon, width: 20, height: 20, color: color),
          const SizedBox(width: 15),
          if (optionalWidget != null)
            optionalWidget!,
        ],
      ),
    );
  }
}


