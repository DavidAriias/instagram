import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/presentation/providers/camera/list_camera_provider.dart';

import '../../widgets/widgets.dart';

class AddScreen extends StatelessWidget {
  static const String name = 'add-screen';
  final Widget childView;
  const AddScreen({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: childView,
      floatingActionButton: _CustomMediaNavigation(width: width / 2),
    );
  }
}

class _CustomMediaNavigation extends ConsumerWidget {
  const _CustomMediaNavigation({
    required this.width,
  });

  final double? width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(color: Colors.white12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextButton(
                  padding: const EdgeInsets.all(0),
                  textButton: 'Post',
                  onPressed: () {
                    ref.read(listCameraProvider.notifier).onReset();
                    context.go('/add');
                  }),
              CustomTextButton(
                  padding: const EdgeInsets.all(0),
                  textButton: 'Story',
                  onPressed: () {
                    ref.read(listCameraProvider.notifier).onReset();
                    context.push('/story');
                  }),
              CustomTextButton(
                  padding: const EdgeInsets.all(0),
                  textButton: 'Reel',
                  onPressed: () {
                    ref.read(listCameraProvider.notifier).onReset();
                    context.push('/reel');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
