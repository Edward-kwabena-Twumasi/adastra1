//This is the client home screen.It has bottom navigations
//the home nav,the near by nav,the appointments nav and profile nav
//The home screen has been put up to make it easy for the user 
//to be able to easily find a service
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thecut/screens/Client/client_appointments_screen.dart';
//import 'package:theshave/screens/NewClient/client_chat_screen.dart';
import 'package:thecut/screens/NewClient/client_home_screen.dart';
import 'package:thecut/screens/NewClient/client_profile_screen.dart';
import 'package:thecut/screens/NewClient/nearby_screen.dart';
import 'package:thecut/screens/retrieve_shop_screen.dart';
import 'package:thecut/screens/updated_screens/NewClient/retrieve_shop_screen.dart';


//here,we begin with our main screen
//and oh yes we have a drawer
class ClientMainScreen extends StatefulWidget {
  const ClientMainScreen({Key? key}) : super(key: key);

  @override
  _ClintMainScreenState createState() => _ClintMainScreenState();
}

class _ClintMainScreenState extends State<ClientMainScreen> {
  //BuildContext context =ScaffoldState().context;
  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
  //List<String> titles = ["", "Payment", "Notifications", "History"];
  int index = 0;
  bool showsearch = true;
  List<Widget> pages = [
  homeScreen(),
    RetrievePage(),
  // Chats(),
    ClientAppointments(),
    Profile()
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
            // appBar: AppBar(
            //   centerTitle: true,
              
              
            //   leading: index<1
            //       ? IconButton(
            //         onPressed: () {
            //           scaffolKey.currentState!.openEndDrawer();
            //         },
            //         icon: Icon(Icons.menu, size: 30, color: Colors.white)):Text(""),
                 
            //   elevation: 0.0,
            //   backgroundColor: Colors.transparent,
            //   actions: [
            //     IconButton(
            //         onPressed: () {
                      
            //         },
            //         icon: const FaIcon(FontAwesomeIcons.filter,size: 25, color: Colors.white)),
            //   ],
            // ),
            //botttom navigation bar
            //rhe navigation bar has the Home,Near by,appointment and profile navs
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
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.place), label: "Near by"),
                  // BottomNavigationBarItem(
                  //     icon: Icon(Icons.inbox), label: "Chats"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.history), label: "Appointments"),
                      BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Profile"),
                ]),
            body: pages.elementAt(index)));
  }
}

//All screens for the bottom nav are built in different in their separate files
