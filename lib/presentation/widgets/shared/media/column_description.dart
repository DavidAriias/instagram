import 'package:flutter/material.dart';
import 'package:instagram/config/helpers/date_helper.dart';

import '../../../../domain/entities/entities.dart';
import '../../widgets.dart';

class ColumnDescription extends StatelessWidget {
  const ColumnDescription(
      {super.key,
      required this.username,
      required this.caption,
      required this.comments,
      required this.datePublication,
      required this.likes});

  final String username;
  final String caption;
  final int likes;
  final DateTime datePublication;
  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (likes > 0)
                ? Text(likes.toString(), style: textStyle.titleMedium)
                : const SizedBox.shrink(),
            (caption.isNotEmpty)
                ? ExpandText(username: username, text: caption)
                : const SizedBox.shrink(),
            (comments.isNotEmpty)
                ? CommentButton(comments: comments.length)
                : const SizedBox.shrink(),
            _DateMedia(datePublication: datePublication, textStyle: textStyle)
          ],
        ));
  }
}

class _DateMedia extends StatelessWidget {
  const _DateMedia({
    required this.textStyle,
    required this.datePublication,
  });

  final TextTheme textStyle;
  final DateTime datePublication;

  @override
  Widget build(BuildContext context) {
    return Text(DateHelper.formatPostDate(datePublication),
        style: TextStyle(
            color: Colors.grey, fontSize: textStyle.bodyMedium?.fontSize));
  }
}
