//This is the shops main screen .This is what
//the shop also has bottom navs for a
//dashboad of important business information

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/updated_screens/newshop/new_appointment_screen.dart';
import 'package:thecut/screens/updated_screens/newshop/shop_appointments_screen.dart';
import 'package:thecut/screens/updated_screens/newshop/shop_clients_screen.dart';
import 'package:thecut/screens/updated_screens/newshop/shop_dashboard_screen.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:theshave/screens/newshop/shop_about_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../sign_in_option_screen.dart';

class ShopMainScreen extends StatefulWidget {
  const ShopMainScreen({Key? key}) : super(key: key);

  @override
  ShopMainScreenState createState() => ShopMainScreenState();
}

class ShopMainScreenState extends State<ShopMainScreen> {
  // final phoneFuture = Provider.of<ApplicationProvider>(context, listen: false)
  //     .getPhoneFuture();

  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
  late String name="";
  late String mail="";

late Future<DocumentSnapshot<Map<String, dynamic>>> shop;
  int index = 0;
  bool showsearch = true;
  List<Widget> pages = [
    //dashboard
    Dashboard(),
    AppointmentPage(),
    ShopClients(),
  ];
  @override
  void initState(){
    super.initState();
    shop =
        Provider.of<ApplicationProvider>(context, listen: false).getShop();

   
  }
  @override
  Widget build(BuildContext context) {
   // CollectionReference shops = FirebaseFirestore.instance.collection('shops');

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
              key: scaffolKey,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                /*leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),*/
              ),
              endDrawer: Drawer(
                child: Material(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                   /* crossAxisAlignment: CrossAxisAlignment.start,*/
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [ DrawerHeader(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/drawer.jpg'),
                          ),
                        ),
                        padding: EdgeInsets.all(0),
                        child: Container(
                          child: Column(
                            children:  [
                              SizedBox(
                                height: 10,
                              ),
                              CircleAvatar(
                                radius: 42,
                                backgroundImage: AssetImage('assets/images/profile.jpg'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FutureBuilder(
                                
                                future: shop,
                                builder:
                                  (BuildContext,
                                      AsyncSnapshot<DocumentSnapshot<Object?>>
                                          snapshot) {
                                            if (snapshot.connectionState==ConnectionState.waiting) {
                                               return Center(
              child: Material(
                child: SpinKitPouringHourGlassRefined(
                  color: Colors.black,
                ),
              )
          );
                                            }
                                          else  if (snapshot.hasError) {
          return Material(
            child: Center(
              child: Text('Oops,an error occured'),
            ),
          );
        }
                                return Text(snapshot.data!["name"]);
                              })
                              // Text(
                              //   name,
                              //   style: TextStyle(
                              //     fontSize: 15,
                              //     color: Colors.white,
                              //     fontWeight: FontWeight.w400,
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              // Text(
                              //  mail,
                              //   style: TextStyle(
                              //     fontSize: 10,
                              //     color: Colors.white,
                              //     fontWeight: FontWeight.w400,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),


                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          "Account Settings",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: SizedBox(
                          height: 36,
                          width: 36,
                          child: CircleAvatar(
                              backgroundColor: Colors.red[200],
                              child:
                                  Icon(Icons.payments, color: Colors.white)),
                        ),
                        title: Text(
                          "Cards",
                          style: TextStyle(
                              fontSize: 16,),
                        ),
                        trailing: InkWell(
                          highlightColor: Colors.lightBlue[36],
                          splashColor: Colors.lightBlue[100],
                          enableFeedback: true,
                          borderRadius: BorderRadius.circular(36),
                          onTap: () {},
                          child: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                          leading: SizedBox(
                            height: 36,
                            width: 36,
                            child: CircleAvatar(
                                backgroundColor: Colors.amber,
                                child: Icon(Icons.notifications,
                                    color: Colors.white)),
                          ),
                          title: Text(
                            "Job requests",
                            style: TextStyle(
                                fontSize: 16,),
                          ),
                          trailing: InkWell(
                            highlightColor: Colors.lightBlue[36],
                            splashColor: Colors.lightBlue[100],
                            enableFeedback: true,
                            borderRadius: BorderRadius.circular(36),
                            onTap: () {},
                            child: Icon(Icons.arrow_forward_ios),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                          leading: SizedBox(
                            height: 36,
                            width: 36,
                            child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                child:
                                    Icon(Icons.history, color: Colors.white)),
                          ),
                          title: Text("My barbers",
                              style: TextStyle(
                                  fontSize: 16,)),
                          trailing: InkWell(
                            highlightColor: Colors.lightBlue[36],
                            splashColor: Colors.lightBlue[100],
                            enableFeedback: true,
                            borderRadius: BorderRadius.circular(36),
                            onTap: () {},
                            child: Icon(Icons.arrow_forward_ios),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text("My Account",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              tileColor: Colors.lightBlue[36],
                              title: TextButton(
                                  onPressed: () {
                                    Provider.of<ApplicationProvider>(context, listen: false).signOut();
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder){
                                      return SignInOptionScreen();
                                    }), (route) => false);
                                  }, child: Text("Sign Out"))),
                        ),
                      )
                    ],
                  ),
                ),
              ),

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
                        icon: Icon(Icons.person), label: "Clients"),
                  ]),
              body: pages.elementAt(index)),
        ));
  }
}

//each navigation screen is built in a different file
//for easy file handling
//
