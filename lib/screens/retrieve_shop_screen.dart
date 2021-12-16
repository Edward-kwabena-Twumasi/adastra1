// import 'dart:async';
// import 'dart:collection';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class RetrievePage extends StatefulWidget {
//   const RetrievePage({Key? key}) : super(key: key);
//
//   @override
//   _RetrievePageState createState() => _RetrievePageState();
// }
//
// class _RetrievePageState extends State<RetrievePage> {
//   Position? currentpos = Position(
//       latitude: 0,
//       longitude: 0,
//       timestamp: DateTime.now(),
//       accuracy: 0,
//       altitude: 0,
//       heading: 0,
//       speed: 0,
//       speedAccuracy: 9,
//       floor: 0);
//
//   late CameraPosition currentCam;
//
//   final Completer<GoogleMapController> _controller = Completer();
//   late GoogleMapController googleMapController;
//   late BitmapDescriptor mapMarker;
//   int markerSize = 0;
//
//   Set<Marker> _markers = HashSet<Marker>();
//   int markerIDCounter = 0;
//
//   void rebuildMarkers() {
//     setCustomMarker();
//     Set<Marker> tempMarkers = HashSet<Marker>();
//     _markers.forEach((element) {
//       tempMarkers.add(Marker(
//           markerId: element.markerId,
//           infoWindow: element.infoWindow,
//           icon: mapMarker,
//           position: element.position,
//           draggable: element.draggable));
//       //print(tempMarkers);
//     });
//     setState(() {
//       _markers = tempMarkers;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       initialCameraPosition: initialCameraPosition(),
//       myLocationEnabled: true,
//       onLongPress: (LatLng latLng) {
//         addPositionOnline(latLng);
//         _setMarkers(latLng);
//       },
//       onCameraIdle: () {
//
//         /*setState(() {
//           _markers = HashSet<Marker>();
//         });*/
//
//         print(
//             '#############################Camera is IDLE at ${currentCam.target.latitude},${currentCam.target.longitude}#######################################');
//
//         populateNearByShops();
//       },
//       markers: _markers,
//       onCameraMove: (CameraPosition newPosition) async {
//         /* print('*****************************Inside ON Camera Move********************************');
//           print(newPosition);
//           if(newPosition!.zoom<8.0){
//             print("Less than 5");
//             setState(() {
//               markerSize=0;
//               // rebuildMarkers();
//               //setCustomMarker();
//             });
//           }else{
//             print("More than 5");
//             setState(() {
//               markerSize=50;
//               //setCustomMarker();
//             });
//           }*/
//         //rebuildMarkers();ne
//         //
//         print(
//             '*********************Camera is Moving***********************************');
//         setState(() {
//           currentCam = newPosition;
//         });
//         /*FirebaseFirestore.instance.collection('shops')
//             .where('location',isGreaterThanOrEqualTo: GeoPoint(newPosition.target.latitude+0.9,newPosition.target.longitude+0.9))
//             .where('location',isLessThanOrEqualTo: GeoPoint(newPosition.target.latitude-0.9,newPosition.target.longitude-0.9))
//             .get()
//             .then((QuerySnapshot querySnapshot) {
//           querySnapshot.docs.forEach((doc) {
//             final geoPoint= doc["location"] as GeoPoint;
//             print('${geoPoint.latitude},${geoPoint.longitude}');
//           });
//         });*/
//       },
//       onMapCreated: (GoogleMapController mapController) async {
//         _controller.complete(mapController);
//         googleMapController = mapController;
//         print("Map Created Now");
//         await getCurrentLocation();
//         googleMapController.animateCamera(CameraUpdate.newCameraPosition(
//             CameraPosition(
//                 target: LatLng(currentpos!.latitude, currentpos!.longitude),
//                 zoom: 16)));
//       },
//     );
//   }
//
//   @override
//   initState() {
//     print(
//         "******************************initState Function******************************************");
//     setCustomMarker();
//     getCurrentLocation();
//     //populateShops();
//   }
//
//   populateNearByShops() async {
//     FirebaseFirestore.instance
//         .collection('shops')
//         .where('location',
//             isGreaterThanOrEqualTo: GeoPoint(currentCam.target.latitude - 0.9,
//                 currentCam.target.longitude - 0.9))
//         .where('location',
//             isLessThanOrEqualTo: GeoPoint(currentCam.target.latitude + 0.9,
//                 currentCam.target.longitude + 0.9))
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         final geoPoint = doc["location"] as GeoPoint;
//         _setMarkers(LatLng(geoPoint.latitude, geoPoint.longitude));
//         print('${geoPoint.latitude},${geoPoint.longitude}');
//       });
//     });
//   }
//
// /*
//   populateShops() async {
//
//     await FirebaseFirestore.instance.collection('shops').get()
//         .then((QuerySnapshot querySnapshot) {
//       var i=0;
//       querySnapshot.docs.forEach((doc) {
//
//         final geoPoint=doc["location"] as GeoPoint;
//         */ /* double lat = geoPoint.getLatitude();
//         double lng = geoPoint.getLongitude();
//         LatLng latLng = new LatLng(lat, lng);*/ /*
//         _setMarkers(LatLng(geoPoint.latitude,geoPoint.longitude));
//         print(geoPoint.latitude.toString()+ "," +geoPoint.longitude.toString());
//         //print(geoPoint.toString());
//         print('Counter ${i++}');
//       });
//     });
//   }*/
//
//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//         targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }
//
//   void setCustomMarker() async {
//     //final marker=await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/images/marker_icon.png');
//     final marker = BitmapDescriptor.fromBytes(
//         await getBytesFromAsset('assets/images/marker_icon.png', markerSize));
//     setState(() {
//       mapMarker = marker;
//     });
//   }
//
//   void printMarkers() {
//     for (var element in _markers) {
//       print(element);
//     }
//   }
//
//   void _setMarkers(LatLng point) {
//     final String markerID = 'marker_id_$markerIDCounter';
//     markerIDCounter++;
//     setState(() {
//       _markers.add(Marker(
//         infoWindow: const InfoWindow(title: "Land Mark"),
//         markerId: MarkerId(markerID),
//         icon: mapMarker,
//         position: point,
//         draggable: false,
//       ));
//     });
//   }
//
//   getCurrentLocation() async {
//     final position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best);
//     setState(() {
//       currentpos = position;
//     });
//   }
//
//   CameraPosition initialCameraPosition() {
//     print(
//         "*******************************Initial Camera Position Initialization**********************************");
//     return CameraPosition(
//         target: LatLng(currentpos!.latitude, currentpos!.longitude), zoom: 16);
//   }
//
//   addPositionOnline(LatLng latLng) {
//     FirebaseFirestore.instance
//         .collection("shops")
//         .add({'location': GeoPoint(latLng.latitude, latLng.longitude)}).then(
//             (value) {
//       print('Cordinate Inserted Successfully');
//     }).catchError((onError) {
//       print(onError.toString());
//     });
//   }
// }
