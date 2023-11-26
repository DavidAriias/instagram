import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class SharePostScreen extends StatelessWidget {
  static const String name = 'share-post-screen';
  const SharePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final iconColor = Theme.of(context).iconTheme.color;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          CustomAppBar(
            centerTitle: true,
            leadingWidth: 56,
            leading: CustomIconCupertinoButton(
                onPressed: () => context.pop(),
                child: Icon(CupertinoIcons.back, color: iconColor)),
            padding: const EdgeInsets.all(0),
            title: Text('New post',
                style: textStyle.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            actions: [
              CustomTextButton(
                  color: Colors.blue, textButton: 'Share', onPressed: () {})
            ],
          ),
        ],
      ),
    );
  }
}
