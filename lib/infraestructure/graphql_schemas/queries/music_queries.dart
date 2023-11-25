class MusicQueries {
  static String searchSongByName = r'''
query SearchSongs($trackName: String!, $first: Int!) {
  searchSongByName(trackName: $trackName, first: $first) {
    nodes {
      songName
      uri
      artistName
      previewUrl
      duration
      imagesAlbum {
        height
        width
        url
      }
      albumName
    }
  }
}
''';
}
