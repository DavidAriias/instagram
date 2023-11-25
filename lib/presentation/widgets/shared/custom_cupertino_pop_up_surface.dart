import 'package:flutter/cupertino.dart';

import '../widgets.dart';

class CustomCupertinoPopUpSurface extends StatelessWidget {
  const CustomCupertinoPopUpSurface(
      {super.key,
      this.color,
      required this.children,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.height,
      this.onVerticalDragStart,
      this.onVerticalDragDown,
      this.onVerticalDragEnd,
      this.onVerticalDragUpdate});

  final Color? color;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double? height;
  final void Function(DragStartDetails)? onVerticalDragStart;
  final void Function(DragDownDetails)? onVerticalDragDown;
  final void Function(DragEndDetails)? onVerticalDragEnd;
  final void Function(DragUpdateDetails)? onVerticalDragUpdate;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onVerticalDragStart: onVerticalDragStart,
      onVerticalDragDown: onVerticalDragDown,
      onVerticalDragEnd: onVerticalDragEnd,
      onVerticalDragUpdate: onVerticalDragUpdate,
      child: CupertinoPopupSurface(
        child: Container(
            color: color,
            width: double.infinity,
            height: height ?? deviceHeight / 2.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: mainAxisAlignment,
                crossAxisAlignment: crossAxisAlignment,
                children: [
                  const CustomButtonRectanguleGrey(width: 50, height: 5),
                  const SizedBox(height: 20),
                  ...children
                ],
              ),
            )),
      ),
    );
  }
}
