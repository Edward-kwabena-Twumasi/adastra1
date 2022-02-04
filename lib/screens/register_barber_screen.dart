import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/newbarber/barber_main_screen.dart';

// import 'client_screen_with_drawer.dart';

class BarberRegistrationScreen extends StatefulWidget {
  const BarberRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<BarberRegistrationScreen> createState() => _BarberRegistrationScreenState();
}

class _BarberRegistrationScreenState extends State<BarberRegistrationScreen> {
  TextEditingController firstNameCtrl = TextEditingController();
    TextEditingController secondNameCtrl = TextEditingController();

  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController shopCodeCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  //bool er1 = false, er2 = false;
  List<String> sexes = ['M', 'F'];
  String? sex = '-1';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final appProv= Provider.of<ApplicationProvider>(context,listen:false);
    print(appProv.phoneNumber);

    return Builder(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Register as a Barber',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'First Name is Required';
                            }
                            return null;
                          },
                          controller: firstNameCtrl,
                          keyboardType: TextInputType.text,
                          decoration:  InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'First name',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Eg. John',
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
                              return 'Last Name is Required';
                            }
                            return null;
                          },
                          controller: secondNameCtrl,
                          keyboardType: TextInputType.text,
                          decoration:  InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Last name',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Eg. Doe',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.4),
                    ))
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                  title: const Text('Male'),
                                  value: sexes.first,
                                  subtitle: const Text('Sex'),
                                  groupValue: sex,
                                  activeColor: Colors.black,
                                  onChanged: (value) =>
                                      setState(() => sex = value)),
                            ),
                            Expanded(
                                child: RadioListTile<String>(
                                    title: const Text('Female'),
                                    value: sexes.last,
                                    activeColor: Colors.black,
                                    subtitle: const Text('Sex'),
                                    groupValue: sex,
                                    onChanged: (value) =>
                                        setState(() => sex = value)))
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone Number is Required';
                            }
                            return null;
                          },
                          controller: phoneNumberCtrl,
                          keyboardType: TextInputType.phone,
                          decoration:  InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Phone number',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Eg. 123xxxxxxx',
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
                              return 'Your Email is required';
                            }
                            return null;
                          },
                          controller: emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email'),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          
                          controller: shopCodeCtrl,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                    prefixIcon: Icon(Icons.code),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Shop code',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: '123456',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.4),
                    ))
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
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate() ) {
                          if(sex!='-1'){
                            FirebaseFirestore.instance
                                .collection("barbers")
                                .doc(appProv.phoneNumber)
                                .set({
                              "uid": appProv.phoneNumber,
                              "email": emailCtrl.text,
                              "phone": phoneNumberCtrl.text,
                              "sex": sex,
                              "name": firstNameCtrl.text+" "+secondNameCtrl.text,
                              "photo_url": "",
                              "shop_affiliation":"none"
                            }).then((value) {
                              print("Client Account Created Successfully");
                              FirebaseFirestore.instance
                                  .collection("registry")
                                  .doc(appProv.phoneNumber)
                                  .set({
                                "uid":
                                appProv.phoneNumber,
                                "type": "barber"
                              }).then((value) => {

                                print('Client Created and Registered Successfully'),
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Client Created and Registered Successfully')),
                                ),
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(
                                        builder: (context) {
                                          return BarberMainScreen();
                                        },), (route) => false)
                              })
                                  .catchError((error) {
                                print(error.toString());
                              });
                            }).catchError((error) {
                              print(error.toString());
                            });

                           /* ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );*/
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Sex is Required')),
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
                    label: const Text('Register'),
                    icon: const Icon(Icons.person_add_alt_1),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}

// class CustomTextBox extends StatelessWidget {

//   CustomTextBox({
//     Key? key,
//     required this.type,
//     required this.hint, required this.controller,
//   }) : super(key: key);

//   final TextEditingController controller;
//   final TextInputType type;
//   final String hint;

//   @override
//   Widget build(BuildContext context) {
//     return const TextField(
//       keyboardType: ,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: '',
//         labelStyle: TextStyle( color: Colors.blue,),
//       ),
//     );
//   }
// }
