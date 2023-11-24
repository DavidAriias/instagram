import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../widgets.dart';

class AddPopUpSurface extends StatelessWidget {
  const AddPopUpSurface({super.key,
  this.iconColor,
  this.dividerColor,
  this.padding = const EdgeInsets.symmetric(vertical: 5)
  });

  final Color? iconColor;
  final Color? dividerColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return CustomIconCupertinoButton(
        onPressed: () => showCupertinoModalPopup(
            context: context,
            builder: (context) => CustomCupertinoPopUpSurface(
                  children: [
                    Text('Create',
                        style: textStyle.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    Divider(color:dividerColor),
                    CustomIconRowButton(
                      icon: Image.asset(AssetsConsts.reelIcon,
                          width: 28, height: 28, color: iconColor),
                      label: 'Reel',
                      style: textStyle.titleMedium,
                      padding: padding,
                    ),
                    Divider(color:dividerColor),
                    CustomIconRowButton(
                      icon: Icon(Icons.grid_on_sharp, color: iconColor),
                      label: 'Post',
                      style: textStyle.titleMedium,
                      padding: padding,
                    ),
                    Divider(color: dividerColor),
                    CustomIconRowButton(
                        icon: Image.asset(AssetsConsts.addStoryIcon,
                            width: 25, height: 25, color: iconColor),
                        label: 'Story',
                        style: textStyle.titleMedium,
                        padding: padding,
                        ),
                    Divider(color: dividerColor),
                  ],
                )),
        child: Icon(Icons.add_box_outlined, color: iconColor));
  }
}
