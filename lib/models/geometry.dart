import 'package:thecut/models/location.dart';


class Geometry{
  final Location location;

  Map<String, dynamic> toMap() {
    return {
      'location': this.location,
    };
  }

  Geometry({required this.location});

  factory Geometry.fromJson(Map<String, dynamic> map) {

    print('From Geometry:' + map.toString());
    return Geometry(
      location: Location.fromJson(map['location']),
    );
  }
}