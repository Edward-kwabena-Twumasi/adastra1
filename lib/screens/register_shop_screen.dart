import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/register_shop_location.dart';
import 'package:thecut/screens/tags.dart';
/*import 'package:thecut/screens/shop_register_location_screen.dart';*/

// import 'client_screen_with_drawer.dart';

class ShopRegistrationScreen extends StatefulWidget {
  const ShopRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<ShopRegistrationScreen> createState() => _ShopRegistrationScreenState();
}

class _ShopRegistrationScreenState extends State<ShopRegistrationScreen> {
  TextEditingController shopNameCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController locationCtrl = TextEditingController();
  TextEditingController ownerCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  

  //bool er1 = false, er2 = false;
  List<String> shopTypes = ['Barbering', 'Hair Dressing'];
  String? type = '-1';
  bool cutHair = false;
  bool dressHair = false;
  List<String> offeredTypes = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> getShopType() {
    List<String> shopModel = [];
    if (cutHair) {
      shopModel.add(shopTypes.first);
    }
    if (dressHair) {
      shopModel.add(shopTypes.last);
    }
    return shopModel;
  }

  @override
  initState(){
    phoneNumberCtrl.text=Provider.of<ApplicationProvider>(context,listen:false).phoneNumber!;
  }
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Register Shop',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Shop Name is Required';
                            }
                            return null;
                          },
                          controller: shopNameCtrl,
                          keyboardType: TextInputType.text,
                          decoration:  InputDecoration(
                    prefixIcon: Icon(Icons.local_convenience_store_rounded),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Shop name',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Eg. John's shop",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.4),
                    )),
                        ),
                        const SizedBox(
                          height: 30.0,
                          
                        ),
                        Text(
                            'Shop Type',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                           const SizedBox(
                          height: 30.0,
                          
                        ),
                        CheckboxListTile(
                          title: const Text('Barbering'),
                          subtitle: const Text('Shop Type'),
                          secondary: const Icon(Icons.cut),
                          autofocus: false,
                          activeColor: Colors.black,
                          checkColor: Colors.white,
                          selected: cutHair,
                          value: cutHair,
                          onChanged: (bool? value) {
                            setState(() {
                              cutHair = value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: const Text('Hair Dressing'),
                          subtitle: const Text('Shop Type'),
                          secondary: const Icon(Icons.female),
                          autofocus: false,
                          activeColor: Colors.black,
                          checkColor: Colors.white,
                          selected: dressHair,
                          value: dressHair,
                          onChanged: (bool? value) {
                            setState(() {
                              dressHair = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          maxLength: 15,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Shop Owner's Name is Required";
                            }
                            return null;
                          },
                          controller: ownerCtrl,
                          keyboardType: TextInputType.text,
                          decoration:  InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Name of shop owner',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Eg. John',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.4),
                    )),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone Number is Required';
                            } else if (value.length != 10) {
                              return 'Total Digits must be equal to 10';
                            }
                            return null;
                          },
                          controller: phoneNumberCtrl,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration:  InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Shop Phone number',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Eg. 0XXXXXXXXX',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.4),
                    ))
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),

                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Your email is required';
                            }
                            return null;
                          },
                          controller: emailCtrl,
                          keyboardType: TextInputType.text,
                          decoration:  InputDecoration(
                    prefixIcon: Icon(Icons.location_pin),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Shop email',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Eg. shop@gmail.com',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.4),
                    )),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                         TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Your Location is required';
                            }
                            return null;
                          },
                          controller: locationCtrl,
                          keyboardType: TextInputType.text,
                          decoration:  InputDecoration(
                    prefixIcon: Icon(Icons.location_pin),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Land Mark',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Eg. Davis Street',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.4),
                    )),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (cutHair || dressHair) {
                          print(getShopType());
                          print(shopNameCtrl.text +
                              ' ' +
                              locationCtrl.text +
                              ' ' +
                              phoneNumberCtrl.text +
                              ' ' +
                              locationCtrl.text);
                          /* ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );*/

                          print("++++++++++++++++PHONE FROM SHARED-PREFS++++++++++++++++++++++++");


                          final appProv = Provider.of<ApplicationProvider>(
                              context,
                              listen: false);

                          print(appProv.phoneNumber);
                          appProv.setTempShopDetails({
                            "uid": appProv.phoneNumber,
                            "email":emailCtrl.text ,
                            "phone": phoneNumberCtrl.text,
                            "type": getShopType(),
                            "owner_name": ownerCtrl.text,
                            "landmark": locationCtrl.text,
                            "name": shopNameCtrl.text,
                            "barbers":[],
                            "photo_url":""
                          });

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Tags();
                          }));

                          
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Shop Type Required')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        elevation: 10.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        shape: StadiumBorder()
                            
                            ),
                    child: const Text('Proceed'),
                   
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
