import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/config/config.dart';
import 'package:instagram/presentation/providers/providers.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

import '../../providers/music/list_music_provider.dart';

class LocationPopUpSurface extends ConsumerWidget {
  const LocationPopUpSurface({super.key, this.onSongSelected});

  final FutureOr<void> Function()? onSongSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceHeight = MediaQuery.of(context).size.height;

    final textStyle = Theme.of(context).textTheme;
    final iconColor = Theme.of(context).iconTheme.color;

    final controller = TextEditingController();

    return CustomIconCupertinoButton(
        onPressed: () => showCupertinoModalPopup(
              context: context,
              builder: (context) => Consumer(
                builder: (context, ref, child) {
                  final songs = ref.watch(listMusicProvider);
                  return CustomCupertinoPopUpSurface(
                    onVerticalDragUpdate: (_) {
                      context.pop();
                      controller.clear();
                      ref.read(listMusicProvider.notifier).onResetSongs();
                    },
                    height: deviceHeight / 1.1,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: CupertinoSearchTextField(
                                controller: controller,
                                style: textStyle.titleSmall,
                                autofocus: true,
                                onChanged: ref
                                    .read(listMusicProvider.notifier)
                                    .searchSongs,
                                onSuffixTap: () {
                                  controller.clear();
                                  ref
                                      .read(listMusicProvider.notifier)
                                      .onResetSongs();
                                }),
                          ),
                          CustomTextButton(
                            textButton: 'Cancel',
                            onPressed: () {
                              controller.clear();
                              context.pop();
                              ref
                                  .read(listMusicProvider.notifier)
                                  .onResetSongs();
                            },
                          )
                        ],
                      ),
                      Flexible(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: songs.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onDoubleTap: () {
                              ref.read(listCameraProvider.notifier).onSend();
                              ref
                                  .read(musicProvider.notifier)
                                  .onSelectedSong(songs[index]);
                              songs[index];
                              onSongSelected?.call();
                            },
                            child: CupertinoListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CustomCacheImageNetwork(
                                  placeholder: (context, string) =>
                                      const ShimmerEffect(),
                                  imageUrl: songs[index].imagesUrl!.first,
                                ),
                              ),
                              leadingSize: 60,
                              title: Text(songs[index].name,
                                  style: textStyle.bodyLarge),
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
                      ),
                    ],
                  );
                },
              ),
            ),
        child:  Icon(CupertinoIcons.chevron_forward, color: iconColor));
  }
}
