import 'package:flutter/material.dart';
import 'package:thecut/screens/Client/client_appointments_screen.dart';
import 'package:thecut/screens/Client/client_notification_screen.dart';
import 'package:thecut/screens/Client/client_payment_screen.dart';
//import 'package:thecut/screens/bookappointment.dart';
// import 'package:thecut/screens/Client/maps.dart';
import 'package:thecut/screens/Shop/shop_home_screen.dart';

import 'client_barber_screen.dart';

void main() {
  runApp(ClientScreen());
}

//late GoogleMapController mapController;
class ClientScreen extends StatefulWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  //BuildContext context =ScaffoldState().context;
  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
  List<String> titles = ["", "Payment", "Notifications", "History"];
  int index = 0;
  bool showsearch = true;
  List<Widget> pages = [
   Center(),
   clientPayment(),
     clientNotifications(),
     Container(
       color:Colors.orange,
       child: Column(
      children: [
        Center(child: Text("History",style: TextStyle(color: Colors.black),)),
      ],
    )),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            endDrawer: SizedBox(
              width: 300,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment(-1, 1),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.black)),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 4,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Image.asset(
                        "images/lovecut.jpg",
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    ListTile(
                      title: Center(child: Text("Bod day")),
                      subtitle: Center(
                        child: Text(
                          "rdoetothemoon@gmail.com",
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, -1),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.black)),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 3,
                      color: Colors.black,
                    ),
                    //end of top container
                    Expanded(
                        child: Column(children: [
                          const SizedBox(
                            height: 30,
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (contex) {
                                return const ClientAppointments();
                              }));
                            },
                            leading: Icon(Icons.watch),
                            title: const Text(
                              "Appointments",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ListTile(
                             onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (contex) {
                                return const ClientBarbers();
                              }));
                            },
                            leading: Icon(Icons.people),
                            title: Text("My barbers",
                                style: TextStyle(fontSize: 16)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ListTile(
                            onTap: (){
                               Navigator.push(context,
                                  MaterialPageRoute(builder: (contex) {
                                return Shop();
                              }));
                            },
                            leading: Icon(Icons.lens),
                            title: Text("Shop lookup",
                                style: TextStyle(fontSize: 16)),
                          )
                        ]))
                  ],
                ),
              ),
            ),
            key: scaffolKey,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                titles.elementAt(index),
                style: TextStyle(color: Colors.black),
              ),
              
              leading: showsearch
                  ? IconButton(
                      onPressed: () {
                        /*showSearch(
                            context: context,
                            delegate: CustomSearchHintDelegate(
                                hintText: "find shop"));*/
                      },
                      icon: Icon(Icons.search, size: 40, color: Colors.black)):Text(""),
                 
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                    onPressed: () {
                      scaffolKey.currentState!.openEndDrawer();
                    },
                    icon: Icon(Icons.menu, size: 40, color: Colors.black)),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                currentIndex: index,
                onTap: (newindex) {
                  setState(() {
                    index = newindex;
                    index > 0 ? showsearch = false : showsearch = true;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.location_on), label: "Find"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.payment), label: "Payment"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.notifications), label: "Notifications"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.history), label: "History"),
                ]),
            body: pages.elementAt(index)));
  }
}

//search delegate
