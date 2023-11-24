import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class MusicPopUpSurface extends StatelessWidget {
  const MusicPopUpSurface({super.key, this.onTap});

  final FutureOr<void> Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final textStyle = Theme.of(context).textTheme;
    return CustomIconCupertinoButton(
      onPressed: () => showCupertinoModalPopup(
        context: context,
        builder: (context) =>
            CustomCupertinoPopUpSurface(height: deviceHeight / 1.1, children: [
          Row(
            children: [
              const Flexible(
                child: CupertinoSearchTextField(
                  autofocus: true,
                ),
              ),
              CustomTextButton(
                  textButton: 'Cancel', onPressed: () => context.pop())
            ],
          ),
          Flexible(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) => CupertinoListTile(
                onTap: onTap,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CustomCacheImageNetwork(
                    placeholder: (context, string) => const ShimmerEffect(),
                    imageUrl:  'https://www.coldplay.com/wp/wp-content/uploads/2021/07/MOTS-COVER-1000-600x600.jpg')
                ),
                leadingSize: 60,
                title: Text('My universe', style: textStyle.bodyLarge),
                subtitle: Text('Coldplay,BTS - 3:48', style: textStyle.bodyMedium?.copyWith(color: Colors.white54)),
                trailing: CustomPlayButton(
                  audioUrl: 'https://p.scdn.co/mp3-preview/0790eb03d0d2b6aac7c9c762bc2bf1f3649dd7ca?cid=51f0e6b2845c46c993e4fa27def68d04'),
                padding: const EdgeInsets.all(5),
              ),
            ),
          )
        ]),
      ),
      child: const Icon(CupertinoIcons.music_note_2, color: Colors.white),
    );
  }
}
