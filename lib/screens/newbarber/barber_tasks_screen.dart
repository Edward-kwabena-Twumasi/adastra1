import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';


class BarberTaskScreen extends StatefulWidget {
  const BarberTaskScreen({Key? key}) : super(key: key);

  @override
  _BarberTaskScreenState createState() => _BarberTaskScreenState();
}

class _BarberTaskScreenState extends State<BarberTaskScreen> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> barberApts = [];

  late StreamSubscription barberAptsSubscription;
  ApplicationProvider provider() {
    return Provider.of<ApplicationProvider>(context, listen: false);
  }

  void initState() {
    super.initState();
    barberAptsSubscription =
        Provider.of<ApplicationProvider>(context, listen: false)
            .appointmentsForBarber().listen((event) {
              barberApts=[];
              setState(() {
                event.docs.forEach((element) {
                  barberApts.add(element);
                });
              });
        });

  }
  @override
  void dispose(){
    super.dispose();
    barberAptsSubscription.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
      
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     height: 100,
      //     decoration:BoxDecoration(
      //       color:Colors.white,
      //       borderRadius: BorderRadius.circular(10),
      //       boxShadow:[
      //         BoxShadow(
      //           color: Colors.grey
      //         )
      //       ]
      //     ),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             RichText(text: TextSpan(children: [
      //       TextSpan(text: "2 ",style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 16,fontWeight:FontWeight.bold)),
      //       //TextSpan(text: "Reminders ",style: TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 14)),
      //       WidgetSpan(child: Icon(FontAwesomeIcons.clock,color:Colors.black))
      //     ])),
      //     Padding(
      //       padding: const EdgeInsets.all(4.0),
      //       child: Text("Pending"),
      //     )
      //           ],
      //         ),
      //     Column(
      //        mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         RichText(text: TextSpan(children: [
      //           TextSpan(text: barberApts.length.toString(),style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 16,fontWeight:FontWeight.bold)),
      //           //TextSpan(text: "Notifications ",style: TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 14)),
      //           WidgetSpan(child: Icon(FontAwesomeIcons.bell,color:Colors.black))
      //         ])),
      //           Padding(
      //             padding: const EdgeInsets.all(4.0),
      //             child: Text("New"),
      //           )
      //       ],
      //     ),
      //     Column(
      //        mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         RichText(text: TextSpan(children: [
      //           TextSpan(text: "4 ",style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 16,fontWeight:FontWeight.bold)),
      //           //TextSpan(text: "Done",style: TextStyle(color: Colors.black.withOpacity(0.9),fontSize: 14)),
      //           //WidgetSpan(child: Icon(FontAwesomeIcons.whatsapp,color:Colors.white))
      //         ])),
      //           Padding(
      //             padding: const EdgeInsets.all(4.0),
      //             child: Text("Done"),
      //           )
      //       ],
      //     ),
      //       ],
      //     )
      //   ),
      // ),
        Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Timeline',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
              ],
            ),
          ),
        ),
      //Secopnd child contaioner

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text("Timeline",style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(),
             TextButton(onPressed: (){}, child: Text("See all"))
          ],
        ),
      ),
    Expanded(
      child: Stack(
        children:[

        Positioned(
          top: 35,
          left:20 ,
          child: Container(
          width: 2,
          height: MediaQuery.of(context).size.height-110,
           decoration:BoxDecoration(
              color:Colors.black54,

            ),
        )),
        Positioned(

          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.transparent
            ),
            child:
                ListView.builder(
                shrinkWrap: true,
                itemCount:barberApts.length,
                itemBuilder: (Buildcontext,index){
              return TimeLine(barberApts[index].data()["client_name"], barberApts[index].data()["date"].toDate().toString(),context);
            }
            ),

          ),
        ),
          Positioned(
            left: 5,
            top: 0,
            child: Container(
                height:40,
                width:30,
                decoration:BoxDecoration(
                    color:Colors.black,
                    borderRadius:BorderRadius.circular(10)
                ),
                child:Center(child: Text(barberApts.length.toString(),style:TextStyle(color:Colors.white)))
            ),
          ),

        ]),
    ),
     

    ]);
  }
}

Widget TimeLine(String time,String name,BuildContext context ) {
  return Container(
    padding: EdgeInsets.symmetric(
     horizontal:3,
     vertical:15
    ),
    decoration: BoxDecoration(
     
     boxShadow:[
        BoxShadow(
                            color: Colors.transparent,
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: Offset.fromDirection(2.0))
     ]
    ),
    child: Row(children: [
                      Container(
                        padding:EdgeInsets.symmetric(vertical:10,horizontal:0),
                        height:17,
                        width:17,
                        decoration:BoxDecoration(
                          shape:BoxShape.circle,
 color:Colors.black.withOpacity(0.7)
                        )
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        height:1,
                        width:26,
                        decoration:BoxDecoration(
 color:Colors.black.withOpacity(0.4)
                        )
                      ),
                     Expanded(
                       child: Card(
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(8)
                         ),
                         elevation: 5.0,
                         child: Container(
                           padding:EdgeInsets.only(
                             left: 9,
                             bottom: 10,
                             top: 4

                           ),
                          decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(10),
                            color:Colors.white.withOpacity(0.2),

                          ),
                           //width: MediaQuery.of(context).size.width-100,
                           child: ListTile(
                              contentPadding: EdgeInsets.zero,
                            title: Text(name),
                            subtitle: Text(time)
                           ),
                         ),
                       ),
                     )
                     //TextSpan(text: date,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight:FontWeight.bold))
                     ,
                   ]),
   
  )
  ;
}