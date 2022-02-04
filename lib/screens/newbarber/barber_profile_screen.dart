import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';

import '../../../sign_in_option_screen.dart';

class BarberAboutScreen extends StatefulWidget {
  const BarberAboutScreen({Key? key}) : super(key: key);

  @override
  _BarberAboutScreenState createState() => _BarberAboutScreenState();
}

class _BarberAboutScreenState extends State<BarberAboutScreen> {
  Map<String, dynamic> barber = {};
  late StreamSubscription barberSubscription;
  @override
  void initState() {
    super.initState();

    barberSubscription =
        Provider.of<ApplicationProvider>(context, listen: false)
            .getBarber()
            .listen((event) {
      setState(() {
        barber = event.data()!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    barberSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.8),
          elevation:0.0,
        leading: IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                         
                        )),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(children: [
                              Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            border: Border.all(
                                color: Colors.amber.withOpacity(0.8), width: 3),
                            )
                                ),
                   
                                  Positioned(
                      right: 0.2,
                      bottom: 5,
                                   child: Container(
                                                         height: 130,
                                                         width: 130,
                                                         decoration: BoxDecoration(
                                                             shape: BoxShape.circle,
                                                             color: Colors.transparent,
                                                             border: Border.all(
                                                                 color: Colors.pink.withOpacity(0.8), width: 5),
                                                             )
                                                                 ),
                                 ),
                                  Positioned(
                      left: 4,
                      top: 0,
                      child: Container(
                          height: 139,
                          width: 130,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // border: Border.all(
                              //     color: Colors.white.withOpacity(0.8), width: 4),
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/nicesalon.jpg",
                                  ),
                                  fit: BoxFit.cover))
                                  ),
                    ),
                    // Positioned(
                    //     top: 70,
                    //     left: 70,
                    //     child: Container(
                    //       height: 40,
                    //       width: 40,
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         shape: BoxShape.circle,
                    //         //  border: Border.all(
                    //         //    color: Colors.white,
                    //         //    width: 3
                    //         //  ),
                    //       ),
                    //       child: Icon(Icons.camera, color: Colors.white),
                    //     ))
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(barber["name"] ?? "...",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "5 ",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 18,
                                )),
                            //TextSpan(text: "Likes ",style: TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 14)),
                            WidgetSpan(
                                child: Icon(FontAwesomeIcons.heart,
                                    color: Colors.white))
                          ])),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "2 ",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 18,
                                )),
                            // TextSpan(text: "Followers ",style: TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 14)),
                            WidgetSpan(
                                child: Icon(FontAwesomeIcons.peopleCarry,
                                    color: Colors.white))
                          ])),
                          RichText(
                              text: TextSpan(children: [
                            //TextSpan(text: "",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight:FontWeight.bold)),

                            TextSpan(
                                text: "20 ",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 18)),
                            WidgetSpan(
                                child: Icon(FontAwesomeIcons.doorOpen,
                                    color: Colors.white))
                            //  WidgetSpan(child: IconButton( onPressed: () {
                            //                 Provider.of<ApplicationProvider>(context,
                            //                         listen: false)
                            //                     .signOut();
                            //                 Navigator.pushAndRemoveUntil(context,
                            //                     MaterialPageRoute(builder: (builder) {
                            //                   return SignInOptionScreen();
                            //                 }), (route) => false);
                            //               },
                            //               icon: Icon(FontAwesomeIcons.signOutAlt,color:Colors.white)
                            //               )

                            //  )
                          ])),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )),
                  child: BarberHome()))
        ],
      ),
    );
  }
}

//shop info tabs
class BarberHome extends StatefulWidget {
  const BarberHome({Key? key}) : super(key: key);

  @override
  _BarberHomeState createState() => _BarberHomeState();
}

class _BarberHomeState extends State<BarberHome> with TickerProviderStateMixin {
  // int initial = 0;
  // TabController tabController =
  //     TabController(
  //       initialIndex: 0,
  //       length: 4, vsync: );

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            titleSpacing: 0,
            backgroundColor: Colors.white,
            elevation: 6,
            bottom: TabBar(
              indicatorColor: Colors.green,
              labelStyle: TextStyle(color: Colors.green),
              unselectedLabelColor: Colors.black,
              labelColor: Colors.green,
              tabs: [
                Tab(
                  text: "Basic Info",
                ),
                Tab(
                  text: "Portfolio",
                ),
                Tab(
                  text: "Review",
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            About(context),
            Gallery(context),
            Center(
              child: Text("Barber reviews"),
            )
          ],
        ),
      ),
    );
  }
}

Widget About(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            "Contact",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(title: Text("Email"), subtitle: Text("sia@gmail.com")),
        ListTile(title: Text("Phone"), subtitle: Text("023456789")),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text("Social", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Wrap(children: [
          IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.facebook)),
          IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.twitter)),
          IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.instagram)),
          IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.whatsapp)),
        ]),
         Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            "Address",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(title: Text("House number"), subtitle: Text("AH-0985")),
        ListTile(title: Text("Post"), subtitle: Text("Box 56")),
      ],
    ),
  );
}

Widget Gallery(BuildContext context) {
  return SingleChildScrollView(
    child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 9.8,
        child: GridView.builder(
            itemCount: 7,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2),
            itemBuilder: (context, photos) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage("images/manshaving.jpg"),
                        fit: BoxFit.cover)),
                height: 150,
                child: Text("Nice fade"),
              );
            }),
      ),
    ),
  );
}

Widget chatCard(
    String img, String name, String date, String time, String message) {
  return SizedBox(
      height: 80,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(img),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(name),
                          Wrap(children: [
                            Text("4.3"),
                            Icon(Icons.star, color: Colors.amber)
                          ])
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
                child: Text(
                    "This is my review about this shop after having theri service"))
          ],
        ),
      ));
}

Widget Review(BuildContext context) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: items.length,
    padding: const EdgeInsets.symmetric(vertical: 16),
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: chatCard(
            items[index]["img"],
            items[index]["name"],
            items[index]["date"],
            items[index]["time"],
            items[index]["message"]),
      );
    },
  );
}

List items = [
  {
    "img": "images/nicesalon.jpg",
    "name": "Kay",
    "date": "20th Oct",
    "time": "12:00 pm",
    "message": "Hello"
  },
  {
    "img": "images/salon.jpg",
    "name": "Joe",
    "date": "20th Oct",
    "time": "12:00 pm",
    "message": "Are you there?"
  },
];
