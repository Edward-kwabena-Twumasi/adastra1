import 'package:flutter/material.dart';
import 'package:thecut/screens/updated_screens/newbarber/barber_profile_screen.dart';
import 'package:thecut/screens/updated_screens/newbarber/barber_tasks_screen.dart';


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
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
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
                    icon: Icon(Icons.info_outline), label: "General"),
              ]),
          body: SafeArea(child: pages.elementAt(index))),
    );
  }
}
