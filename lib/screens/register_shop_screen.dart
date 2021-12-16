import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/register_shop_location.dart';
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
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.house),
                            border: OutlineInputBorder(),
                            labelText: 'Name of Shop',
                            hintText: 'Eg. Sharp Lazer Cutz ',
                            /* labelStyle: TextStyle(
                              color: er1 == false ? Colors.black : Colors.red,
                            ),*/
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                          child: Text(
                            'Shop Type',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Shop Owner\'s Name is Required';
                            }
                            return null;
                          },
                          controller: ownerCtrl,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                            labelText: 'Name of Shop Owner',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
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
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                            focusColor: Colors.black,
                            labelText: 'Enter your Phone Number',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
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
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.map),
                              border: OutlineInputBorder(),
                              labelText: 'Location (Ghana POST GPS)',
                              hintText: 'Eg. WS-018-1000'),
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
                  child: ElevatedButton.icon(
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
                          appProv.setShopDetails({
                            "uid": appProv.phoneNumber,
                            "email": "",
                            "phone": phoneNumberCtrl.text,
                            "type": getShopType(),
                            "owner_name": ownerCtrl.text,
                            "gps_location": locationCtrl.text,
                            "name": shopNameCtrl.text
                          });

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RegisterShopLocation();
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    label: const Text('Proceed'),
                    icon: const Icon(Icons.arrow_right),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
