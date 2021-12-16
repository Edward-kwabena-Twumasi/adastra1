import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/shop_policy_agreeement.dart';

class RegisterShopLocation extends StatefulWidget {
  const RegisterShopLocation({Key? key}) : super(key: key);

  @override
  _RegisterShopLocationState createState() => _RegisterShopLocationState();
}

class _RegisterShopLocationState extends State<RegisterShopLocation> {
  Marker _shopLocation = Marker(markerId: MarkerId('current_loc'));

  Position? currentpos = Position(
      latitude: 0,
      longitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 9,
      floor: 0);

  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController googleMapController;
  Set<Marker> _markers = HashSet<Marker>();
  int markerIDCounter = 0;
  var shops;

  @override
  Widget build(BuildContext context){

    return Scaffold(
        appBar: AppBar(
          title: Text('Register Shop Location'),
          backgroundColor: Colors.black,
        ),
        body: GoogleMap(
          initialCameraPosition: initialCameraPosition(),
          myLocationEnabled: true,
          onLongPress: (LatLng cord) {
            _selectLocation(cord, context);
          },
          markers: { 
        if(_shopLocation!=null)_shopLocation
        },
          onMapCreated: (GoogleMapController mapController) async {
            _controller.complete(mapController);
            googleMapController = mapController;
            print("Map Created Now");
            await getCurrentLocation();
            googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(currentpos!.latitude, currentpos!.longitude),
                    zoom: 16)));

            showDialog(context: context, builder: (builder){
              return AlertDialog(
                content: Text('Zoom and Long Press to Mark Shop Location'),
                actions: [TextButton(child:Text('Ok'),onPressed: (){
                  Navigator.pop(builder);
                },)],

              );
            });
          },
        ));
  }

  @override
  initState() {
    print(
        "***initState Function***");
    getCurrentLocation();
  }

  Future<void> _selectLocation(LatLng argument, BuildContext context) async {
    setState(() {
      _shopLocation =
          Marker(markerId: MarkerId('current_loc'), position: argument);
    });

    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            content: Text('Keep coordinates as Shop Location'),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(builder).pop();
                },
              ),
              TextButton(
                  onPressed: () {
                    final appProv = Provider.of<ApplicationProvider>(context,
                        listen: false);
                    appProv.shopDetails['coordinates'] = GeoPoint(argument.latitude,argument.longitude);
                    print(appProv.shopDetails);

                    Navigator.of(builder).pop();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) {
                      return PolicyAgreementScreen();
                    }));
                  },
                  child: Text('Apply'))
            ],
          );
        });
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
        "***Initial Camera Position Initialization***");
    return CameraPosition(
        target: LatLng(currentpos!.latitude, currentpos!.longitude), zoom: 16);
  }
}
