import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key, required this.user}) : super(key: key);
  final Future<DocumentSnapshot<Map<String, dynamic>>> user;
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final name = 'Robert Doe';
  final email = ' sarah@abs.com';
  final urlImage =
      'https://yt3.ggpht.com/ytc/AAUvwngoALKuaNi8XBgOaF2KgvjW8fvHMpkz36tVRFYsFZg=s900-c-k-c0x00ffffff-no-rj';

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(horizontal: 20);
    return Drawer(
      elevation: 10,
      child: Material(
        color: const Color(0xFF022744),
        child: ListView(
          padding: padding,
          children: [
            buildHeader(
                urlImage: urlImage, name: name, email: email, onClicked: () {},user: widget.user),
            const SizedBox(
              height: 48,
            ),
            buildMenuItem(
                text: 'Search',
                icon: Icons.search,
                onClicked: () {
                  selectedItem(context, 0);
                }),
            buildMenuItem(text: 'People', icon: Icons.people),
            buildMenuItem(text: 'Favorites', icon: Icons.favorite),
            buildMenuItem(text: 'Workflow', icon: Icons.phone),
            buildMenuItem(text: 'Updates', icon: Icons.update),
            buildMenuItem(text: 'Plugins', icon: Icons.access_time),
          ],
        ),
      ),
    );
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
    final color = Colors.white.withOpacity(0.64);
    return ListTile(
      leading: Icon(icon, color: color),
      onTap: onClicked,
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }

  Widget buildHeader(
      {required String urlImage,
      required String name,
      required String email,
      required VoidCallback onClicked,required  Future<DocumentSnapshot<Map<String, dynamic>>> user}) {
    return InkWell(
        onTap: onClicked,
         child:FutureBuilder(
                                
                                future: user,
                                builder:
                                  (BuildContext,
                                      AsyncSnapshot<DocumentSnapshot<Object?>>
                                          snapshot) {
                                            if (snapshot.connectionState==ConnectionState.waiting) {
                                               return Center(
              child: Text("")
          );
                                            }
                                          else  if (snapshot.hasError) {
          return Material(
            child: Center(
              child: Text('Oops,an error occured'),
            ),
          );
        }
                                return  Container(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(urlImage),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.data!["name"],
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  Text(
                    snapshot.data!["email"],
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
              const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.edit))
            ],
          ),
        );
                              }
                              ));
         //
  }
}
