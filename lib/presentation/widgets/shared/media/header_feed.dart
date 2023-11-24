import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets.dart';

class HeaderFeed extends StatelessWidget {
  const HeaderFeed({super.key, 
  this.imageProfile,
  required this.username,
  this.isVerificated = false});

  final String? imageProfile;
  final String username;
  final bool isVerificated;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          UserAvatarWithoutGradient(image: imageProfile, radius: 18),
          const SizedBox(width: 8),
          _DataMedia(
            username: username,
            isVerificated: isVerificated,
          ),
          const Spacer(),
          const _MoreButton()
        ],
      ),
    );
  }
}


class _DataMedia extends StatelessWidget {
  const _DataMedia({required this.username, this.isVerificated = false});

  final String username;
  final bool isVerificated;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          children: [
            Text(username, style: textStyle.titleMedium),
            const SizedBox(width: 5),
            (isVerificated) ? const Icon(Icons.verified, color: Colors.blue, size: 12) : const SizedBox.shrink()
          ],
        )
      ],
    );
  }
}

class _MoreButton extends StatelessWidget {
  const _MoreButton();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final iconColor = Theme.of(context).iconTheme.color;
    final color = Theme.of(context).cardColor;
    return IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {
          showCupertinoModalPopup(
            context: context,
            builder: (context) => CupertinoPopupSurface(
              child: Container(
                color: color,
                width: double.infinity,
                height: size.height / 2.5,
                child: _ColumnPopUp(
                  iconColor: iconColor,
                  width: size.width,
                ),
              ),
            ),
          );
        },
        icon: Icon(
          Icons.more_horiz,
          color: iconColor,
        ));
  }
}

class _ColumnPopUp extends StatelessWidget {
  const _ColumnPopUp({required this.iconColor, required this.width});
  final Color? iconColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        children: [
          /*CustomButtonRectanguleGrey(
            width: width / 3,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetsConsts.saveIcon,
                    height: 22, width: 22, color: iconColor),
                
              ],
            ),
          )*/
        ],
      ),
    );
  }
}
