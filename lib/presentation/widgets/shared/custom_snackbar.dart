import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final BuildContext context;
  final String message;
  final Duration duration;

  const CustomSnackBar({
    super.key, 
    required this.context,
    required this.message,
    this.duration = const Duration(seconds: 2),
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    });

    return const SizedBox.shrink();
  }
}
