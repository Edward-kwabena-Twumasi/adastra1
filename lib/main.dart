import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';

// import 'package:thecut/screens/auth_screen.dart';
import 'package:thecut/screens/splash_screen.dart';
import 'package:thecut/screens/verify_registry_futurebuilder.dart';
import 'package:thecut/sign_in_option_screen.dart';
// Import the generated file
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ApplicationProvider(),
        child: MaterialApp(
          title: 'theCut',
          theme: ThemeData(
              primarySwatch: Colors.green,
              fontFamily: 'Kuro',
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black)),
          home: AnimatedSplashScreen(
            splashIconSize: 120.0,
            duration: 4000,
            nextScreen: const HomePage(),
            splash: Splash(),
            splashTransition: SplashTransition.slideTransition,
            backgroundColor: Colors.black,
          ),
          debugShowCheckedModeBanner: false,
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool register = true;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if(register){
    //   return SignInOptionScreen();
    // }else{
    //   return VerifyRegistryBuilderScreen();
    // }
    final phoneFuture = Provider.of<ApplicationProvider>(context, listen: false)
        .loadPhoneNumberFromPrefs();
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return Container(
            color: Colors.white,
            child: (Center(
                child: SpinKitPouringHourGlassRefined(
              color: Colors.black,
            ))),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.hasData) {
            print("Has Data");
            print(snapshot.data!);
            return VerifyRegistryBuilderScreen();
          }
          return SignInOptionScreen();
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
      future: phoneFuture,
    );
  }
}
