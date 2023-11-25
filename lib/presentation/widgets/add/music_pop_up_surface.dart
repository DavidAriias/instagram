import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/config/config.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

import '../../providers/music/music_provider.dart';

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
        builder: (context) => Consumer(
          builder: (context, ref, child) {
            final songs = ref.watch(musicProvider);
            return CustomCupertinoPopUpSurface(
              onVerticalDragUpdate: (_) {
                context.pop();
                ref.read(musicProvider.notifier).onResetSongs();
              },
              height: deviceHeight / 1.1,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: CupertinoSearchTextField(
                        style: textStyle.titleSmall,
                        autofocus: true,
                        onChanged: ref.read(musicProvider.notifier).searchSongs,
                        onSuffixTap:
                            ref.read(musicProvider.notifier).onResetSongs,
                      ),
                    ),
                    CustomTextButton(
                      textButton: 'Cancel',
                      onPressed: () {
                        context.pop();
                        ref.read(musicProvider.notifier).onResetSongs();
                      },
                    )
                  ],
                ),
                Flexible(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: songs.length,
                    itemBuilder: (context, index) => CupertinoListTile(
                      key: UniqueKey(),
                      onTap: onTap,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CustomCacheImageNetwork(
                          placeholder: (context, string) =>
                              const ShimmerEffect(),
                          imageUrl: songs[index].imagesUrl.first,
                        ),
                      ),
                      leadingSize: 60,
                      title:
                          Text(songs[index].name, style: textStyle.bodyLarge),
                      subtitle: Text(
                        '${songs[index].artist} - ${HumanFormatHelper.timeFormatter(songs[index].duration)}',
                        style: textStyle.bodyMedium
                            ?.copyWith(color: Colors.white54),
                      ),
                      trailing: CustomPlayButton(
                        key:
                            UniqueKey(), // Añade una clave única para forzar la reconstrucción del widget cuando cambia la URL
                        audioUrl: songs[index].previewUrl,
                      ),
                      padding: const EdgeInsets.all(5),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      child: const Icon(CupertinoIcons.music_note_2, color: Colors.white),
    );
  }
}
