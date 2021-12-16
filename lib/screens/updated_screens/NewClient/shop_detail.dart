import 'package:cloud_firestore/cloud_firestore.dart';

class Shop{
  GeoPoint _location;
  String _name;
  String _phone;

  Shop(this._location, this._name, this._phone);

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  GeoPoint get location => _location;

  set location(GeoPoint value) {
    _location = value;
  }
}