//This page contains information
//relating to a client's profile

import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClientSaved extends StatefulWidget {
  const ClientSaved({Key? key}) : super(key: key);

  @override
  _ClientSavedState createState() => _ClientSavedState();
}

class _ClientSavedState extends State<ClientSaved> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
     
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 28
            ),
            child: Text("Saved shops",style:TextStyle(fontWeight:FontWeight.bold,fontSize: 20 )),
          ),
        ),
       Align(
          alignment: Alignment.center,
         child: SizedBox(
           height:150,
           width: 150,
           child: CircleAvatar(
             backgroundImage:AssetImage("images/empty.png")
           ),
         ),
       )
      ],
    ));
  }
}

