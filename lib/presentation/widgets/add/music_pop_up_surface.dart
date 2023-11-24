import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class MusicPopUpSurface extends StatelessWidget {
  const MusicPopUpSurface({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return CustomIconCupertinoButton(
      onPressed: () => showCupertinoModalPopup(
        context: context,
        builder: (context) => CustomCupertinoPopUpSurface(
          height: deviceHeight / 1.1,
          children: []
        ),
      ),
      child: const Icon(CupertinoIcons.music_note_2, color: Colors.white),
    );
  }
}
