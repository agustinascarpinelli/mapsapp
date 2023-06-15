// To parse this JSON data, do
//
//     final queryResponse = queryResponseFromMap(jsonString);

import 'dart:convert';

class QueryResponse {
    String type;
   // List<String> query;
    List<Feature> features;
    String attribution;

    QueryResponse({
        required this.type,
      //  required this.query,
        required this.features,
        required this.attribution,
    });

    factory QueryResponse.fromJson(String str) => QueryResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory QueryResponse.fromMap(Map<String, dynamic> json) => QueryResponse(
        type: json["type"],
       // query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
    );

    Map<String, dynamic> toMap() => {
        "type": type,
       // "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        "attribution": attribution,
    };
}

class Feature {
    String id;
    String type;
    List<String> placeType;
    Properties properties;
    String text;
    String placeName;
    List<double> center;
    Geometry geometry;
    List<Context> context;

    Feature({
        required this.id,
        required this.type,
        required this.placeType,
        required this.properties,
        required this.text,
        required this.placeName,
        required this.center,
        required this.geometry,
        required this.context,
    });

    factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        properties: Properties.fromMap(json["properties"]),
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x?.toDouble())),
        geometry: Geometry.fromMap(json["geometry"]),
        context: List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),

        "properties": properties.toMap(),
        "text": text,
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toMap(),
        "context": List<dynamic>.from(context.map((x) => x.toMap())),
    };
}

class Context {
    String id;
    String? wikidata;
    String mapboxId;
    String text;
    String? shortCode;

    Context({
        required this.id,
        this.wikidata,
        required this.mapboxId,
        required this.text,
        this.shortCode,
    });

    factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Context.fromMap(Map<String, dynamic> json) => Context(
        id: json["id"],
        wikidata: json["wikidata"],
        mapboxId: json["mapbox_id"],
        text: json["text"],
        shortCode: json["short_code"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "wikidata": wikidata,
        "mapbox_id": mapboxId,
        "text": text,
        "short_code": shortCode,
    };
}

class Geometry {
    List<double> coordinates;
    String type;

    Geometry({
        required this.coordinates,
        required this.type,
    });

    factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        type: json["type"],
    );

    Map<String, dynamic> toMap() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
    };
}

class Properties {
    String? foursquare;
    bool? landmark;
    String? address;
    String? category;
    String? accuracy;

    Properties({
        this.foursquare,
        this.landmark,
        this.address,
        this.category,
        this.accuracy,
    });

    factory Properties.fromJson(String str) => Properties.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        foursquare: json["foursquare"],
        landmark: json["landmark"],
        address: json["address"],
        category: json["category"],
        accuracy: json["accuracy"],
    );

    Map<String, dynamic> toMap() => {
        "foursquare": foursquare,
        "landmark": landmark,
        "address": address,
        "category": category,
        "accuracy": accuracy,
    };
}
