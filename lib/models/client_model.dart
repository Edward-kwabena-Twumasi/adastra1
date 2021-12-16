/*
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  String _uid = '';
  String _name = '';
  String _email = '';
  String _sex = '';
  String _imageUrl = '';
  String _phone = '';

  Client(
      {required String uid,
      required String name,
      String email = '',
      required String sex,
      String imageUrl = '',
      required String phone})
      : this._uid = uid,
        this._name = name,
        this._email = email,
        this._sex = sex,
        this._imageUrl = imageUrl,
        this._phone = phone;

  Client.fromJson(Map<String, dynamic> userJson) {
    this._uid = userJson['uid'];
    this._name = userJson['name'];
    this._email = userJson['email'];
    this._sex = userJson['sex'];
    this._imageUrl = userJson['image_url'];
    this._phone = userJson['phone'];
  }

  String? get uid => this._uid;

  String? get phone => this.phone;

  String? get name => this.name;

  String? get email => this.email;

  String? get sex => this.sex;

  String? get imageUrl => this.imageUrl;

  set setUid(String uid) {
    this._uid = uid;
  }

  set setPhone(String phone) {
    this._phone = phone;
  }

  set setName(String name) {
    this._name = name;
  }

  set setEmail(String email) {
    this._email = email;
  }

  set setSex(String sex) {
    this._sex = sex;
  }

  set setImageUrl(String imageUrl) {
    this._imageUrl = imageUrl;
  }

  bool save() {
    CollectionReference users = FirebaseFirestore.instance.collection('client');

    users
        .add({
          'name': this.name,
          'phone': this.phone,
          'email': this.email,
          'sex': this.sex,
          'imageUrl': this.imageUrl,
          'uid': this.uid
        })
        .then((value){
          print("User Added");
          return true;
        })
        .catchError((error){ print("Failed to add user: $error");
            return false;
        });

    return true;
  }
}
*/
