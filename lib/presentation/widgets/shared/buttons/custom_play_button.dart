import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class CustomPlayButton extends StatefulWidget {
  const CustomPlayButton({super.key, required this.audioUrl});

  final String audioUrl;

  @override
  State<CustomPlayButton> createState() => _CustomPlayButtonState();
}

class _CustomPlayButtonState extends State<CustomPlayButton> {
  late AudioPlayer _audioPlayer;
  late double _progress = 0.0; // Nuevo
  bool _isCompleted = false;

  final List<Color> gradientColors = const [
    Color(0xFFFCAF45),
    Color(0xFFFFDC80),
    Color(0xFFF56040),
    Color(0xFFF77737),
    Color(0xFFFD1D1D),
    Color(0xFFE1306C),
    Color(0xFFC13584),
    Color(0xFFDF00FF),
    Color(0xFF833ABA),
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setUrl(widget.audioUrl);
    _audioPlayer.positionStream.listen((Duration position) {
      if (mounted) {
        setState(() {
          _progress = _audioPlayer.duration != null
              ? position.inMilliseconds / _audioPlayer.duration!.inMilliseconds
              : 0.0;
        });
      }
    });

    // Agregar el listener para la finalización del audio
    _audioPlayer.processingStateStream.listen((processingState) {
      if (mounted) {
        if (processingState == ProcessingState.completed) {
          // Audio completado
          setState(() {
            _isCompleted = true;
          });
        } else {
          // Reproducción en curso
          setState(() {
            _isCompleted = false;
          });
        }
      }
    });
  }

  Color calculateProgressColor() {
    int totalSegments = gradientColors.length;
    int currentSegment = (_progress * totalSegments).floor();
    double segmentProgress = (_progress * totalSegments) - currentSegment;

    if (currentSegment < totalSegments - 1) {
      // Blend colors for smoother transition
      return Color.lerp(
        gradientColors[currentSegment],
        gradientColors[currentSegment + 1],
        segmentProgress,
      )!;
    } else {
      return gradientColors.last;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color progressColor = calculateProgressColor();

    return CupertinoButton(
      onPressed: () async {
        if (_audioPlayer.playing) {
          await _audioPlayer.pause();
        } else {
          await _audioPlayer.play();
        }

        // Si el audio está completado, hacer reset
        if (_isCompleted) {
          if (mounted) {
            _audioPlayer.seek(Duration.zero);
            _audioPlayer.pause();
            setState(() {
              _progress = 0.0;
              _isCompleted = false;
            });
          }
        } else {
          if (mounted) {
            setState(() {});
          }
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 2,
            value: _progress,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
          Icon(
            _audioPlayer.playing || _isCompleted
                ? Icons.pause
                : Icons.play_arrow,
            color: Colors.white,
            size: 25,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
