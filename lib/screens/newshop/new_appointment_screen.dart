import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/newshop/endorse_appointment.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> appointments = [];

  late StreamSubscription appointmentsSubscription;
  ApplicationProvider provider() {
    return Provider.of<ApplicationProvider>(context, listen: false);
  }

  void initState() {
    super.initState();
    setState(() {
      appointmentsSubscription =
          Provider.of<ApplicationProvider>(context, listen: false)
              .pendingRequests()
              .listen((event) {
        appointments = [];
        setState(() {
          event.docs.forEach((element) {
            if(element.exists){
 FirebaseFirestore.instance
                .collection("appointments")
                .doc(element.id)
                .update({"shop_watched": true});
            }
           
            appointments.add(element);
          });
        });

        print(appointments.length.toString());
      });
    });

    // startTimer();
  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();

    appointmentsSubscription.cancel();
  }

  Map<String, dynamic> requestObject = {
    "img": "images/nicesalon.jpg",
    "name": "Kay",
    "date": "20th Oct",
    "time": "12:00 pm",
    "message": "Hello"
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Pending Requests',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              (appointments.length > 0)
                  ? Container(
                      height: 155,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: appointments.length,
                          itemBuilder: (context, i) => Request(
                              (appointments.elementAt(i)).data(),
                              appointments.elementAt(i).id,
                              context)),
                    )
                  : Text('No Request Pending'),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Confirmed Appointments',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("appointments")
                  .where("service_status", isEqualTo: "CONFIRMED")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting||snapshot.connectionState == ConnectionState.waiting
                
                 ) {
                  return SpinKitCircle(
                    color: Colors.white,
                  );
                } else if (snapshot.hasError) {
                  return Text("Oops an error occured");
                }

                return snapshot.data!.docs.length > 0 ?Expanded(                
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> itemData = Map.from(
                            snapshot.data!.docs[index].data()
                                as Map<String, dynamic>);
                        return appointmentCard(
                            itemData["date"].toDate().toString(),
                           "images/lovecut.jpg0",
                            itemData["client_name"],
                           );
                      }),
                ):Center(child: Text("0  appointments",style:TextStyle(color:Colors.black)));
              }),

          // Expanded(
          //   child: ListView.builder(
          //       padding: EdgeInsets.zero,
          //       shrinkWrap: true,
          //       itemCount: 7,
          //       itemBuilder: (context, i) => appointmentCard(
          //           requestObject["date"],
          //           requestObject["time"],
          //           requestObject["img"],
          //           requestObject["name"],
          //           context)),
          // ),
        ],
      ),
    );
  }

  Widget Request(
      Map<String, dynamic> appointment, String aptid, BuildContext context) {
    print(appointment["date"].toDate().toString());
    return SizedBox(
      height: 140,
      width: MediaQuery.of(context).size.width - 36,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: ListTile(
                leading: FaIcon(FontAwesomeIcons.clock, color: Colors.white),
                title: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Text(
                          DateFormat(' dd MMM. yyyy,    hh:mm aaa')
                              .format(appointment["date"].toDate()),
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  leading: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.amber, width: 7)),
                      child: CircleAvatar(
                        backgroundImage: AssetImage("images/salon.jpg"),
                      )),
                  title: Text(appointment["client_name"]),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.info, color: Colors.blue)),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child:
                    ButtonBar(alignment: MainAxisAlignment.center, children: [
                  ElevatedButton(
                      onPressed: () {
                        //provider().setUserAppointmentDetails(appointment);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) {
                          return Endorse(
                            aptId: aptid,
                            appointment: appointment,
                          );
                        }));
                      },
                      child: Text("Assign"),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 25, right: 25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          primary: Colors.blue,
                          textStyle: TextStyle(color: Colors.white))),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Decline",
                        style: TextStyle(color: Colors.blue),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, left: 15, right: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          primary: Colors.grey[200],
                          textStyle: TextStyle(color: Colors.blue))),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget appointmentCard(
    String date, String img, String name) {
  return ListTile(
    //tileColor: Colors.blue,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    leading: CircleAvatar(
      backgroundImage: AssetImage(img),
    ),
    title: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(name, style: TextStyle(color: Colors.black)),
    ),
    subtitle: Padding(
      padding: const EdgeInsets.all(2.0),
      child:
          Text(date, style: TextStyle(color: Colors.black))
          
       
    ),
  );
}
