import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thecut/models/place.dart';
import 'package:thecut/models/places_search.dart';
import 'package:thecut/services/geolocator_services.dart';
import 'package:thecut/services/places_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationProvider extends ChangeNotifier {
  String clientName = "";
  String? phoneNumber;
  String shopId = "0245382714";
  Map<String, dynamic> shopDetails = {};
  SharedPreferences? _preferences;
  bool isLoading = false;

  final StreamController<String?> _authController = StreamController<String?>();
  Sink<String?> get _addUser => _authController.sink;

  Stream<String?> get user => _authController.stream;

  ApplicationProvider() {
    loadPhoneNumberFromPrefs().then((_) {
      print("SharedPrefs Loaded Successfully");
    });
  }

  void signOut() {
    phoneNumber = null;
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
    //id to fettch shop details and display to user
    String shopId = '';
    //set is loading bool value for the shimmmer loading
    bool isLoading = true;
    String tempPhone = _preferences?.getString('phone_number') ?? 'NULL';
    phoneNumber = tempPhone != 'NULL' ? tempPhone : null;
    print("LOADING PREFS");
    print("Current PhoneNumber");
    print(phoneNumber);
    notifyListeners();
  }

//set shopid
  setShopId(String phone) {
    shopId = phone;
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

  setPhoneNumber(String phone) async {
    if (phone != '') {
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

  setShopDetails(Map<String, dynamic> shopJSON) {
    shopDetails = shopJSON;
    notifyListeners();
  }

  Stream<String?> getPhoneFuture() {
    print("They are calling me ooo====>>>> GET PHONE FUTURE");
    // print(phoneNumber);
    _addUser.add(phoneNumber);
    return user;
  }

//Lets get user document with phone
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
    return await FirebaseFirestore.instance
        .collection("clients")
        .doc(phoneNumber)
        .get();
  }

//Lets get shop document with phone this time with a query snapshot
  Future<DocumentSnapshot<Map<String, dynamic>>> getShop() async {
    return await FirebaseFirestore.instance
        .collection("shops")
        .doc(phoneNumber)
        .get();
  }

  //Lets get shop document with phone this time with a query snapshot
  // Future<DocumentSnapshot<Map<String, dynamic>>> getBarber() async {
  //   return await FirebaseFirestore.instance
  //       .collection("barbers")
  //       .doc(phoneNumber).get()
  //       ;
  // }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getBarber()  {
    return  FirebaseFirestore.instance
        .collection("barbers")
        .doc(phoneNumber).snapshots()
        ;
  }
  //get all shops
  Stream<QuerySnapshot<Map<String, dynamic>>> getShops()  {
    return  FirebaseFirestore.instance
        .collection("barbers")
        .snapshots()
        ;
  }

//Lets get shop document with phone this time with a query snapshot
  Future<DocumentSnapshot<Map<String, dynamic>>> getShopForUser() async {
    return await FirebaseFirestore.instance
        .collection("shops")
        .doc(shopId)
        .get();
  }
}

/*




final GeolocatorService geoLocatorService=GeolocatorService();
final placesService = PlacesService();



//Variables
Position? currentLocation;
List<PlaceSearch> searchResults=[];
StreamController<Place> selectedLocation=StreamController<Place>();
Map<String,dynamic> shopDetails={};
SharedPreferences? _preferences;

String? phoneNumber;

/////////Edward Variables
double lat = 0.0;
double lng = 0.0;
late GoogleMapController mapController;

ApplicationProvider() {
  setCurrentLocation();
  _loadPhoneNumberFromPrefs();
}

_initializePrefs()async{
  if(_preferences==null){
    _preferences=await SharedPreferences.getInstance();
  }
}

*/
/* _loadPhoneNumberFromPrefs()async{
    await _initializePrefs();
    phoneNumber=_preferences?.getString('phone_number')??'NULL';
    notifyListeners();
  }*/ /*



void initMapController(GoogleMapController controller) {
  mapController = controller;
  notifyListeners();
}

void setLatLng(double latit, double long) {
  lat = latit;
  lng = long;
  notifyListeners();
}
*/
/*savePhoneNumber(String phone) async{
    await _initializePrefs();
    _preferences?.setString('phone_number', phone);

    print('Phone Number Updated ===$phone');

    notifyListeners();
  }*/ /*


savePhoneNumber(String phone){
  if(phone!=''){
    phoneNumber=phone;
    _preferences?.setString('phone_number', phone);
    print('Phone Changed Successfully');
  }
  notifyListeners();
}

_loadPhoneNumberFromPrefs()async{
  await _initializePrefs();
  String tempPhone=_preferences?.getString('phone_number')??'NULL';
  phoneNumber=tempPhone!='NULL'?tempPhone:null;
  notifyListeners();
}

setCurrentLocation() async {
  currentLocation = await geoLocatorService.getCurrentLocation();
  notifyListeners();
}

searchPlaces(String searchTerm) async {
  searchResults = await placesService.getAutocomplete(searchTerm);
  notifyListeners();
}

setSelectedLocation(String placeId)async{
  selectedLocation.add(await placesService.getPlace(placeId));
  //print(selectedLocation);
  searchResults=[];
  notifyListeners();
}

setShopDetails(Map<String,dynamic> shopJSON){
  shopDetails=shopJSON;
  notifyListeners();
}*/


