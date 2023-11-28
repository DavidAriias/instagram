import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/domain/entities/entities.dart';
import 'package:instagram/presentation/providers/providers.dart';
import 'package:instagram/presentation/widgets/add/location_pop_up_surface.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class SharePostScreen extends ConsumerWidget {
  static const String name = 'share-post-screen';
  const SharePostScreen({super.key});

  void showSnackBar(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;

    final iconColor = Theme.of(context).iconTheme.color;
    final dividerColor = Colors.grey.shade300.withOpacity(0.3);
    final labelTextStyle =
        textStyle.bodyLarge?.copyWith(fontWeight: FontWeight.w400);

    final post = ref.watch(postProvider);
    final locations = ref.watch(listLocationProvider);

    ref.listen(postProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;
      showSnackBar(context, next.errorMessage);
    });

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
                  color: Colors.blue,
                  textButton: 'Share',
                  onPressed: ref.read(postProvider.notifier).onCreatePost)
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                CustomCupertinoTextField(
                  prefix: Image(
                    fit: BoxFit.scaleDown,
                    width: 80,
                    height: 80,
                    image: FileImage(File(post.media.first.path)),
                  ),
                  readOnly: false,
                  placeholder: ref.read(postProvider).caption.isEmpty
                      ? 'Write a caption...'
                      : ref.read(postProvider).caption,
                  onChanged: ref.read(postProvider.notifier).onChangeCaption,
                ),
                Divider(color: dividerColor),
                (post.location == null)
                    ? CustomCupertinoTextField(
                        readOnly: true,
                        prefix: Text('Add location', style: labelTextStyle),
                        suffix: const LocationPopUpSurface())
                    : CustomCupertinoTextField(
                        onTap: ref.read(postProvider.notifier).onResetLocation,
                        readOnly: true,
                        prefix: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            post.location!.name,
                            style: labelTextStyle),
                        suffix: const Icon(Icons.close, color: Colors.grey)),
                (post.location == null)
                    ? _ListOptions(options: locations)
                    : const SizedBox.shrink(),
                Divider(color: dividerColor),
                CustomCupertinoTextField(
                    onTap: () => context.pop(),
                    readOnly: true,
                    prefix: Text('Add Music', style: labelTextStyle),
                    suffix: const Icon(CupertinoIcons.chevron_forward,
                        color: Colors.grey)),
                (post.song != null)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CustomButtonRectanguleGrey(
                          onPressed:
                              ref.read(postProvider.notifier).onResetSong,
                          height: 30,
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text('${post.song!.name}-${post.song!.artist}',
                              overflow: TextOverflow.ellipsis,
                              style: textStyle.labelLarge
                                  ?.copyWith(color: Colors.black)),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ListOptions extends ConsumerWidget {
  const _ListOptions({
    required this.options,
  });

  final List<LocationEntity> options;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    return SizedBox(
      height: 30,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: options.length,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: CustomButtonRectanguleGrey(
                  height: 50,
                  width: 180,
                  alignment: Alignment.center,
                  onPressed: () => ref
                      .read(postProvider.notifier)
                      .onChangeLocation(options[index]),
                  child: Text(
                    maxLines: 1,
                    options[index].name,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.labelLarge?.copyWith(color: Colors.black),
                  ),
                ),
              )),
    );
  }
}
