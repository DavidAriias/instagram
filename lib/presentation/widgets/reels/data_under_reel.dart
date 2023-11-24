import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/presentation/widgets/widgets.dart';
import 'package:marquee/marquee.dart';

class DataUnderReel extends StatelessWidget {
  const DataUnderReel({super.key});

  final buttonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            AvatarWithGradient(radius: 20, radiusOutline: 2.1),
            const SizedBox(width: 8),
            Text('_yujin_an', style: textStyle.titleMedium),
            const SizedBox(width: 5),
            const Icon(Icons.verified, color: Colors.blue, size: 12),
            const SizedBox(width: 10),
            _FollowButton(
                buttonColor: buttonColor, labelText: 'Follow', onPressed: () {})
          ],
        ),
        _SemiTransparentLabel(
          icon: CupertinoIcons.music_note_2,
          width: 150,
          text: 'LE SSERAFIM - UNFORGIVEN',
        ),
      ],
    );
  }
}

class _SemiTransparentLabel extends StatelessWidget {
  const _SemiTransparentLabel({
    required this.icon,
    required this.width,
    required this.text,
  });

  final IconData icon;
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsetsDirectional.all(5),
      decoration: BoxDecoration(
          color: Colors.grey.shade800.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        children: [
          Icon(icon, size: 15),
          Container(
            margin: const EdgeInsets.only(left: 3),
            height: 20,
            width: width,
            child: Marquee(
              style: textStyle.bodySmall,
              text: text,
              velocity:
                  35, // Velocidad de desplazamiento (ajusta según tus preferencias)
              blankSpace:
                  10, // Espacio en blanco al final del texto antes de reiniciar el desplazamiento
              startPadding:
                  0, // Espacio en blanco al comienzo del texto antes de empezar el desplazamiento
              scrollAxis:
                  Axis.horizontal, // Dirección de desplazamiento horizontal
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Alineación del texto
            ),
          ),
        ],
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  const _FollowButton({
    required this.buttonColor,
    required this.labelText,
    required this.onPressed,
  });

  final Color buttonColor;
  final String labelText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(70, 30),
          foregroundColor: buttonColor,
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8.0), // Ajusta el valor del radio
          ),
        ),
        onPressed: onPressed,
        child: Text(labelText));
  }
}
