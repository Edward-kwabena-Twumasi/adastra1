import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Icon(Icons.cut),
          Image.asset('images/logo.png',fit: BoxFit.fitWidth,height: 100,),
        ],
      ),
    );
  }
}
