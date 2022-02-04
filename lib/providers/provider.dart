import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thecut/models/place.dart';
import 'package:thecut/models/places_search.dart';
import 'package:thecut/screens/newshop/appointment.dart';
import 'package:thecut/services/geolocator_services.dart';
import 'package:thecut/services/places_service.dart';
import 'package:geolocator/geolocator.dart';

class ApplicationProvider extends ChangeNotifier {
  String clientName = "";
  String? phoneNumber;
  //declare some value watchers to get statistical
  //numbers to be used at the shop side
  int unWatched = 0;
  int pending = 0;
  int confirmed = 0;
  int payments = 0;
  int barbers = 0;

  Position currentpos = Position(
      latitude: 0,
      longitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 9,
      floor: 0);

  Map<String, dynamic> userDetails = {};
  Map<String, dynamic> shopDetails = {};
  Map<String, dynamic> tempshopDetails = {};
  SharedPreferences? _preferences;

  void setShopDetails(Map<String, dynamic> shopJSON) {
    shopDetails = shopJSON;
    notifyListeners();
  }

  final StreamController<String?> _authController = StreamController<String?>();
  Sink<String?> get _addUser => _authController.sink;

  Stream<String?> get user => _authController.stream;

  ApplicationProvider() {
    getCurrentLocation();
    print("I SHOULD BE CALLED FIRST BEFORE PRINT FROM INITSTATE");
    loadPhoneNumberFromPrefs().then((_) {
      print("SharedPrefs Loaded Successfully");
    });
  }

  getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currentpos = position;
    notifyListeners();
  }

  void signOut() {
    phoneNumber = null;
    //setPhoneNumber(null);
    _preferences?.remove('phone_number');
    notifyListeners();
  }

  void setName(String name) {
    clientName = name;
    notifyListeners();
  }

  _initializePrefs() async {
    _preferences ??= await SharedPreferences.getInstance();
    notifyListeners();
  }

  Future<String?> loadPhoneNumberFromPrefs() async {
    await loadPhonePrefs();
    return phoneNumber;
  }

  Future<void> loadPhonePrefs() async {
    await _initializePrefs();
    String tempPhone = _preferences?.getString('phone_number') ?? 'NULL';
    phoneNumber = tempPhone != 'NULL' ? tempPhone : null;
    print("LOADING PREFS");
    print("Current PhoneNumber");
    print(phoneNumber);
    notifyListeners();
  }

  changePhoneNumber(String phone) {
    phoneNumber = phone;
    notifyListeners();
  }

  setDefaultNumber() {
    phoneNumber = "0271302702";
    notifyListeners();
  }

  setPhoneNumber(String? phone) async {
    if (phone != null) {
      phoneNumber = phone;
      final updatedPref = await _preferences?.setString('phone_number', phone);
      if (updatedPref!) {
        print("PREF UPDATE STATUS");
        print(updatedPref);
        loadPhoneNumberFromPrefs();
      }
      print('Phone Changed Successfully');
    }
    notifyListeners();
  }

  setShopTags(List<String> shopJSON) {
    tempshopDetails['tags'] = shopJSON;
    notifyListeners();
  }

  Stream<String?> getPhoneFuture() {
    print("They are calling me ooo====>>>> GET PHONE FUTURE");
    // print(phoneNumber);
    _addUser.add(phoneNumber);
    return user;
  }

  /*setShopId(String phone) {
    shopId = phone;
    notifyListeners();
  }*/

//Lets get shop document with phone this time with a query snapshot
  Stream<DocumentSnapshot<Map<String, dynamic>>> getShopForUser(String shopID) {
    return FirebaseFirestore.instance
        .collection("shops")
        .doc(shopID)
        .snapshots();
  }

  //get all shops
  Stream<QuerySnapshot<Map<String, dynamic>>> getShops() {
    return FirebaseFirestore.instance.collection("shops").snapshots();
  }

