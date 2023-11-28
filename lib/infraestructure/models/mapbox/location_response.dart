class LocationResponse {
    final String type;
    final List<String> query;
    final List<Feature> features;
    final String attribution;

    LocationResponse({
        required this.type,
        required this.query,
        required this.features,
        required this.attribution,
    });

    factory LocationResponse.fromJson(Map<String, dynamic> json) => LocationResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
    };
}

class Feature {
    final String id;
    final String type;
    final List<String> placeType;
    final double relevance;
    final Properties properties;
    final String text;
    final String placeName;
    final String? matchingText;
    final String? matchingPlaceName;
    final List<double>? bbox;
    final List<double> center;
    final Geometry geometry;
    final List<Context> context;
    final String? address;

    Feature({
        required this.id,
        required this.type,
        required this.placeType,
        required this.relevance,
        required this.properties,
        required this.text,
        required this.placeName,
        this.matchingText,
        this.matchingPlaceName,
        this.bbox,
        required this.center,
        required this.geometry,
        required this.context,
        this.address,
    });

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"]?.toDouble(),
        properties: Properties.fromJson(json["properties"]),
        text: json["text"],
        placeName: json["place_name"],
        matchingText: json["matching_text"],
        matchingPlaceName: json["matching_place_name"],
        bbox: json["bbox"] == null ? [] : List<double>.from(json["bbox"]!.map((x) => x?.toDouble())),
        center: List<double>.from(json["center"].map((x) => x?.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        context: List<Context>.from(json["context"]?.map((x) => Context.fromJson(x)) ?? []),
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "relevance": relevance,
        "properties": properties.toJson(),
        "text": text,
        "place_name": placeName,
        "matching_text": matchingText,
        "matching_place_name": matchingPlaceName,
        "bbox": bbox == null ? [] : List<dynamic>.from(bbox!.map((x) => x)),
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "context": List<dynamic>.from(context.map((x) => x.toJson())),
        "address": address,
    };
}

class Context {
    final String id;
    final String? mapboxId;
    final String? wikidata;
    final String text;
    final String? shortCode;

    Context({
        required this.id,
        required this.mapboxId,
        this.wikidata,
        required this.text,
        this.shortCode,
    });

    factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        mapboxId: json["mapbox_id"],
        wikidata: json["wikidata"],
        text: json["text"],
        shortCode: json["short_code"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mapbox_id": mapboxId,
        "wikidata": wikidata,
        "text": text,
        "short_code": shortCode,
    };
}

class Geometry {
    final String type;
    final List<double> coordinates;
    final bool? interpolated;

    Geometry({
        required this.type,
        required this.coordinates,
        this.interpolated,
    });

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        interpolated: json["interpolated"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "interpolated": interpolated,
    };
}

class Properties {
    final String? mapboxId;
    final String? accuracy;

    Properties({
        required this.mapboxId,
        this.accuracy,
    });

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        mapboxId: json["mapbox_id"],
        accuracy: json["accuracy"],
    );

    Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
        "accuracy": accuracy,
    };
}