class Location{
  final double lat;
  final double lng;

  Location({required this.lat, required this.lng});

  Map<String, dynamic> toMap() {
    return {
      'lat': this.lat,
      'lng': this.lng,
    };
  }

  factory Location.fromJson(Map<String, dynamic> map) {
    print('From Location:' + map.toString());

    return Location(lat: map['lat'],
      lng: map['lng'],
    );
  }
}