import 'package:flutter/cupertino.dart';

class CustomIconCupertinoButton extends StatelessWidget {
  const CustomIconCupertinoButton({
    super.key,
    required this.onPressed,
    required this.child});

  final void Function()? onPressed;
  final Icon child;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: onPressed,
      child: child,
    );
  }
}