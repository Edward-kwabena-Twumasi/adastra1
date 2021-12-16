// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB5R8BMzVv6ocmULQDD0NS0hKnYmLMyT2o',
    appId: '1:952706094747:web:55e8ae70192e6b6f76983e',
    messagingSenderId: '952706094747',
    projectId: 'phonea-auth',
    authDomain: 'phonea-auth.firebaseapp.com',
    storageBucket: 'phonea-auth.appspot.com',
    measurementId: 'G-4RGR87S9RF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBADEzhLiKkCGUfvRAx320tzaIliRJEGdc',
    appId: '1:952706094747:android:285f1d36f9de3e0a76983e',
    messagingSenderId: '952706094747',
    projectId: 'phonea-auth',
    storageBucket: 'phonea-auth.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB3GiNluYVTHC-GCmeiad1cPsw7esi8Y00',
    appId: '1:952706094747:ios:65f3be35b1bfbbff76983e',
    messagingSenderId: '952706094747',
    projectId: 'phonea-auth',
    storageBucket: 'phonea-auth.appspot.com',
    androidClientId: '952706094747-5pu9tm4fs0p9jc2o665p70rmeejkuhaf.apps.googleusercontent.com',
    iosClientId: '952706094747-6sbi13pm85fk6c6bbm3k7m9ft4br7rrc.apps.googleusercontent.com',
    iosBundleId: 'com.example.thecut',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB3GiNluYVTHC-GCmeiad1cPsw7esi8Y00',
    appId: '1:952706094747:ios:65f3be35b1bfbbff76983e',
    messagingSenderId: '952706094747',
    projectId: 'phonea-auth',
    storageBucket: 'phonea-auth.appspot.com',
    androidClientId: '952706094747-5pu9tm4fs0p9jc2o665p70rmeejkuhaf.apps.googleusercontent.com',
    iosClientId: '952706094747-6sbi13pm85fk6c6bbm3k7m9ft4br7rrc.apps.googleusercontent.com',
    iosBundleId: 'com.example.thecut',
  );
}