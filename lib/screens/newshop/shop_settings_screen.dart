import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/NewClient/detail_display.dart';

class ShopSettingsScreen extends StatefulWidget {
  const ShopSettingsScreen({Key? key}) : super(key: key);

  @override
  ShopSettingsScreenState createState() => ShopSettingsScreenState();
}

class ShopSettingsScreenState extends State<ShopSettingsScreen> {
  File? _imageFile;
  final ImagePicker image = ImagePicker();
  String? uploadedFile;
  bool showPassword = false;
  TextEditingController shopnameCtrl = TextEditingController();
  TextEditingController ownernameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController gpsCtrl = TextEditingController();

  Future<void> _getImage() async {
    XFile? file = await image.pickImage(
        source: ImageSource.gallery, maxHeight: 600, imageQuality: 90);

    if (file != null) {
      setState(() {
        _imageFile = File(file.path);
      });
    }
    if (_imageFile != null) {
      String fileName = path.basename(_imageFile!.path);
      final ref =
          FirebaseStorage.instance.ref().child('profile').child(fileName);
      final uploadFuture =
          await ref.putFile(_imageFile!).whenComplete(() async {
        print('Upload Completed');

        final downloadUrl = await ref.getDownloadURL();
        setState(() {
          uploadedFile = downloadUrl;
        });
      });
    }
  }

  @override
  initState() {
    final appProv = Provider.of<ApplicationProvider>(context, listen: false);
    shopnameCtrl.text = appProv.shopDetails['name'];
    ownernameCtrl.text = appProv.shopDetails['owner_name'];
    emailCtrl.text = appProv.shopDetails['email'];
    phoneCtrl.text = appProv.shopDetails['phone'];
    uploadedFile = appProv.shopDetails['photo_url'];
    //gpsCtrl.text=appProv.userDetails[''];
  }

  Future uploadImageToFirebase(BuildContext ctx) async {
    if (_imageFile != null || uploadedFile != null) {
      /*  ref.getDownloadURL().then((value) {*/

      /* });*/
      //print(await ref.getDownloadURL());

      FirebaseFirestore.instance
          .collection('shops')
          .doc(Provider.of<ApplicationProvider>(context, listen: false)
              .phoneNumber)
          .update({
        'email': emailCtrl.text,
        'name': ownernameCtrl.text,
        'photo_url': uploadedFile,
        'firstName': shopnameCtrl.text
      });
    } else {
      Scaffold.of(ctx)
          .showSnackBar(SnackBar(content: Text('Cannot Upload Profile')));
    }

    /*print(uploadFuture);
    print(uploadFuture.runtimeType);*/
  }

  ApplicationProvider getProvider() {
    return Provider.of<ApplicationProvider>(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Builder(builder: (ctx) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Colors.white,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               
                GestureDetector(
                  onTap: _getImage,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width ,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(10),
                            border: Border.all(
                                width: 4,
                                color: Theme.of(context)
                                    .scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            // shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: _imageFile != null
                                    ? FileImage(_imageFile!) as ImageProvider
                                    : NetworkImage(
                                       getProvider().shopDetails['photo_url'] !=null &&  getProvider().shopDetails['photo_url'] !=""?getProvider().shopDetails['photo_url']:
                                        "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                      )
                                      )),
                      ),
                      Positioned(
                          bottom: -2,
                          right: -2,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.green,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 35.0),
                  child: TextField(
                    controller: shopnameCtrl,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: 'Shop Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Eg. John',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black.withOpacity(0.4),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 35.0),
                  child: TextField(
                    controller: ownernameCtrl,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: 'Owner name',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Eg. Doe',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black.withOpacity(0.4),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 35.0),
                  child: TextField(
                    controller: phoneCtrl,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: 'Phone',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Eg. 0541000000',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black.withOpacity(0.4),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 35.0),
                  child: TextField(
                    controller: emailCtrl,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: 'Email',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Eg. barber@shop.com',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black.withOpacity(0.4),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 35.0),
                  child: TextField(
                    controller: gpsCtrl,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: 'Location',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Eg. WS-100-1000 Kentinkrono ABC Blcok',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black.withOpacity(0.4),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40,vertical:10),
                        primary: Colors.green,
                        shape: StadiumBorder()
                      ),
                      onPressed: () {
                        uploadImageToFirebase(ctx);
                      },
                      child: const Text('Update')),
                ),
              ],
            ),
          ),
        );
      }),
    ));
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            )),
      ),
    );
  }
}
