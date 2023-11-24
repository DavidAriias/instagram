import 'package:flutter/material.dart';

class NotFoundContent extends StatelessWidget {
  const NotFoundContent(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});

  final String title;
  final String subtitle;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Text(
            title,
            style:
                textStyle.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(subtitle,
              textAlign: TextAlign.center,
              style: textStyle.bodyMedium?.copyWith(color: Colors.grey))
        ],
      ),
    );
  }
}
