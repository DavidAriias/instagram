import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class MediaGridPage extends StatelessWidget {
  final double childAspectRatio; //Es el tamaño de cada contenido del grid
  final List<String> urls; //Son las urls de la media
  final Widget icon; //Es el icono superior del lado derecho
  final String
      titleForNonContent; //Por si no hay contenido que mostrar, se muestra un texto
  final String subtitleForNonContent;
  final String pagePath;
  final List<String> mediaIds;

  const MediaGridPage({
    super.key,
    required this.childAspectRatio,
    required this.urls,
    required this.icon,
    required this.titleForNonContent,
    required this.subtitleForNonContent,
    this.pagePath = '',
    this.mediaIds = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (urls.isEmpty) {
      // Muestra un Center si la lista de URLs está vacía
      return NotFoundContent(
        title: titleForNonContent,
        subtitle: subtitleForNonContent,
        icon: icon,
      );
    }
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1.5,
          mainAxisSpacing: 1.5,
          childAspectRatio: childAspectRatio),
      itemCount: urls.length,
      itemBuilder: (BuildContext context, int index) {
        CachedNetworkImageProvider imageProvider =
            CachedNetworkImageProvider(urls[index]);

        // Precache the image
        precacheImage(imageProvider, context);

        return FutureBuilder(
          future: precacheImage(imageProvider, context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GestureDetector(
                onTap: () {
                  if (pagePath.isEmpty) return;
                  context.push('/profile$pagePath${mediaIds[index]}');
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: urls[index],
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: icon,
                    ),
                  ],
                ),
              );
            } else {
              return const ShimmerEffect();
            }
          },
        );
      },
    );
  }
}
