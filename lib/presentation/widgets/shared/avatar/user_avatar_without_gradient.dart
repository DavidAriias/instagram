import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../config/config.dart';

class UserAvatarWithoutGradient extends StatelessWidget {
  const UserAvatarWithoutGradient({super.key, this.radius, this.image});

  final double? radius;
  final String? image;

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> imageProvider;

    if (image == null) {
      imageProvider = const AssetImage(AssetsConsts.avatarDefault);
    } else if (image!.startsWith('http')) {
      imageProvider = NetworkImage(image!);
    } else {
      imageProvider = FileImage(File(image!));
    }

    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: radius,
      backgroundImage: imageProvider,
    );
  }
}