//Get pending requests to shop
  Stream<QuerySnapshot<Map<String, dynamic>>> pendingRequests() {
    return FirebaseFirestore.instance
        .collection("appointments")
        .where("shop_id", isEqualTo: phoneNumber)
        .where("date", isGreaterThanOrEqualTo: DateTime.now())
        .where("service_status", isEqualTo: "PENDING")
        .snapshots()
        .asBroadcastStream();
  }

//get all appointments of a client
  Stream<QuerySnapshot<Map<String, dynamic>>> clientAppointments() {
    return FirebaseFirestore.instance
        .collection("appointments")
        .where("client_id", isEqualTo: phoneNumber)
        .orderBy('date', descending: true)
        .snapshots();
  }

//get details about of a barber
  Stream<DocumentSnapshot<Map<String, dynamic>>> getBarber() {
    return FirebaseFirestore.instance
        .collection("barbers")
        .doc(phoneNumber)
        .snapshots();
  }

//get barbers of shop
  Stream<QuerySnapshot<Map<String, dynamic>>> getBarbers() {
    return FirebaseFirestore.instance
        .collection("barbers")
        .where("shop_affiliation", isEqualTo: phoneNumber)
        .snapshots()
        .asBroadcastStream();
  }

//Get information about a shop
  Stream<DocumentSnapshot<Map<String, dynamic>>> getShop() {
    return FirebaseFirestore.instance
        .collection("shops")
        .doc(phoneNumber)
        .snapshots();
  }

  //Get information about a client
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser() {
    return FirebaseFirestore.instance
        .collection("clients")
        .doc(phoneNumber)
        .snapshots();
  }

  //Streams to emit these values are creted below
  Stream<QuerySnapshot<Map<String, dynamic>>> unwatchedRequests() {
    return FirebaseFirestore.instance
        .collection("appointments")
        .where("date", isGreaterThanOrEqualTo: DateTime.now())
        .where("service_status", isEqualTo: "PENDING")
        .where("shop_watched", isEqualTo: false)
        .snapshots();
  }
  //List appointemnts assigned to this barber
  Stream<QuerySnapshot<Map<String, dynamic>>> appointmentsForBarber() {
    return FirebaseFirestore.instance
        .collection("appointments")
        .where("date", isGreaterThanOrEqualTo: DateTime.now())
        .where("service_status", isEqualTo: "CONFIRMED")
        .where("barber_id", isEqualTo: phoneNumber)
        .snapshots();
  }
//

//Watch stream of all payments made to shop
  Stream<QuerySnapshot<Map<String, dynamic>>> paymentsToShop() {
    return FirebaseFirestore.instance
        .collection("payments")
        .where("date", isGreaterThanOrEqualTo: DateTime.now())
        .where("shop_id", isEqualTo: phoneNumber)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> confirmedAppointments(DateTime tomorrow) {
   return FirebaseFirestore.instance
        .collection("appointments")
        .where("service_status", isEqualTo: "CONFIRMED")
        .where("shop_id", isEqualTo: phoneNumber!)
        .where("date", isGreaterThanOrEqualTo: DateTime.now())
        .where("date", isLessThan: tomorrow)
        .snapshots();
  }

  paymentsCount(int count) {
    payments = count;
    notifyListeners();
  }

  pendingCount(int count) {
    pending = count;
    notifyListeners();
  }

  unWatchedCount(int count) {
    unWatched = count;
    print( "umwatced is now "+unWatched.toString());
    notifyListeners();
  }

  barberCount(int count) {
    barbers = count;
    notifyListeners();
  }

  confirmedCount(int count) {
    confirmed = count;
    notifyListeners();
  }

  setUserDetails(Map<String, dynamic> data) {
    userDetails = data;
    notifyListeners();
  }

  setTempShopDetails(Map<String, dynamic> data) {
    tempshopDetails = data;
    notifyListeners();
  }

  //value watchers

}