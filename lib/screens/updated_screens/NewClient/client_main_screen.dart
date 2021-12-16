//This is the client home screen.It has bottom navigations
//the home nav,the near by nav,the appointments nav and profile nav
//The home screen has been put up to make it easy for the user
//to be able to easily find a service
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
//import 'package:thecut/screens/retrieve_shop_screen.dart';
import 'package:thecut/screens/updated_screens/NewClient/client_appointment_screen.dart';
import 'package:thecut/screens/updated_screens/NewClient/client_home_screen.dart';
import 'package:thecut/screens/updated_screens/NewClient/client_saved_screen.dart';
import 'package:thecut/screens/updated_screens/NewClient/retrieve_shop_screen.dart';
import 'package:thecut/screens/updated_screens/search_delegate.dart';
import 'package:thecut/sign_in_option_screen.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//import 'package:theshave/screens/NewClient/client_chat_screen.dart';

//import 'package:newscreens/screens/NewClient/client_profile_screen.dart';

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
  late String name = "";
  late String mail = "";
  
  List<Widget> pages = [
    HomeScreen(),
    RetrievePage(),
    ClientSaved(),
    ClientAppointments(),
  ];
late Future<DocumentSnapshot<Map<String, dynamic>>> user;
  int index = 0;
  bool showsearch = true;

  @override
  void initState() {
    super.initState();
     user =
        Provider.of<ApplicationProvider>(context, listen: false).getUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
              key: scaffolKey,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                actions: [
                  IconButton(
                      onPressed: () {
                        showSearch(context: context, delegate: PerformSearch());
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ))
                ],
              ),
              drawer: Drawer(
                child: Material(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    /* crossAxisAlignment: CrossAxisAlignment.start,*/
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DrawerHeader(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/drawer.jpg'),
                          ),
                        ),
                        padding: EdgeInsets.all(0),
                        child: Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              CircleAvatar(
                                radius: 42,
                                backgroundImage:
                                    AssetImage('assets/images/profile.jpg'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FutureBuilder(
                                
                                future: user,
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
                                return Text(snapshot.data!["name"],
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),);
                              })
                              
                             
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
                              child: Icon(Icons.payments, color: Colors.white)),
                        ),
                        title: Text(
                          "Cards",
                          style: TextStyle(
                            fontSize: 16,
                          ),
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
                              fontSize: 16,
                            ),
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
                                fontSize: 16,
                              )),
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
                                    Provider.of<ApplicationProvider>(context,
                                            listen: false)
                                        .signOut();
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (builder) {
                                      return SignInOptionScreen();
                                    }), (route) => false);
                                    //go back to sign in
                                  },
                                  child: Text("Sign Out"))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.shifting,
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
                    BottomNavigationBarItem(
                        icon: Icon(Icons.inbox), label: "Saved"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.history), label: "Appointments"),
                  ]),
              body: pages.elementAt(index)),
        ));
  }
}

//All screens for the bottom nav are built in different in their separate files

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String name = "Name", mail = "a@gmail.com", phone = "0271302702";
  TextEditingController editname = TextEditingController();
  TextEditingController editmail = TextEditingController();
  TextEditingController editphone = TextEditingController();

  void initState() {
    super.initState();

    editname.addListener(() {
      editname.text = name;
    });
    editmail.addListener(() {
      editmail.text = mail;
    });
    editphone.addListener(() {
      editphone.text = phone;
    });

    editname.text = name;
    editmail.text = mail;
    editphone.text = phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Profile"),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          //Top container
          SizedBox(height: 60),
          Stack(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: CircleAvatar(
                  child: Text("E"),
                ),
              ),
              Positioned(
                  right: 5,
                  bottom: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.camera_enhance, size: 40),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Name"),
              subtitle: TextField(
                  onSubmitted: (newname) {
                    setState(() {
                      name = newname;
                    });
                  },
                  controller: editname,
                  autofocus: true,
                  decoration: InputDecoration()),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Email"),
              subtitle: TextField(
                  onSubmitted: (newmail) {
                    setState(() {
                      mail = newmail;
                    });
                  },
                  controller: editname,
                  autofocus: true,
                  decoration: InputDecoration()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Phone"),
              subtitle: TextField(
                  onSubmitted: (newphone) {
                    setState(() {
                      phone = newphone;
                    });
                  },
                  controller: editname,
                  autofocus: true,
                  decoration: InputDecoration()),
            ),
          ),

          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(onPressed: () {}, child: Text("Save ")),
            ),
          )
        ],
      ),
    );
  }
}
