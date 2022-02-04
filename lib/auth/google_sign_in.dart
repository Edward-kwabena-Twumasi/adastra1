import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  //final googleSignIn = GoogleSignIn();
  //  GoogleSignInAccount? _user;
  // //
  //  GoogleSignInAccount? get user => _user;
  User? _user;
  //
  User? get user => _user;

  // Future googleLogin() async {
  //   final googleUser = await googleSignIn.signIn();
  //   if (googleUser == null) return;
  //   _user = googleUser;
  //
  //   final googleAuth = await googleUser.authentication;
  //
  //   final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  //
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //   notifyListeners();
  // }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final UserCredential authResult =await FirebaseAuth.instance.signInWithCredential(credential);
    // final User? user =
    _user=authResult.user;
    // Once signed in, return the UserCredential
    notifyListeners();
  }
}
