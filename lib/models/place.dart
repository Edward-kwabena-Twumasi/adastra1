import 'package:thecut/models/geometry.dart';

class Place{
  final Geometry geometry;
  final String name;
  final String vicinity;

  Place({required this.geometry, required this.name, required this.vicinity});

  Map<String, dynamic> toMap() {
    return {
      'geometry': this.geometry,
      'name': this.name,
      'vicinity': this.vicinity,
    };
  }

  factory Place.fromJson(Map<String, dynamic> map) {

    print('From Places:' + map.toString());

    return Place(
      geometry: Geometry.fromJson(map['geometry']),
      name: map['name'] as String,
      vicinity: map['vicinity'] as String,
    );
  }
}