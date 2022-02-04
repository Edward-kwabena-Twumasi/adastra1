import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/newbarber/barber_account.dart';
import 'package:thecut/screens/newbarber/barber_profile_screen.dart';
import 'package:thecut/screens/newbarber/barber_tasks_screen.dart';
import 'package:thecut/screens/share_app.dart';

import '../../sign_in_option_screen.dart';


class BarberMainScreen extends StatefulWidget {
  const BarberMainScreen({Key? key}) : super(key: key);

  @override
  _BarberMainScreenState createState() => _BarberMainScreenState();
}

class _BarberMainScreenState extends State<BarberMainScreen> {
  int index = 0;
  List<Widget> pages = [
    BarberAboutScreen(),
    BarberTaskScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:MainAxisAlignment.center,
            children:[
             
            Container(
              height:200,
              decoration:BoxDecoration(
                color:Colors.lightBlue.withOpacity(0.06),
                // borderRadius: BorderRadius.only(
                //   bottomRight:Radius.circular(10)
                // )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:40.0),
                child: ListTile( title: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text("Sia", style:TextStyle(fontWeight:FontWeight.w500,fontSize:22 )),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text("The Cut", style:TextStyle(color:Colors.black.withOpacity(0.7)
                  ))
                  )
                  ,
                  trailing:Stack(children: [
                                  Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Colors.amber.withOpacity(0.8), width: 3),
                                )
                                    ),
                       
                                      Positioned(
                          right: 1,
                          bottom: 5,
                                       child: Container(
                                                             height: 50,
                                                             width: 50,
                                                             decoration: BoxDecoration(
                                                                 shape: BoxShape.circle,
                                                                 color: Colors.transparent,
                                                                 border: Border.all(
                                                                     color: Colors.pink.withOpacity(0.8), width: 3),
                                                                 )
                                                                     ),
                                     ),
                                      Positioned(
                          left: 4,
                          top: 0,
                          child: Container(
                              height: 59,
                              width: 50,
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
                        
                      ]), 
                  ),
              ),
            ),
             
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(onTap: (){
                   Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return BaerberAccount();
                        }));
                }, title: Text("Account",style: TextStyle(fontWeight: FontWeight.bold ),)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(onPressed: (){}, child: Text("Help",style: TextStyle(fontWeight: FontWeight.bold ))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(onPressed: (){}, child: Text("Messages",style: TextStyle(fontWeight: FontWeight.bold ))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(onTap: (){
                   Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return ShareApp();
                        }));
                }, title: Text("Share",style: TextStyle(fontWeight: FontWeight.bold ),)),
              ),
              Spacer(),
               ListTile(
              title: TextButton(
                  onPressed: () {
                    Provider.of<ApplicationProvider>(context, listen: false)
                        .signOut();
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (builder) {
                      return SignInOptionScreen();
                    }), (route) => false);
                    //go back to sign in
                  },
                  child: Text("Sign Out")),
            ),
            ]
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
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.watch), label: "Timeline"),
            ]),
        body: SafeArea(child: pages.elementAt(index)));
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


 