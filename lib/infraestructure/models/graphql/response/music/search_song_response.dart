class SearchSongResponse {
    final SearchSongByName searchSongByName;

    SearchSongResponse({
        required this.searchSongByName,
    });

    factory SearchSongResponse.fromJson(Map<String, dynamic> json) => SearchSongResponse(
        searchSongByName: SearchSongByName.fromJson(json["searchSongByName"]),
    );

    Map<String, dynamic> toJson() => {
        "searchSongByName": searchSongByName.toJson(),
    };
}

class SearchSongByName {
    final List<SongNode> nodes;

    SearchSongByName({
        required this.nodes,
    });

    factory SearchSongByName.fromJson(Map<String, dynamic> json) => SearchSongByName(
        nodes: List<SongNode>.from(json["nodes"].map((x) => SongNode.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "nodes": List<dynamic>.from(nodes.map((x) => x.toJson())),
    };
}

class SongNode {
    final String songName;
    final String uri;
    final String artistName;
    final String previewUrl;
    final double duration;
    final List<ImagesAlbum> imagesAlbum;
    final String albumName;

    SongNode({
        required this.songName,
        required this.uri,
        required this.artistName,
        required this.previewUrl,
        required this.duration,
        required this.imagesAlbum,
        required this.albumName,
    });

    factory SongNode.fromJson(Map<String, dynamic> json) => SongNode(
        songName: json["songName"],
        uri: json["uri"],
        artistName: json["artistName"],
        previewUrl: json["previewUrl"],
        duration: json["duration"] is int ? json["duration"]?.toDouble() : json["duration"],
        imagesAlbum: List<ImagesAlbum>.from(json["imagesAlbum"].map((x) => ImagesAlbum.fromJson(x))),
        albumName: json["albumName"],
    );

    Map<String, dynamic> toJson() => {
        "songName": songName,
        "uri": uri,
        "artistName": artistName,
        "previewUrl": previewUrl,
        "duration": duration,
        "imagesAlbum": List<dynamic>.from(imagesAlbum.map((x) => x.toJson())),
        "albumName": albumName,
    };
}

class ImagesAlbum {
    final int height;
    final int width;
    final String url;

    ImagesAlbum({
        required this.height,
        required this.width,
        required this.url,
    });

    factory ImagesAlbum.fromJson(Map<String, dynamic> json) => ImagesAlbum(
        height: json["height"],
        width: json["width"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "width": width,
        "url": url,
    };
}
