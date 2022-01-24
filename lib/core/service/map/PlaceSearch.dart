// To parse this JSON data, do
//
//     final placeSearch = placeSearchFromJson(jsonString);

import 'dart:convert';

class PlaceSearch {
  final List<Result> results;
  final String status;

  PlaceSearch({
    this.results,
    this.status,
  });

  factory PlaceSearch.fromJson(String str) =>
      PlaceSearch.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlaceSearch.fromMap(Map<String, dynamic> json) => PlaceSearch(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
        "status": status,
      };
}

class Result {
  final List<AddressComponent> addressComponents;
  final String formattedAddress;
  final Geometry geometry;
  final String placeId;
  final List<String> types;

  Result({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.placeId,
    this.types,
  });

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        addressComponents: List<AddressComponent>.from(
            json["address_components"].map((x) => AddressComponent.fromMap(x))),
        formattedAddress: json["formatted_address"],
        geometry: Geometry.fromMap(json["geometry"]),
        placeId: json["place_id"],
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "address_components":
            List<dynamic>.from(addressComponents.map((x) => x.toMap())),
        "formatted_address": formattedAddress,
        "geometry": geometry.toMap(),
        "place_id": placeId,
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}

class AddressComponent {
  final String longName;
  final String shortName;
  final List<String> types;

  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  factory AddressComponent.fromJson(String str) =>
      AddressComponent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddressComponent.fromMap(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "long_name": longName,
        "short_name": shortName,
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}

class Geometry {
  final Location location;
  final String locationType;
  final Viewport viewport;

  Geometry({
    this.location,
    this.locationType,
    this.viewport,
  });

  factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        location: Location.fromMap(json["location"]),
        locationType: json["location_type"],
        viewport: Viewport.fromMap(json["viewport"]),
      );

  Map<String, dynamic> toMap() => {
        "location": location.toMap(),
        "location_type": locationType,
        "viewport": viewport.toMap(),
      };
}

class Location {
  final double lat;
  final double lng;

  Location({
    this.lat,
    this.lng,
  });

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  final Location northeast;
  final Location southwest;

  Viewport({
    this.northeast,
    this.southwest,
  });

  factory Viewport.fromJson(String str) => Viewport.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Viewport.fromMap(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromMap(json["northeast"]),
        southwest: Location.fromMap(json["southwest"]),
      );

  Map<String, dynamic> toMap() => {
        "northeast": northeast.toMap(),
        "southwest": southwest.toMap(),
      };
}
