//This is the shops main screen .This is what 
//the shop also has bottom navs for a 
//dashboad of important business information
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thecut/screens/newshop/shop_about_screen.dart';
import 'package:thecut/screens/newshop/shop_appointments_screen.dart';
import 'package:thecut/screens/newshop/shop_dashboard_screen.dart';
import 'package:thecut/screens/newshop/shop_porofile_screen.dart';




class ShopMainScreen extends StatefulWidget {
  const ShopMainScreen({Key? key}) : super(key: key);

  @override
  ShopMainScreenState createState() => ShopMainScreenState();
}

class ShopMainScreenState extends State<ShopMainScreen> {
  //BuildContext context =ScaffoldState().context;
  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
  //List<String> titles = ["", "Payment", "Notifications", "History"];
  int index = 0;
  bool showsearch = true;
  List<Widget> pages = [
    //dashboard
    Dashboard(),
    Appointments(),
  ShopProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            endDrawer: SizedBox(
              child: Text("Hey"),
            ),
            key: scaffolKey,
            extendBodyBehindAppBar: true,
           
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
                      icon: Icon(Icons.history), label: "Appointments"),
                      BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Profile"),
                ]),
            body: pages.elementAt(index)));
  }
}

//each navigation screen is built in a different file
//for easy file handling
//