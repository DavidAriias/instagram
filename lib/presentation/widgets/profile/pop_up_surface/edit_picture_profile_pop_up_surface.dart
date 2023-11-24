import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/presentation/providers/providers.dart';
import '../../widgets.dart';

class EditPictureProfilePopUpSurface extends ConsumerWidget {
  const EditPictureProfilePopUpSurface(
      {super.key,
      this.iconColor,
      this.dividerColor,
      this.padding = const EdgeInsets.symmetric(vertical: 5),
      this.image});

  final Color? iconColor;
  final Color? dividerColor;
  final EdgeInsetsGeometry padding;
  final String? image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    return CustomTextButton(
      color: Colors.blue,
      textButton: 'Edit picture',
      onPressed: () => showCupertinoModalPopup(
          context: context,
          builder: (context) => CustomCupertinoPopUpSurface(
                children: [
                  UserAvatarWithoutGradient(image: image, radius: 25),
                  const SizedBox(height: 10),
                  Divider(color: dividerColor),
                  const SizedBox(height: 30),
                  CustomIconRowButton(
                      onTap: () {
                        context.pop();
                        ref.read(cameraProvider.notifier).selectPhoto();
                      },
                      icon: Icon(Icons.image_outlined, color: iconColor),
                      label: 'Choose from library',
                      style: textStyle.titleMedium),
                  const SizedBox(height: 30),
                  CustomIconRowButton(
                      onTap: () {
                        context.pop();
                        ref.read(cameraProvider.notifier).takePhoto();
                      },
                      icon: Icon(Icons.camera_alt_outlined, color: iconColor),
                      label: 'Take photo',
                      style: textStyle.titleMedium),
                  const SizedBox(height: 30),
                  (image != null)
                      ? CustomIconRowButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.red),
                          label: 'Remove current picture',
                          style: textStyle.titleMedium
                              ?.copyWith(color: Colors.red))
                      : const SizedBox.shrink(),
                ],
              )),
    );
  }
}
