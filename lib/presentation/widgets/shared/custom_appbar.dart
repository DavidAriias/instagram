import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      this.leading,
      this.pinned = false,
      this.actions,
      this.title,
      this.centerTitle,
      this.padding = const EdgeInsets.only(left: 10.0, top: 10),
      this.leadingWidth,
      this.toolbarHeight});

  final Widget? leading;
  final bool pinned;
  final List<Widget>? actions;
  final Widget? title;
  final bool? centerTitle;
  final EdgeInsetsGeometry padding;
  final double? leadingWidth;
  final double? toolbarHeight;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      floating: true,
      snap: true,
      pinned: pinned,
      title: title,
      centerTitle: centerTitle,
      leading: Padding(
        padding: padding,
        child: leading,
      ),
      leadingWidth: (leadingWidth == null) ? size.width / 2 : leadingWidth,
      actions: actions,
      toolbarHeight: toolbarHeight ?? kToolbarHeight,
    );
  }
}
