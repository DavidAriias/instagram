class Song {
  final String id;
  final List<String>? imagesUrl;
  final String name;
  final String artist;
  final double duration;
  final String previewUrl;
  final String album;

  Song(
      {this.id = '',
      this.imagesUrl,
      this.name = '',
      this.artist = '',
      this.duration = 0.0,
      this.previewUrl = '',
      this.album = ''});
}
