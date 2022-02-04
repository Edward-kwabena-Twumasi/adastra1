import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/NewClient/client_main_screen.dart';
// import 'package:thecut/screens/client_screen_with_drawer.dart';

class ClientRegistrationScreen extends StatefulWidget {
  const ClientRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<ClientRegistrationScreen> createState() =>
      _ClientRegistrationScreenState();
}

class _ClientRegistrationScreenState extends State<ClientRegistrationScreen> {
  TextEditingController lastName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();

  bool er1 = false, er2 = false;
  List<String> sexes = ['F', 'M'];
  String? sex = '-1';
  @override
void initState(){
  super.initState();
  final appProv = Provider.of<ApplicationProvider>(context,
      listen: false);
  phone.text=appProv.phoneNumber!;
}
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Register as a Client',
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
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Full Name is Required';
                            }
                            return null;
                          },
                          controller: firstName,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: 'First Name',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                              return 'Full Name is Required';
                            }
                            return null;
                          },
                          controller: lastName,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: 'Last Name',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: 'Eg. Backus',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black.withOpacity(0.4),
                              )),
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
                                  value: sexes.last,
                                  subtitle: const Text('Sex'),
                                  groupValue: sex,
                                  activeColor: Colors.black,
                                  onChanged: (value) =>
                                      setState(() => sex = value)),
                            ),
                            Expanded(
                                child: RadioListTile<String>(
                                    title: const Text('Female'),
                                    value: sexes.first,
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
                            } else if (value.length != 10) {
                              return 'Total Digits must be equal to 10';
                            }
                            return null;
                          },
                          controller: phone,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: 'Phone number',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                            controller: email,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                contentPadding: EdgeInsets.only(bottom: 3),
                                labelText: 'Your email',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Eg. you@gmil.com',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black.withOpacity(0.4),
                                ))),
                        const SizedBox(
                          height: 10.0,
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
                      final appProv = Provider.of<ApplicationProvider>(context,
                          listen: false);

                      if (_formKey.currentState!.validate()) {
                        if (sex != '-1') {
                          print(phone.text.length);
                          if (phone.text.length == 10) {
                            FirebaseFirestore.instance
                                .collection("clients")
                                .doc(appProv.phoneNumber)
                                .set({
                              "uid": appProv.phoneNumber,
                              "email": email.text,
                              "phone": phone.text,
                              "sex": sex,
                              "firstName": firstName.text,
                              "lastName": lastName.text,
                              "photo_url": "",
                              "favorites":[]
                            }).then((value) {
                              print("Client Account Created Successfully");
                              FirebaseFirestore.instance
                                  .collection("registry")
                                  .doc(appProv.phoneNumber)
                                  .set({
                                    "uid": appProv.phoneNumber,
                                    "type": "client"
                                  })
                                  .then((value) => {
                                        print(
                                            'Client Created and Registered Successfully'),
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Client Created and Registered Successfully')),
                                        ),
                                        Navigator.pushAndRemoveUntil(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ClientMainScreen();
                                        }), (route) => false)
                                      })
                                  .catchError((error) {
                                    print(error.toString());
                                  });
                            }).catchError((error) {
                              print(error.toString());
                            });
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Choose your sex')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('All Fields Are REQUIRED!!!')));
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
