import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class PostScreen extends StatelessWidget {
  static const String name = 'post-screen';
  final String postId;
  const PostScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _PostView(postId: postId),
    );
  }
}

class _PostView extends ConsumerWidget {
  const _PostView({
    required this.postId,
  });

  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(mainUserProvider);
    final posts = ref.watch(listPostProvider);

    final textStyle = Theme.of(context).textTheme;
    final iconColor = Theme.of(context).iconTheme.color;
    
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        CustomAppBar(
          centerTitle: true,
          title: Column(
            children: [
              Text(profile.username.toUpperCase(),
                  style:
                      textStyle.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: Colors.grey)),
              Text('Posts', style: textStyle.titleMedium?.copyWith(fontWeight: FontWeight.w600))
            ],
          ),
          leadingWidth: 56,
          padding: const EdgeInsets.all(0),
          leading: CustomIconCupertinoButton(
              onPressed: () => context.pop(),
              child: Icon(Icons.arrow_back_ios_new, color: iconColor)),
          pinned: true,
        ),

        SliverList.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) => FeedPost(
            isVerificated: profile.isVerificated,
            username: profile.username,
            post: posts[index],
          )
        )
          
      ],
    );
  }
}
