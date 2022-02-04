import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/NewClient/image_picker_screen.dart';
import 'package:thecut/screens/NewClient/support.dart';
import 'package:thecut/screens/search_delegate.dart';

import '../../../sign_in_option_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key, required this.user}) : super(key: key);
  final Stream<DocumentSnapshot<Map<String, dynamic>>> user;
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final name = 'Robert Doe';
  final email = ' sarah@abs.com';
  final urlImage =
      'https://yt3.ggpht.com/ytc/AAUvwngoALKuaNi8XBgOaF2KgvjW8fvHMpkz36tVRFYsFZg=s900-c-k-c0x00ffffff-no-rj';

  ApplicationProvider getProvider() {
    return Provider.of<ApplicationProvider>(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(horizontal: 20);
    return Drawer(
      elevation: 10,
      child: Material(
        color: const Color(0xFF022744),
        child: Column(
          // padding: padding,
          children: [
            // buildHeader(
            //     urlImage: urlImage,
            //     name: name,
            //     email: email,
            //     onClicked: () {},
            //     user: widget.user),
            Container(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: getProvider()
                            .userDetails["photo_url"]
                            .toString()
                            .isNotEmpty
                        ? NetworkImage(getProvider().userDetails["photo_url"])
                        : NetworkImage(urlImage),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getProvider().userDetails["firstName"],
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      Text(
                        getProvider().userDetails["email"],
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return ImagePickerCurrentScreen();
                        }));
                      },
                      icon: Icon(Icons.edit))
                ],
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            /*buildMenuItem(
                text: 'Search',
                icon: Icons.search,
                onClicked: () {
                  selectedItem(context, 0);
                }),*/
            GestureDetector(
              child: buildMenuItem(text: 'Find Shop', icon: Icons.search),
              onTap: () {
                Navigator.pop(context);
               
              },
            ),

            buildMenuItem(text: 'History', icon: Icons.find_replace),
            buildMenuItem(text: 'Invite', icon: Icons.share),
            GestureDetector(
              child: buildMenuItem(text: 'Support', icon: Icons.help),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) {
                  return Support();
                }));
              },
            ),
            //buildMenuItem(text: 'Plugins', icon: Icons.access_time),
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
      required VoidCallback onClicked,
      required Stream<DocumentSnapshot<Map<String, dynamic>>> user}) {
    return InkWell(
        onTap: onClicked,
        child: StreamBuilder(
            stream: user,
            builder: (BuildContext,
                AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text(""));
              } else if (snapshot.hasError) {
                return Material(
                  child: Center(
                    child: Text('Oops,an error occured'),
                  ),
                );
              }
              return Container(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          snapshot.data!["photo_url"].toString().isNotEmpty
                              ? NetworkImage(snapshot.data!["photo_url"])
                              : NetworkImage(urlImage),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!["firstName"],
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                        Text(
                          snapshot.data!["email"],
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (builder) {
                            return ImagePickerCurrentScreen();
                          }));
                        },
                        icon: Icon(Icons.edit))
                  ],
                ),
              );
            }));
    //
  }
}
