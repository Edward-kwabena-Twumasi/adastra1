//This page contains information
//relating to a client's profile

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/newshop/shop_about_screen.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClientSaved extends StatefulWidget {
  const ClientSaved({Key? key}) : super(key: key);

  @override
  _ClientSavedState createState() => _ClientSavedState();
}

class _ClientSavedState extends State<ClientSaved> {
  ApplicationProvider getProvider(){
    return Provider.of<ApplicationProvider>(context,listen: true);
  }
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Center(
          child: Column(
     mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu,color: Colors.white,),
                  Text('Appointments',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                  Text('   ')
                ],
              ),
            ),
          ),
          getProvider().userDetails["favorites"].length<1? SizedBox(
           height:100,
           width: 100,
           child: CircleAvatar(
             backgroundImage:AssetImage("images/empty.png")
           ),
       ):ListView.builder(
            shrinkWrap: true,
              itemCount: getProvider().userDetails["favorites"].length,
              itemBuilder: (context,index){
           return ListTile(
             onTap: (){
               Navigator.push(context,
                   MaterialPageRoute(builder: (ctx) {
                     return AboutShop(shopId: getProvider().userDetails["favorites"][index]["shop_id"]);
                   }));
             }
             ,
             trailing: IconButton(onPressed: (){}, icon: Icon(Icons.cancel,color: Colors.black,)),
             title: Text(getProvider().userDetails["favorites"][index]["name"]),
           );
          })
      ],
    ),
        ));
  }
}

