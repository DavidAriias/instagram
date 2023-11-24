import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/presentation/providers/providers.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class ReordableImageList extends ConsumerStatefulWidget {
  const ReordableImageList({super.key, this.imageExtent});

  final double? imageExtent;

  @override
  ReordableImageListState createState() => ReordableImageListState();
}

class ReordableImageListState extends ConsumerState<ReordableImageList> {
  @override
  Widget build(BuildContext context) {
    final images = ref.watch(listCameraProvider);
    return ReorderableListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemExtent: widget.imageExtent,
      scrollDirection: Axis.horizontal,
      itemCount: images.length < 10 ? images.length + 1 : 10,
      itemBuilder: (context, index) {
        if (index < images.length) {
          return _ImageStack(
            currentIndex: index,
            imageLength: images.length,
            key: Key('$index'),
            image: images[index],
            imageExtent: widget.imageExtent,
            onRemove: () {
              setState(() {
                ref.read(listCameraProvider.notifier).onRemove(index);
              });
            },
          );
        } else {
          // Elemento adicional al final de la lista si hay menos de 10 imágenes
          return _AddImages(
            key: const Key('addImages'),
            imageExtent: widget.imageExtent,
          );
        }
      },
      onReorder: (oldIndex, newIndex) {
        if (oldIndex + 1 == images.length + 1) return;

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

class _ImageStack extends StatelessWidget {
  const _ImageStack({
    super.key,
    required this.image,
    this.imageExtent,
    required this.onRemove,
    required this.currentIndex,
    required this.imageLength,
  });

  final String image;
  final double? imageExtent;
  final VoidCallback onRemove;
  final int currentIndex;
  final int imageLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            fit: BoxFit.cover,
            image: FileImage(File(image)),
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
              onPressed: onRemove,
              child: const Icon(Icons.close, color: Colors.white),
            ),
          ),
          ImageCounter(
            showCounter: true,
            currentIndex: currentIndex, // Asegúrate de definir currentIndex
            imagesLength: imageLength, // Asegúrate de definir images
            top: 10,
            left: 10,
          ),
        ],
      ),
    );
  }
}

class _AddImages extends ConsumerWidget {
  const _AddImages({super.key, this.imageExtent});

  final double? imageExtent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        width: imageExtent,
        child: Center(
            child: CustomIconCupertinoButton(
                onPressed: ref.read(listCameraProvider.notifier).selectMedia,
                child: const Icon(Icons.add_circle_outline,
                    size: 100, color: Colors.grey))),
      ),
    );
  }
}
