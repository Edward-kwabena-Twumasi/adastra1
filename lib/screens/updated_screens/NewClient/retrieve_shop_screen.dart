import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thecut/screens/updated_screens/newshop/shop_about_screen.dart';
import 'package:thecut/screens/updated_screens/NewClient/directions_model.dart';
import 'package:thecut/screens/updated_screens/NewClient/directions_repository.dart';
import 'package:thecut/screens/updated_screens/NewClient/shop_detail.dart';


class RetrievePage extends StatefulWidget {
  const RetrievePage({Key? key}) : super(key: key);

  @override
  _RetrievePageState createState() => _RetrievePageState();
}

class _RetrievePageState extends State<RetrievePage> {
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

  LatLng? destination;
  CameraPosition currentCam = CameraPosition(target: LatLng(0, 0), zoom: 13);

  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController googleMapController;
  late BitmapDescriptor mapMarker;
  int markerSize = 0;
  Directions? _info;

  Set<Marker> _markers = HashSet<Marker>();
  List<Shop> listOfShops = [];
  int markerIDCounter = 0;

  void rebuildMarkers() {
    print(_markers.length.toString()+"markers rebuilt");
    setCustomMarker();
    Set<Marker> tempMarkers = HashSet<Marker>();
    _markers.forEach((element) {
      tempMarkers.add(Marker(
          markerId: element.markerId,
          infoWindow: element.infoWindow,
          icon: mapMarker,
          position: element.position,
          draggable: element.draggable));
      //print(tempMarkers);
    });
    setState(() {
      _markers = tempMarkers;
    });
  }
  @override
  initState() {
    super.initState();
    print(
        "******************************initState Function******************************************");
    setCustomMarker();
    getCurrentLocation();
    //populateNearByShops();

  }

