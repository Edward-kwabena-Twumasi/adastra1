//This is the shops main screen .This is what
//the shop also has bottom navs for a
//dashboad of important business information

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/newshop/add_new_style.dart';
import 'package:thecut/screens/newshop/new_appointment_screen.dart';
import 'package:thecut/screens/newshop/shop_account.dart';
//import 'package:thecut/screens/newshop/shop_appointments_screen.dart';
import 'package:thecut/screens/newshop/shop_clients_screen.dart';
import 'package:thecut/screens/newshop/shop_dashboard_screen.dart';

//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:theshave/screens/newshop/shop_about_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thecut/screens/newshop/shop_drawer.dart';

import '../../../sign_in_option_screen.dart';
import 'add_barber.dart';
import 'package:badges/badges.dart';

class ShopMainScreen extends StatefulWidget {
  const ShopMainScreen({Key? key}) : super(key: key);

  @override
  ShopMainScreenState createState() => ShopMainScreenState();
}

class ShopMainScreenState extends State<ShopMainScreen> {
  // final phoneFuture = Provider.of<ApplicationProvider>(context, listen: false)
  //     .getPhoneFuture();

  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
  late String shopname = "";
  late String shopMail = "";

  late StreamSubscription shopSubscription;
  late StreamSubscription pendingCountSubscription;
  late StreamSubscription paymentsCountSubscription;
  late StreamSubscription unWatchedCountSubscription;
  late StreamSubscription confirmedCountSubscription;
  Map<String, dynamic> shopDetails = {};
  int index = 0;
  bool showsearch = true;
  List<Widget> pages = [
    //dashboard
    Dashboard(),
    AppointmentPage(),
    ShopClients(),
  ];

  @override
  void initState() {
    super.initState();
     DateTime now = DateTime.now();
    DateTime temp = now.add(Duration(days: 1));
    DateTime tomorrow = DateTime(temp.year, temp.month, temp.day, 0, 0, 0);

    //1
    shopSubscription = provider().getShop().listen((event) {
      provider().setShopDetails(event.data()!);
      setState(() {
        shopDetails = event.data()!;
      });
      provider().barberCount(shopDetails["barbers"].length);
    });
//2
    pendingCountSubscription = provider().pendingRequests().listen((event) {
      provider().pendingCount(event.size);
    });
    //3
    paymentsCountSubscription = provider().paymentsToShop().listen((event) {
      provider().paymentsCount(event.size);
    });
    //4
    unWatchedCountSubscription = provider().unwatchedRequests().listen((event) {
      provider().unWatchedCount(event.docs.length);
    });
     confirmedCountSubscription = provider().confirmedAppointments(tomorrow).listen((event) {
      provider().confirmedCount(event.size);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    shopSubscription.cancel();
    pendingCountSubscription.cancel();
    paymentsCountSubscription.cancel();
    unWatchedCountSubscription.cancel();
    confirmedCountSubscription.cancel();
    
  }

  ApplicationProvider provider({bool listen = false}) {
    return Provider.of<ApplicationProvider>(context, listen: listen);
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return Container(
            child: Text('Page ${index}'),
          );
        }));
        break;
    }
  }

  buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    final color = Colors.black.withOpacity(0.64);
    return ListTile(
      tileColor: Colors.white,
      leading: Icon(icon, color: color),
      onTap: onClicked,
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
 
    return SafeArea(
      child: Scaffold(
          key: scaffolKey,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          drawer: ShopDrawer(),
          //shop has a dashboard,sees appointments and a
          //profile to edit to suit the business

          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              currentIndex: index,
              onTap: (newindex) {
                setState(() {
                  index = newindex;
                  //index > 0 ? showsearch = false : showsearch = true;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "Dashboard"),
                BottomNavigationBarItem(
                    icon: provider(listen: true).unWatched>0? Badge(
                                  animationDuration: Duration(seconds: 0),
                                  animationType: BadgeAnimationType.scale,
                                  badgeContent: Text( provider().unWatched.toString()),
                                  child: Icon(Icons.watch_later),
                                )
                              : Icon(Icons.watch_later),
                       
                    label: "Appointments"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Clients"),
              ]),
          body: pages.elementAt(index)),
    );
  }
}

//each navigation screen is built in a different file
//for easy file handling
//