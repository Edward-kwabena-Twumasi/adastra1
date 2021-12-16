import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:thecut/onBoarding_one/onboarding_one.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/updated_screens/NewClient/client_main_screen.dart';
import 'package:thecut/screens/updated_screens/newbarber/barber_main_screen.dart';
import 'package:thecut/screens/updated_screens/newshop/shop_main_screen.dart';

class VerifyRegistryBuilderScreen extends StatefulWidget {
  const VerifyRegistryBuilderScreen({Key? key}) : super(key: key);

  @override
  _VerifyRegistryBuilderScreenState createState() => _VerifyRegistryBuilderScreenState();
}

class _VerifyRegistryBuilderScreenState extends State<VerifyRegistryBuilderScreen> {
  CollectionReference registry = FirebaseFirestore.instance.collection('registry');


  @override
  Widget build(BuildContext context) {

    final appProv=Provider.of<ApplicationProvider>(context,listen:false);
    return FutureBuilder<DocumentSnapshot>(
      future: registry.doc(appProv.phoneNumber).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Material(
            child: Center(
              child: Text('Oops ,an error occured'),
            ),
          );
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return OnBoardingOne();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          registry.doc(appProv.phoneNumber).get().then((value){
            //print(value.data() as Map<String,dynamic>);
            Map<String,dynamic> userRegistry=value.data() as Map<String,dynamic>;
            if(userRegistry['type']=='shop'){
              print('Navigate to SHOP PAGE');
              //return Container(child: Text('SHOP PAGE'),);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ShopMainScreen()));
            }else if(userRegistry['type']=='client'){
              print('Navigate to CLIENT PAGE');
              //return ClientMainScreen();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ClientMainScreen()));
            }else{
              print('Navigate to BARBER PAGE');
              //return BarberMainScreen();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => BarberMainScreen()));
            }
          });
          return Center(
              child: SpinKitPouringHourGlassRefined(
                color: Colors.black,
              )
          );
        }
        return Center(
            child: SpinKitPouringHourGlassRefined(
              color: Colors.black,
            )
        );
      },
    );
  }
}
