import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/presentation/providers/providers.dart';
import 'package:instagram/presentation/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

import '../../../domain/entities/entities.dart';

class ReordableMediaList extends ConsumerStatefulWidget {
  const ReordableMediaList({super.key, this.mediaExtent});

  final double? mediaExtent;

  @override
  ReordableImageListState createState() => ReordableImageListState();
}

class ReordableImageListState extends ConsumerState<ReordableMediaList> {
  @override
  Widget build(BuildContext context) {
    final media = ref.watch(listCameraProvider);
    return ReorderableListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemExtent: widget.mediaExtent,
      scrollDirection: Axis.horizontal,
      itemCount: media.length < 10 ? media.length + 1 : 10,
      itemBuilder: (context, index) {
        if (index < media.length) {
          return _MediaStack(
            currentIndex: index,
            mediaLength: media.length,
            key: Key('$index'),
            media: media[index],
            mediaExtent: widget.mediaExtent,
            onRemove: () {
              setState(() {
                ref.read(listCameraProvider.notifier).onRemove(index);
              });
            },
          );
        } else {
          // Elemento adicional al final de la lista si hay menos de 10 imágenes
          return _AddMoreMedia(
            key: const Key('addImages'),
            mediaExtent: widget.mediaExtent,
          );
        }
      },
      onReorder: (oldIndex, newIndex) {
        if (oldIndex + 1 == media.length + 1) return;

        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final item = ref.read(listCameraProvider).removeAt(oldIndex);
          ref.read(listCameraProvider).insert(newIndex, item);
        });
      },
    );
  }
}

class _MediaStack extends StatefulWidget {
  const _MediaStack({
    super.key,
    required this.media,
    this.mediaExtent,
    required this.onRemove,
    required this.currentIndex,
    required this.mediaLength,
  });

  final Media media;
  final double? mediaExtent;
  final VoidCallback onRemove;
  final int currentIndex;
  final int mediaLength;

  @override
  State<_MediaStack> createState() => _MediaStackState();
}

class _MediaStackState extends State<_MediaStack> {
  //late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          (!widget.media.isImage)
          //TODO: EVITAR REDIBUJO DE LOS WIDGETS Y CHECAR LO DEL CONTROLLER
              ? CustomVideoPlayer(videoController: VideoPlayerController.file(File(widget.media.path))..play()..setVolume(1))
              : Image(
                  fit: BoxFit.contain,
                  image: FileImage(File(widget.media.path)),
                ),
          CustomGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.1, 0.3],
            colors: const [Colors.black38, Colors.transparent],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: CustomIconCupertinoButton(
              onPressed: widget.onRemove,
              child: const Icon(Icons.close, color: Colors.white),
            ),
          ),
          ImageCounter(
            showCounter: true,
            currentIndex:
                widget.currentIndex, // Asegúrate de definir currentIndex
            imagesLength: widget.mediaLength, // Asegúrate de definir media
            top: 10,
            left: 10,
          ),
        ],
      ),
    );
  }
}

class _AddMoreMedia extends ConsumerWidget {
  const _AddMoreMedia({super.key, this.mediaExtent});

  final double? mediaExtent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        width: mediaExtent,
        child: Center(
            child: CustomIconCupertinoButton(
                onPressed: ref.read(listCameraProvider.notifier).selectMedia,
                child: const Icon(Icons.add_circle_outline,
                    size: 100, color: Colors.grey))),
      ),
    );
  }
}
