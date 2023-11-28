import 'package:instagram/infraestructure/models/models.dart';

class SongMediaInput {
  final String artist;
  final String title;
  final double totalDuration;
  final String url;
  final DurationSelectionInput durationSelection;

  SongMediaInput({required this.artist, required this.title, required this.totalDuration, required this.url, required this.durationSelection});

  
}
