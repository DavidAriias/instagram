import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/presentation/providers/music/music_provider.dart';
import 'package:just_audio/just_audio.dart';

class CustomPlayButton extends ConsumerStatefulWidget {
  const CustomPlayButton({super.key, required this.audioUrl});

  final String audioUrl;

  @override
  CustomPlayButtonState createState() => CustomPlayButtonState();
}

class CustomPlayButtonState extends ConsumerState<CustomPlayButton> {
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
    _initializeAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _initializeAudioPlayer() async {
    _audioPlayer = AudioPlayer();
    if (widget.audioUrl.isNotEmpty) {
      try {
        await _audioPlayer.setUrl(widget.audioUrl);
      } catch (e) {
        //TODO : MANEJRA EXCEPTION
      }
    }

    _audioPlayer.positionStream.listen((Duration position) {
      if (mounted) {
        setState(() {
          _progress = _audioPlayer.duration != null &&
                  _audioPlayer.duration!.inMilliseconds > 0
              ? position.inMilliseconds / _audioPlayer.duration!.inMilliseconds
              : 0.0;
        });
      }
    });

    _audioPlayer.processingStateStream.listen((processingState) {
      if (mounted) {
        if (processingState == ProcessingState.completed) {
          setState(() {
            _isCompleted = true;
          });
        } else {
          setState(() {
            _isCompleted = false;
          });
        }

        if (processingState == ProcessingState.loading) {
          ref.read(musicProvider.notifier).isLoading = true;
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant CustomPlayButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Si la URL del audio ha cambiado, actualiza el reproductor de audio
    if (widget.audioUrl != oldWidget.audioUrl) {
      _audioPlayer.dispose(); // Libera los recursos del reproductor anterior
      _initializeAudioPlayer();
    }
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
}
