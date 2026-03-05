import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart'; // Requiere generar código o escribir el factory manualmente

@JsonSerializable()
class LatLng {
  LatLng({required this.lat, required this.lng});
  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  final double lat;
  final double lng;
}

@JsonSerializable()
class Office {
  Office({
    required this.address,
    required this.id,
    required this.image,
    required this.lat,
    required this.lng,
    required this.name,
    required this.phone,
    required this.region,
  });

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);

  final String address;
  final String id;
  final String image;
  final double lat;
  final double lng;
  final String name;
  final String phone;
  final String region;
}

@JsonSerializable()
class Locations {
  Locations({required this.offices, required this.regions});
  factory Locations.fromJson(Map<String, dynamic> json) => _$LocationsFromJson(json);
  final List<Office> offices;
  final List<Region> regions;
}

Future<Locations> getGoogleOffices() async {
  const googleLocationsURL = 'https://about.google/static/data/locations.json';
  final response = await http.get(Uri.parse(googleLocationsURL));
  if (response.statusCode == 200) {
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load locations');
  }
}