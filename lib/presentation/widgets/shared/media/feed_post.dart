import 'package:flutter/material.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

import '../../../../domain/entities/entities.dart';

class FeedPost extends StatelessWidget {
  const FeedPost(
      {super.key,
      required this.username,
      required this.isVerificated,
      required this.post});

  final String username;
  final bool isVerificated;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderFeed(
          username: username,
          imageProfile: post.imageProfile,
          isVerificated: isVerificated,
        ),
        InstagramSwiper(
          mediaUrls: post.mediaUrls,
          mediaHeight: 500,
        ),
        ColumnDescription(
          username: username,
          caption: post.caption,
          comments: post.likes,
          datePublication: post.datePublication,
        )
      ],
    );
  }
}
