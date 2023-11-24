import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/config/constants/assets_consts.dart';
import 'package:instagram/presentation/providers/providers.dart';

import '../../widgets.dart';

class OptionsPopUpSurface extends ConsumerWidget {
  const OptionsPopUpSurface(
      {super.key,
      this.iconColor,
      this.dividerColor,
      this.padding = const EdgeInsets.symmetric(vertical: 5)});

  final Color? iconColor;
  final Color? dividerColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final isVerified = ref.watch(mainUserProvider).isVerificated;

    return CustomIconCupertinoButton(
        onPressed: () => showCupertinoModalPopup(
            context: context,
            builder: (context) => CustomCupertinoPopUpSurface(
                  children: [
                    Row(children: [
                      Text('Your account',
                          style: textStyle.titleMedium
                              ?.copyWith(color: Colors.grey)),
                      const Spacer(),
                      Image.asset(AssetsConsts.metaLogo,
                          width: 80, height: 80, color: iconColor)
                    ]),
                    CustomIconRowButton(
                      icon: Icon(Icons.lock_outline, color: iconColor),
                      label: 'Change password',
                      style: textStyle.titleMedium,
                      padding: padding,
                      onTap: () {
                        context.pop();
                        context.push('/profile/password');
                      },
                    ),
                    Divider(color: dividerColor),
                    CustomIconRowButton(
                        icon: Icon(Icons.cake, color: iconColor),
                        label: 'Change birthday',
                        style: textStyle.titleMedium,
                        padding: padding),
                    (!isVerified)
                        ? Divider(color: dividerColor)
                        : const SizedBox.shrink(),
                    (!isVerified)
                        ? CustomIconRowButton(
                            icon:
                                Icon(Icons.verified_outlined, color: iconColor),
                            label: 'Meta verified',
                            style: textStyle.titleMedium,
                            padding: padding,
                            onTap: () {
                              context.pop();
                              context.push('/profile/verified');
                            })
                        : const SizedBox.shrink(),
                    Divider(color: dividerColor),
                    CustomIconRowButton(
                      icon: const SizedBox.shrink(),
                      label: 'Log out',
                      style: textStyle.titleMedium?.copyWith(color: Colors.red),
                      padding: padding,
                      onTap: () => ref.read(authProvider.notifier).logout(),
                    )
                  ],
                )),
        child: Icon(Icons.view_headline_rounded, color: iconColor));
  }
}
