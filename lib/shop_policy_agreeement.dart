import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:thecut/screens/Shop/shop_home_screen.dart';
// import 'package:thecut/screens/client_screen_with_drawer.dart';
import 'package:thecut/screens/newshop/shop_main_screen.dart';

import 'providers/provider.dart';

class PolicyAgreementScreen extends StatelessWidget {




  Widget build(BuildContext context) {

    ApplicationProvider appProv=Provider.of<ApplicationProvider>(context,listen:false);

    return SafeArea(
        child: new Scaffold(
            appBar: new AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close)),
              title: const Text('Agreement'),
              actions: [
                new TextButton(
                    onPressed: () {
                      print("Policy Page" + appProv.phoneNumber.toString());
                      FirebaseFirestore.instance
                          .collection("shops")
                          .doc(appProv.phoneNumber.toString())
                          .set(
                    appProv.shopDetails
                      ).then((value) {
                        print("Shop Account Created Successfully");
                        FirebaseFirestore.instance
                            .collection("registry")
                            .doc(appProv.phoneNumber)
                            .set({"uid": appProv.phoneNumber,
                          "type": "shop"
                        }).then((value) => {
                          print('Shop Created and Registered Successfully'),

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Shop Created and Registered Successfully')),
                          ),
                          /*Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return ShopMainScreen();
                                  })),*/
                        Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context) =>ShopMainScreen()),
                        (route) => false)
                        }).catchError((error) {
                          print(error.toString());
                        });
                      }).catchError((error) {
                        print(error.toString());
                      });

                    },
                    child: new Text('AGREE',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white))),
              ],
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Text('''
              These Terms and Conditions 
              nstitute a 
              legally binding agreement  made between yo
               
              whether personally or on behalf of an enti
               (“you”) 
              and [business entity name] (“we,” “us” or 
              ur”),
               concerning your access to and use of the 
               ebsite name.com] 
               website as well as any other media form, 
         media channel, mobile website or mobile applica
          related, linked, 
          or otherwise connected thereto (collectively, 
          e “Site”). You agree
           that by accessing the Site, you have read, un
           rstood, and agree t
           o be bound by all of these Terms and Conditio
            Use. 
           IF YOU DO NOT AGREE WITH ALL OF THESE TERMS a
            
           CONDITIONS, THEN YOU ARE EXPRESSLY PROHIBITED
           ROM USING 
           THE SITE AND YOU MUST DISCONTINUE USE IMMEDIA
           LY. '''),
    )));

  }
}