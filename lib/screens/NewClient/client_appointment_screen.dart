//this page gives every information related to a clients appointment
import 'dart:async';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';

class ClientAppointments extends StatefulWidget {
  const ClientAppointments({Key? key}) : super(key: key);

  @override
  _ClientAppointmentsState createState() => _ClientAppointmentsState();
}

class _ClientAppointmentsState extends State<ClientAppointments> {
  late StreamSubscription appointmentSubscription;
  //List<String> titles = ["", "Payment", "Notifications", "History"];

List<Map<String,dynamic>> myappointments=[];
  int index = 0;
  bool showsearch = true;

  @override
  void initState() {
    super.initState();
    if(mounted){
      appointmentSubscription = Provider.of<ApplicationProvider>(context, listen: false).clientAppointments()
          .listen((event) {
        setState((){
          myappointments=[];
        });
        print(event.docs.length);

        for (var appointment in event.docs) {
          //print(oldStyle.data().runtimeType);
          print('HERE');

          setState(() {
            myappointments.add(appointment.data());
          });
        }

      });
    }


  }

  @override
  void dispose(){
    super.dispose();
    appointmentSubscription.cancel();
  }

  String getDateString(DateTime today,DateTime reference){
    int diff=DateTime(today.year,today.month,today.day).difference(DateTime(reference.year,reference.month,reference.day)).inDays;
    if(diff==0){
      return "TODAY";
    }else if(diff==-1){
      return "TOMORROW";
    }else if(diff==1){
      return "YESTERDAY";
    }else{
     return reference.toString().split(' ')[0] ;
    }
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
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
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
                itemCount: myappointments.length,
                itemBuilder: (context,index){
                DateTime today=DateTime.now();
                DateTime appointmentDay=myappointments[index]['date'].toDate();
                if(index==0){
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0,top: 5,bottom: 2),
                          child: Text(getDateString(today, appointmentDay),style: TextStyle(fontSize: 12),),
                        ),
                        AppointmentCard(context, myappointments[index]
                        )
                      ],
                    ),
                  );
                }else{
                  DateTime prev=myappointments[index-1]["date"].toDate();
                  if(getDateString(today, appointmentDay)==getDateString(today, prev)){
                   return AppointmentCard(context, myappointments[index]
                    );
                  }else{
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,top: 5,bottom: 2),
                            child: Text(getDateString(today, appointmentDay),style: TextStyle(fontSize: 12),),
                          ),
                          AppointmentCard(context, myappointments[index]
                          )
                        ],
                      ),
                    );
                  }
                }
                //Text(myappointments[index]["shop_id"],style:TextStyle(color: Colors.black),);
            }),
          )
        ],
      ),
    );
  }
}
//appointment card edited
Widget AppointmentCard(BuildContext context, Map<String, dynamic> appointment) {
  Widget badge = Badge();
  if (appointment["service_status"] == "PENDING") {
    badge = Badge(
      toAnimate: false,
      badgeColor: Colors.amber.shade50,
      shape: BadgeShape.square,
      borderRadius: BorderRadius.circular(10),
      badgeContent:Text(appointment["service_status"],style: TextStyle(color: Colors.amber,fontSize: 10,fontWeight:FontWeight.bold))
    );
  } else if (appointment["service_status"] == "CONFIRMED") {
    badge = Badge(
      toAnimate: false,
      badgeColor: Colors.green.shade50,
      shape: BadgeShape.square,
      borderRadius: BorderRadius.circular(10),
      badgeContent:Text(appointment["service_status"],style: TextStyle(color: Colors.green,fontSize: 10,fontWeight:FontWeight.bold),)
    );
  } else  {
    badge = Badge(
      toAnimate: false,
      badgeColor: Colors.black.withOpacity(0.7),
      shape: BadgeShape.square,
      borderRadius: BorderRadius.circular(10),
      badgeContent:Text(appointment["service_status"],style: TextStyle(color: Colors.green,fontSize: 10,fontWeight:FontWeight.bold))
    );
  }

  return ListTile(
    tileColor: Colors.white,
    leading: CircleAvatar(
        backgroundColor: Colors.black54,
        child: Icon(Icons.notifications, color: Colors.white)),
    title: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Text(appointment["client_name"]),
    ),
    subtitle: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(DateFormat(' dd MMM.yyyy,- EEE hh:mm aaa')
            .format(appointment["date"].toDate())
            .split("-")[1])),
    trailing: badge,
  );
}