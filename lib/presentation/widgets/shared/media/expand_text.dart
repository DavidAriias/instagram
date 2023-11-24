import 'package:flutter/material.dart';

class ExpandText extends StatefulWidget {
  final String username;
  final String text;
  final int maxLines;

  const ExpandText({
    super.key,
    required this.username,
    required this.text,
    this.maxLines = 3,
  });

  @override
  State<ExpandText> createState() => _ExpandTextState();
}

class _ExpandTextState extends State<ExpandText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text: "${widget.username} ",
                style: textStyle.titleMedium
              ),
            
              TextSpan(
                text: widget.text,
                style: textStyle.bodyLarge,
                
              ),
            ],
          ),
          maxLines: !isExpanded ? null : widget.maxLines,
          overflow: TextOverflow.ellipsis,
        ),
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            !isExpanded ? 'More' : '',
            style: TextStyle(
              fontSize: textStyle.bodyLarge?.fontSize,
              color: Colors.grey
            ),
          ),
        ),
      ],
    );
  }
}
