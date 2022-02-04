import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/newshop/add_barber.dart';
import 'package:thecut/screens/newshop/add_new_style.dart';
import 'package:thecut/screens/newshop/shop_account.dart';
import 'package:thecut/screens/newshop/shop_settings_screen.dart';

import '../../sign_in_option_screen.dart';

class ShopDrawer extends StatefulWidget {
  const ShopDrawer({Key? key}) : super(key: key);

  @override
  _ShopDrawerState createState() => _ShopDrawerState();
}

class _ShopDrawerState extends State<ShopDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          /* crossAxisAlignment: CrossAxisAlignment.start,*/
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/drawer.jpg'),
                ),
              ),
              padding: EdgeInsets.all(0),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ListTile(
                          
                      
                        contentPadding: EdgeInsets.zero,
                        title: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            provider().shopDetails['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                              provider().shopDetails[
                                  'email'] /*provider().shopDetails["email"]*/,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white)),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (builder) {
                              return ShopSettingsScreen();
                            }));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            buildMenuItem(
                text: 'Add Price Category',
                icon: Icons.add,
                onClicked: () {
                  //selectedItem(context, 0);
                  Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    return AddShopStyle();
                  }));
                }),
            buildMenuItem(
                text: 'My Barbers',
                icon: Icons.person,
                onClicked: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    return AddBarber();
                  }));
                }),
            buildMenuItem(
                text: 'Accounts',
                icon: Icons.account_balance_wallet,
                onClicked: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    return ShopAccount();
                  }));
                }),
            buildMenuItem(
                text: 'Support', icon: Icons.contact_support, onClicked: () {}),
            buildMenuItem(text: 'About', icon: Icons.info, onClicked: () {}),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    tileColor: Colors.lightBlue[50],
                    title: TextButton(
                        onPressed: () {
                          Provider.of<ApplicationProvider>(context,
                                  listen: false)
                              .signOut();
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (builder) {
                            return SignInOptionScreen();
                          }), (route) => false);
                        },
                        child: Text("Sign Out"))),
              ),
            )
          ],
        ),
      ),
    );
  }

  ApplicationProvider provider() {
    return Provider.of<ApplicationProvider>(context, listen: false);
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
}
