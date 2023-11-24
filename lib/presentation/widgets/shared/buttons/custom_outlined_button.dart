import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({super.key, required this.textButton, required this.onPressed});

  final String textButton;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              elevation: 0,
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              foregroundColor: textStyle.bodyMedium?.color,
              textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          child: Text(textButton)),
    );
  }
}
