
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thecut/otp_new.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/verify_registry_futurebuilder.dart';


class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({Key? key}) : super(key: key);

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 70,),
                    const Center(
                        child: Text(
                          'Verify your',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                        )),
                    const Center(
                        child: Text(
                          'Phone Number',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        )),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                          "We'll be sending to your phone number an SMS with an OTP message."),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        controller: _controller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone Number is required';
                          } else if (value.length < 10) {
                            return 'Number must equal 10 digits';
                          }
                          return null;
                        },
                        autofocus: false,
                        maxLength: 10,
                        decoration: InputDecoration(
                          contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "0xxxxxxxxxx",
                          /*labelText: 'Phone Number',
                      labelStyle: TextStyle(color: Colors.black),*/
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {
                              setState(() {
                                _controller.text="";
                              });
                            },
                          ),
                          // enabledBorder: const OutlineInputBorder(
                          //   borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                          // ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 5.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          primary: Colors.deepOrange,
                          onPrimary: Colors.white,
                          shadowColor: Colors.deepPurple,
                          elevation: 5,
                          shape:  RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17.0)
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final appProv=Provider.of<ApplicationProvider>(context,listen:false);
                            print("OTP_NEW PAGE");
                           // print(widget.phone.runtimeType);
                            await appProv.setPhoneNumber(_controller.text);


                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) =>VerifyRegistryBuilderScreen()/*OTPScreen(phone:_controller.text)*/
                            ));
                          }
                        },
                        icon: const Icon(Icons.phone_android),
                        label: const Text('Sign in with phone')),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}