  @override
  Widget build(BuildContext context) {
    return Stack( alignment: Alignment.bottomCenter,children: [
      GoogleMap(
        initialCameraPosition: initialCameraPosition(),
        myLocationEnabled: true,
        onCameraIdle: () {
          print(
              '#############################Camera is IDLE at ${currentCam.target.latitude},${currentCam.target.longitude}#######################################');
          populateNearByShops();
        },
        markers: _markers,
        onCameraMove: (CameraPosition newPosition) async {
          print(
              '*********************Camera is Moving***********************************');
          setState(() {
            currentCam = newPosition;
          });
          //rebuildMarkers();
        },
        polylines: {
          if (_info != null)
            Polyline(
              polylineId: const PolylineId('overview_polyline'),
              color: Colors.red,
              width: 5,
              points: _info!.polylinePoints
                  .map((e) => LatLng(e.latitude, e.longitude))
                  .toList(),
            ),
        },
        onMapCreated: (GoogleMapController mapController) async {
          print("map created  000");
          print(_markers.length.toString());
          rebuildMarkers();
          _controller.complete(mapController);
          googleMapController = mapController;
          print("Map Created Now");
          await getCurrentLocation();
          googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(currentpos.latitude, currentpos.longitude),
                  zoom: 16)));
        },
      ),
      if (_info != null)
        Positioned(
          top: 20.0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 6.0,
              horizontal: 12.0,
            ),
            decoration: BoxDecoration(
              color: Colors.yellowAccent,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                )
              ],
            ),
            child: Text(
              '${_info!.totalDistance}, ${_info!.totalDuration}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      Positioned(
        child: Container(
          height: 185.0,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listOfShops.length,
                itemBuilder: (BuildContext context, int index) {
                  // print(listOfShops[index].phone);
                  final currentShop = listOfShops[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
    onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (contex) {
    return const AboutShop();
    }));},
                      child: Card(
                        //color: Colors.transparent,
                        child: Container(
                          width: 210.0,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                          image: NetworkImage(
                                              "https://d2zdpiztbgorvt.cloudfront.net/region1/us/270012/biz_photo/7d1a76a087e84fa4b4e0ca73120aa8-Alphas-Cutz-biz-photo-e14e8d52566246d6a3a2e3ac578893-booksy.jpeg?size=640x427"),
                                          fit: BoxFit.cover)),
                                  width: 210.0,
                                  height: 110.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                          /* mainAxisSize: MainAxisSize.max,*/
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              currentShop.name,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: const [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.orange,
                                                  size: 16,
                                                ),
                                                Text('4.0')
                                              ],
                                            ),
                                          ]),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            size: 15,
                                          ),
                                          Text(
                                            currentShop.phone,
                                            style: TextStyle(fontSize: 11),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  );
                },
              )),
        ),
      ),
    ]);
  }



  populateNearByShops() async {

    listOfShops = [];
    FirebaseFirestore.instance
        .collection('shops')
        .where('location',
            isGreaterThanOrEqualTo: GeoPoint(
                currentCam.target.latitude - 0.0150,
                currentCam.target.longitude - 0.0150))
        .where('location',
            isLessThanOrEqualTo: GeoPoint(currentCam.target.latitude + 0.0150,
                currentCam.target.longitude + 0.0150))
        .get ()
        .then((QuerySnapshot querySnapshot) {

      querySnapshot.docs.forEach((doc) {

        final geoPoint = doc["location"] as GeoPoint;
        //_setMarkers(LatLng(geoPoint.latitude, geoPoint.longitude));

        setState(() {
          listOfShops.add(
              Shop(doc['location'] as GeoPoint, doc['name'], doc['phone']));
        });
        _setMarkerWithDetails(
            LatLng(geoPoint.latitude, geoPoint.longitude), doc);
        print("---setting marker with details---");
        print('${geoPoint.latitude},${geoPoint.longitude}');
      });
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void setCustomMarker() async {
    //final marker=await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/images/marker_icon.png');
    final marker = BitmapDescriptor.fromBytes(
        await getBytesFromAsset('assets/images/marker_icon.png', 50));
    setState(() {
      mapMarker = marker;
    });
  }

  void printMarkers() {
    for (var element in _markers) {
      print(element);
    }
  }

 /* void _setMarkers(LatLng point) {
    final String markerID = 'marker_id_$markerIDCounter';
    markerIDCounter++;
    setState(() {
      _markers.add(Marker(
        infoWindow: InfoWindow(
            title: "Land Mark",
            onTap: () {
              print(markerID);
            }),
        markerId: MarkerId(markerID),
        icon: mapMarker,
        position: point,
        draggable: false,
      ));
    });
  }*/

  void _setMarkerWithDetails(LatLng point, QueryDocumentSnapshot<Object?> doc) {
    final String markerID = doc.id;
    //markerIDCounter++;
    setState(() {
      _markers.add(Marker(
        infoWindow: InfoWindow(
            title: doc['name'] ?? "Unnamed Dealer",
            snippet: doc['phone'],
            onTap: () async {
              print(markerID);
            }),
        markerId: MarkerId(markerID),
        icon: mapMarker,
        onTap: () async {

          setState(() {
            destination = point;
          });
          final origin = LatLng(currentpos.latitude, currentpos.longitude);
          final directions = await DirectionsRepository()
              .getDirections(origin: origin, destination: destination!);
          setState(() => _info = directions);

        },
        position: point,
        draggable: false,
      ));
      print(_markers.length.toString());
    });
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      currentpos = position;
    });
  }

  CameraPosition initialCameraPosition() {
    print(
        "*******************************Initial Camera Position Initialization**********************************");
    return CameraPosition(
        target: LatLng(currentpos.latitude, currentpos.longitude), zoom: 16);
  }

  addPositionOnline(LatLng latLng) {
    print('Inside Add Position Online');
    FirebaseFirestore.instance
        .collection("shops")
        .add({'location': GeoPoint(latLng.latitude, latLng.longitude)}).then(
            (value) {
      print('Coordinate Inserted Successfully');
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}
