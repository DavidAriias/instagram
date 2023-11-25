import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/presentation/providers/camera/list_camera_provider.dart';
import 'package:instagram/presentation/providers/music/music_provider.dart';

import '../../widgets/widgets.dart';

class AddView extends ConsumerWidget {
  const AddView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final textStyle = Theme.of(context).textTheme;

    final imagesList = ref.watch(listCameraProvider);  

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        CustomAppBar(
          centerTitle: true,
          leadingWidth: 56,
          padding: const EdgeInsets.all(0),
          title: (imagesList.isEmpty)
              ? Text('New post',
                  style: textStyle.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600))
              : const MusicPopUpSurface(
             
              ),
          actions: [
            CustomTextButton(
              color: imagesList.isEmpty ? Colors.grey : Colors.blue,
              textButton: 'Next',
              onPressed: imagesList.isEmpty ? null : () => {},
            )
          ],
        ),
        SliverToBoxAdapter(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 30),
            SizedBox(
              height: size.height / 2,
              child: (imagesList.isEmpty)
                  ? Container(
                      color: Colors.white38,
                      child: Center(
                          child: CustomIconCupertinoButton(
                              onPressed: ref
                                  .read(listCameraProvider.notifier)
                                  .selectMedia,
                              child: const Icon(
                                  CupertinoIcons.photo_on_rectangle,
                                  color: Colors.white,
                                  size: 100))))
                  : ReordableImageList(imageExtent: size.width / 1.2),
            ),
            SizedBox(height: size.height / 6),
          ],
        ))
      ],
    );
  }
}
