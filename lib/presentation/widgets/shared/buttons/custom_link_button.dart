import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class CustomLinkButton extends StatelessWidget {
  const CustomLinkButton({super.key, 
  required this.link,
  required this.label,
  this.icon});

  final String link;
  final String label;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Link(
        target: LinkTarget.defaultTarget,
        uri: Uri.parse(link),
        builder: (context, followLink) => TextButton.icon(
            onPressed: followLink,
            style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
            icon: icon ?? const SizedBox.shrink(),
            label: Text(label)));
  }
}
