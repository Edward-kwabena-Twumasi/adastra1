// //nearby screen presents a map to to the user pointing them to their current location and
// //helping them find and get shops and services nearby their location
// //This part implements an advanced search to make finding services easy
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:provider/provider.dart';
// import 'package:thecut/providers/Logics.dart';
//
//
//
// class NearBy extends StatefulWidget {
//   const NearBy({Key? key}) : super(key: key);
//
//   @override
//   NearByState createState() => NearByState();
// }
//
// class NearByState extends State<NearBy> {
//   bool displaymap = false;
//   bool changeloadcolor = false;
//   double lat = 0.0, long = 0.0;
//   Future<Position> getLatLng() async {
//     return await GeolocatorPlatform.instance
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//   }
//   List<Salons> salons = [
//     Salons("images/salon.jpg", "Afias Salon", 4.3,
//         "Unisex salon located at Adenta"),
//         Salons("images/salon.jpg", "American barbers", 4.2,
//         "Unisex Barbering shop located at Tech")
//   ];
//
//   late GoogleMapController mapController;
//
//   //final LatLng _center = const LatLng(45.521563, -122.677433);
//
//   void _onMapCreated(GoogleMapController controller) {
//     Provider.of<UserProvider>(context).setLatLng(lat, long);
//     Provider.of<UserProvider>(context).initMapController(controller);
//   }
//
//   late Future<PlacePredictions> predictios;
//   String shoplocation = "";
//   bool showPredictions = false;
//   String input = "";
//
//   @override
//   void initState() {
//     super.initState();
//     getLatLng().then((value) async {
//       setState(() {
//         lat = value.latitude;
//         long = value.longitude;
//         changeloadcolor = true;
//         displaymap = true;
//       });
//       Provider.of<UserProvider>(context, listen: false).setLatLng(lat, long);
//
//       //print(Provider.of<UserProvider>(context,listen: false).lat);
//       // await GeocodingPlatform.instance
//       //     .placemarkFromCoordinates(value.latitude, value.longitude)
//       //     .then((value) {
//       //   setState(() {
//       //     shoplocation = value.first.administrativeArea! +
//       //         " ," +
//       //         value.first.locality! +
//       //         " ," +
//       //         value.first.name!;
//       //   });
//       // });
//     }).catchError((onError) {
//       print(onError.toString());
//     });
//
//
//   }
//
//   List<Suggestions> suggestions = [];
//   TextEditingController location = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//               children: [
//                  Container(
//                  // width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height * 0.2,
//                   decoration:
//                       const BoxDecoration(color: Colors.white),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                          Text("Current Location ",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 22)),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         SizedBox(
//                             height: 30,
//                             width: MediaQuery.of(context).size.width - 20,
//                             child: TextField(
//                                 decoration: InputDecoration(
//
//                                     hintText: "Search shop or category",
//                                     fillColor: Colors.grey[400],
//                                     filled: true,
//
//                                     ))),
//
//                       ],
//                     ),
//                   ),
//                 ),
//                displaymap
//             ? Container(
//                height: MediaQuery.of(context).size.height*0.8,
//               child: Stack(
//                     children: [
//                       Consumer<UserProvider>(
//                         builder: (BuildContext contxt, value, __) => GoogleMap(
//                           myLocationButtonEnabled: true,
//                           onMapCreated: (GoogleMapController controller) {
//                             value.initMapController(controller);
//                           },
//                           initialCameraPosition: CameraPosition(
//                               target: LatLng(value.lat, value.lng), zoom: 15),
//                           myLocationEnabled: true,
//                           onTap: (LatLng cords) async {
//                             await GeocodingPlatform.instance
//                                 .placemarkFromCoordinates(
//                                     cords.latitude, cords.longitude)
//                                 .then((val) {
//                               setState(() {
//                                 shoplocation = val.first.administrativeArea! +
//                                     " ," +
//                                     val.first.locality! +
//                                     " ," +
//                                     val.first.name!;
//                               });
//                               value.mapController
//                                   .animateCamera(CameraUpdate.newCameraPosition(
//                                 CameraPosition(
//                                     target: LatLng(value.lat , value.lng),
//                                     zoom: 15),
//                               ));
//                             });
//                             print(cords);
//                           },
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SizedBox(
//                            height:180,
//                             child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: salons.length,
//                                 itemBuilder: (buildContext, index) {
//                                   return SalonCards(
//                                       salons[index].image,
//                                       salons[index].name,
//                                       salons[index].rating,
//                                       salons[index].description);
//                                 }),
//                           ),
//                         ),
//                       )
//
//                     ],
//                   ),
//             ) : Center(
//                 child: CircularProgressIndicator(
//                   color: changeloadcolor ? Colors.green : Colors.red,
//                 ),
//               ),
//               ],
//             )
//            ;
//   }
// }
//
// //get predictions
// Future<PlacePredictions> predictions(String input, String key) async {
//   final response = await http.get(
//     Uri.parse(
//         "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$key&componets=country:gh"),
//   );
//
// // If the server did return a 200 ok response,
// // then parse the JSON.
//   return PlacePredictions.fromJson(jsonDecode(response.body));
// }
//
// //place predictions class
// class PlacePredictions {
//   List<dynamic> predictions;
//   String status;
//   PlacePredictions({required this.predictions, required this.status});
//   factory PlacePredictions.fromJson(Map<String, dynamic> json) {
//     return PlacePredictions(
//         predictions: json["predictions"], status: json["status"]);
//   }
// }
//
// class Suggestions {
//   String name;
//   String placeid;
//   Suggestions(this.name, this.placeid);
// }
//
// class CustomSearchHintDelegate extends SearchDelegate<String> {
//   CustomSearchHintDelegate({
//     required String hintText,
//   }) : super(
//           searchFieldLabel: hintText,
//           keyboardType: TextInputType.text,
//           textInputAction: TextInputAction.search,
//         );
//
//   @override
//   Widget buildLeading(BuildContext context) => IconButton(
//       onPressed: () {
//         Navigator.pop(context);
//       },
//       icon: Icon(Icons.arrow_back));
//
//   @override
//   PreferredSizeWidget buildBottom(BuildContext context) {
//     return PreferredSize(
//         preferredSize: Size.fromHeight(56.0),
//         child: Text(""));
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return FutureBuilder<PlacePredictions>(
//         future: predictions(query, "AIzaSyByEcS2mSAj85IEkjOLEBIa0083LKlrHWc"),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text(snapshot.error.toString());
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return Opacity(opacity: 0.0);
//           }
//
//           return ListView.separated(
//               separatorBuilder: (_, i) => Divider(
//                     color: Colors.lightBlue,
//                   ),
//               shrinkWrap: true,
//               itemCount: snapshot.data!.predictions.length,
//               itemBuilder: (context, j) {
//                 return ListTile(
//                   leading: Icon(Icons.location_on),
//                   onTap: () async {
//                     await GeocodingPlatform.instance
//                         .locationFromAddress(
//                             snapshot.data!.predictions[j]["description"])
//                         .then((value) {
//                       Navigator.pop(context);
//                       query = '';
//                       Provider.of<UserProvider>(context,listen: false).mapController
//                    .animateCamera(
//                           CameraUpdate.newCameraPosition(
//                               CameraPosition(
//                                   target: LatLng(
//                                       value.first.latitude,
//                                       value.first.longitude),
//                                   zoom: 16)));
//                     });
//                   },
//                   title: Text(
//                     snapshot.data!.predictions[j]["description"],
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 );
//               });
//         });
//   }
//
//   @override
//   Widget buildResults(BuildContext context) => const Text('bader shops');
//
//   @override
//   List<Widget> buildActions(BuildContext context) => <Widget>[];
// }
//
//
// //salons model class
// class Salons {
//   String image;
//   String name;
//   double rating;
//   String description;
//
//   Salons(this.image, this.name, this.rating, this.description);
// }
//
// Widget SalonCards(
//     String image, String name, double rating, String description) {
//   return Container(
//     width: 250,
//     height:170,
//     child: Card(
//       elevation:5,
//       shape:RoundedRectangleBorder(
// borderRadius:BorderRadius.circular(10)
//       ),
//         child: Column(
//       children: [
//
//         Container(
// height: 100,
//  decoration:BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage(
//                            image,
//                           ),
//                           fit: BoxFit.cover))
//
//
//        ),
//         ListTile(
//             title: Row(
//               children: [
//                 Text(name),
// Spacer(),
//                 Text(rating.toString(),textAlign:TextAlign.end),
//                 Icon(Icons.star,color: Colors.amber,)
//               ],
//             ),
//             subtitle: Text(description),
//           ),
//
//       ],
//     )),
//   );
// }
//
