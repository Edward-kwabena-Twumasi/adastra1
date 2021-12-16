import 'package:flutter/material.dart';
// import 'package:thecut/screens/login_screen.dart';
import 'package:thecut/verify_phone_screen.dart';

class SignInOptionScreen extends StatelessWidget {
  const SignInOptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //parent stack
        body: Stack(
      children: [
        //botttome container containing a full
        //width image
        Container(
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/splash-cut.png",
                  ),
                  fit: BoxFit.cover)),
        ),
        //overlayed container with opacity
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          colors: [Colors.pink, Colors.indigo],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight),
                    ),
                    child: Icon(
                      Icons.cut_rounded,
                      color: Colors.white,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text("Book appointment with Salon Barber shop and more",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 20,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          onPrimary: Colors.white,
                          shadowColor: Colors.red,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        //_displayTextInputDialog(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VerifyPhoneScreen()),
                        );
                      },
                      icon: const Icon(Icons.phone_android),
                      label: const Text('Sign in with phone')),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
