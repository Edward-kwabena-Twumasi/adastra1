//this is the the client homescreen
//the home sreen features a rounded-bottom header container
//white contains a search bar
//it gives a gist to users on which services are available to find
//listed for them at screen load are best rated shops based on customer ratings
import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/NewClient/categories_widget.dart';

//import 'package:thecut/screens/updated_screens/newbarber/barber_main_screen.dart';
import 'package:thecut/screens/newshop/shop_about_screen.dart';
import 'package:thecut/screens/search_delegate.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //declase isloading
  late bool isLoading = true;

  List<Map<String, dynamic>> shops = [];
  late StreamSubscription userSubscription;
  late StreamSubscription shopsSubscription;

  String client = "";

  void initState() {
    super.initState();
    setState(() {
      shopsSubscription =
          Provider.of<ApplicationProvider>(context, listen: false)
              .getShops()
              .listen((event) {
        setState(() {
          isLoading = true;
        });
        shops = [];
        event.docs.forEach((element) {
          setState(() {
            shops.add(element.data());
          });
        });
        setState(() {
          isLoading = false;
        });
        // Future.delayed(Duration(seconds: 2));
        // setState(() {
        //   isLoading=false;
        // });
      });
    });
    setState(() {
      userSubscription =
          Provider.of<ApplicationProvider>(context, listen: false)
              .getUser()
              .listen((event) {
        setState(() {
         
        });
      });
    });

    // startTimer();
  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
    userSubscription.cancel();
    shopsSubscription.cancel();
  }

  //A stack is used to create the aligning effect and overlaying
  @override
  Widget build(BuildContext context) {
    return Container(

        child: Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.zero,
                height: 220,
                //color: Colors.grey,
                decoration: const BoxDecoration(
                   color: Colors.white,

                )
            ),
            Positioned(
              top: 2,
              child:  Container(
height: 60,
                width: MediaQuery.of(context).size.width-2,
                child: Card(
                  elevation: 7,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),

                      IconButton(
                          onPressed: () {
                            showSearch(
                                context: context, delegate: PerformSearch(shops));
                            // Scaffold.of(context).showSnackBar(
                            //     const SnackBar(content: Text('Ghana')));
                          },
                          icon: const Icon(Icons.search, color: Colors.black))
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                top: 65,
                child:  Padding(
                  padding: const EdgeInsets.only(left: 3.0,right: 5),
                  child: Container(
                  height: 155, //color: Colors.grey,
width: MediaQuery.of(context).size.width-8,
                      decoration:  BoxDecoration(
                        borderRadius:BorderRadius.circular(5),
                          image: DecorationImage(
                              image: AssetImage('images/client_home_background.jpg'),
                              fit: BoxFit.cover,alignment:Alignment.topCenter)
                      )
                  ),
                )
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Categories',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context, builder: (builder){
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                             Expanded(
                                child: Container(
                                 // height: MediaQuery.of(context).size.height*0.8,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: GridView.count(crossAxisCount: 3,
                                  children: [
                                    Category(title: 'Shave'),
                                    Category(title: 'Dye'),
                                    Category(title: 'Trim'),
                                    Category(title: 'Beard'),
                                    Category(title: 'Retouch'),
                                    Category(title: 'Beard'),
                                    Category(title: 'Beard'),
                                    Category(title: 'Retouch'),
                                    Category(title: 'Beard'),
                                  ],
                                  ),
                                ),
                              ),
                              ElevatedButton(

                                  onPressed: (){
                                    Navigator.pop(builder);
                                  }, child: Text("Close",style:TextStyle(color:Colors.red)),
                              style: ElevatedButton.styleFrom(
                                primary:Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                              )
                            ],
                          ),
                        );
                      });
                    },
                    child: Text('See All',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w500)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 70,
              child: Wrap(
                spacing: 7,
                children: const [
                  Category(title: 'Shave'),
                  Category(title: 'Dye'),
                  Category(title: 'Trim'),
                  Category(title: 'Beard'),
                  Category(title: 'Retouch'),
                  Category(title: 'Beard'),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Suggested for you ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500)),
                TextSpan(
                    text: "(" + shops.length.toString() + ")",
                    style: TextStyle(color: Colors.blue)),
              ])),
            ),
            SizedBox(
              height: 110,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: isLoading?4:shops.length /*shops.length*/,
                  itemBuilder: (context, index) {
                    return isLoading?Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ShimmerWidget.circular(
                              width: 80,
                              height: 85,
                              shapeBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ShimmerWidget.rectangular(
                                      width: 200, height: 15),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ShimmerWidget.rectangular(
                                      width: 100, height: 12),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ShimmerWidget.rectangular(
                                      width: 70, height: 10),
                                )
                              ],
                            )
                          ],
                        )),
                      ) :
                    GestureDetector(
                        onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) {
                            return AboutShop(shopId: shops[index]["uid"]);
                          }));
                    },child:SalonCard("https://d2zdpiztbgorvt.cloudfront.net/region1/us/270012/biz_photo/7d1a76a087e84fa4b4e0ca73120aa8-Alphas-Cutz-biz-photo-e14e8d52566246d6a3a2e3ac578893-booksy.jpeg?size=640x427", shops[index]["name"],
                      ( index%5).toDouble(), shops[index]["landmark"], context, isLoading));
                  }),
              /* ),*/
            )
          ],
        ),
      ],
    ));
  }
}

//
class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 15);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 15);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//tags model class
class Categories extends StatelessWidget {
  const Categories({Key? key, required this.icon}) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.red.shade50,
        child: IconButton(
          onPressed: () {},
          icon: Icon(icon),
          color: Colors.black,
        ),
      ),
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({required this.width, required this.height})
      : this.shapeBorder = const RoundedRectangleBorder();

  //const ShimmerSalonCard({Key? key}) : super(key: key);

  const ShimmerWidget.circular(
      {required this.width,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  //const ShimmerSalonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: height,
          width: width,
          decoration:
              ShapeDecoration(color: Colors.grey[400]!, shape: shapeBorder),
        ));
  }
}

Widget SalonCard(String image, String name, double rating, String description,
        BuildContext context, bool isLoading) =>
    SizedBox(
        height: 120,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 110,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(name, style: TextStyle(fontSize: 15)),
                        subtitle: Text(description, style: TextStyle(fontSize: 12)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Wrap(children: [
                          Text(rating.toString(), textAlign: TextAlign.end),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          )
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));