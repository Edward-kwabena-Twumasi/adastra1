import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:overlapping_time/overlapping_time.dart';

class Endorse extends StatefulWidget {
  const Endorse({Key? key, required this.aptId, required this.appointment})
      : super(key: key);
  final String aptId;
  final Map<String, dynamic> appointment;

  @override
  _EndorseState createState() => _EndorseState();
}

class _EndorseState extends State<Endorse> {
  List<Map<String, dynamic>> aptsToday = [];
  late StreamSubscription appointmentsSubscription;

  ApplicationProvider provider() {
    return Provider.of<ApplicationProvider>(context, listen: false);
  }

  late StreamSubscription barberSubscription;
  int exclusive = -1;
  Map<String, dynamic> selectedBarber = {};
  // List<Map<String, dynamic>> barbers = [];
  List<DateTimeRange> timeRanges = [];
  List<String> busyBarbers = ["0240464411"];

  DateTimeRange dtRange(Map<String, dynamic> data) {
    return DateTimeRange(
        start: data["date"].toDate(),
        end: data["date"]
            .toDate()
            .add(Duration(minutes: int.parse(data["duration"].toString()))));
  }

  void findBusyBarbers(
      Map<String, dynamic> incoming, Map<String, dynamic> confirmed) {
    List<DateTimeRange> ranges = [dtRange(incoming), dtRange(confirmed)];

    final Map<int, List<ComparingResult>> searchResults =
        findOverlap(ranges: ranges);

    if (searchResults[2]!.isEmpty) {
      print('Appointment Possible');
    } else {
      print('Duration Occupied, Barber Booked');
      setState(() {
        busyBarbers.add(confirmed["barber_id"]);
      });
      print(busyBarbers);
    }
  }

  Future<Response> sendAcceptanceMessage() {
    return post(
      Uri.parse(
          'https://api.mnotify.com/api/sms/quick?key=1l6ZpZ0eKUm60uwg5CPUBv6AIVfwI5CKqJKQIK5tErzEW'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "recipient": ["0552489602", "0501651045"],
        "sender": "CRUSH",
        "message":
            "APPOINTMENT REQUESTION COMPLETED.... WE HOPE TO SEE YOU AROUND",
        "is_schedule": false,
        "schedule_date": ""
      }),
    );
  }

  //bool searching=false;
  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    DateTime temp = now.add(Duration(days: 1));
    DateTime tomorrow = DateTime(temp.year, temp.month, temp.day, 0, 0, 0);

    appointmentsSubscription =
        provider().confirmedAppointments(tomorrow).listen((event) {
      setState(() {
        //aptsToday = [];
        List<Map<String, dynamic>> tempAppointmentHolder = [];
        event.docs.forEach((element) {
          tempAppointmentHolder.add(element.data());
          // print(element.data());
        });
        aptsToday = tempAppointmentHolder;
      });

      if (aptsToday.length > 0) {
        aptsToday.forEach((element) {
          findBusyBarbers(widget.appointment, element);
        });
        print(busyBarbers);
      }

      print(aptsToday.length.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    appointmentsSubscription.cancel();
    //barberSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Endorse", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0, left: 8),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: widget.appointment["client_name"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                )),
                          ])),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: "Date         ",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          TextSpan(
                              style: TextStyle(color: Colors.black),
                              text: widget.appointment["date"]
                                  .toDate()
                                  .toString())
                        ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                                children: [
                              TextSpan(text: "Charge      "),
                              TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  text: widget.appointment["payment"]["amount"]
                                      .toString())
                            ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                                children: [
                              TextSpan(text: "Time         "),
                              TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  text: widget.appointment["date"]
                                      .toDate()
                                      .toString())
                            ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                                children: [
                              TextSpan(text: "Duration   "),
                              TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  text:
                                      widget.appointment["duration"].toString())
                            ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                                children: [
                              TextSpan(text: "Barber      "),
                              TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  text: selectedBarber["name"] ?? "-")
                            ])),
                      ),
                    ],
                  ),
                )),
          ),

          //dummy code fot checking time overlap

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Available barbers ",
                  style: TextStyle(color: Colors.black, fontSize: 14)),
            ])),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("barbers")
                  .where("uid", whereNotIn: busyBarbers)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SpinKitCircle(
                    color: Colors.white,
                  );
                } else if (snapshot.hasError) {
                  return Text("Oops an error occured");
                }

                /*  print(Map.from(snapshot.data!.docs[0].data() as Map)['sex']);

                return Text('Cancel suffering');*/

                return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> itemData = Map.from(
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>);
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          tileColor: exclusive == index
                              ? Colors.black.withOpacity(0.2)
                              : Colors.white,
                          onTap: () {
                            exclusive == index
                                ? setState(() {
                                    exclusive = -1;
                                    selectedBarber = {};
                                  })
                                : setState(() {
                                    exclusive = index;
                                    selectedBarber = itemData;
                                  });
                          },
                          title: Text(itemData['name']),
                          leading: Icon(Icons.person, color: Colors.black),
                          trailing: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "3",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 22,
                                )),
                            WidgetSpan(
                                child:
                                    Icon(Icons.cut_sharp, color: Colors.black))
                          ])),
                        ),
                      );
                    });
              }),
          Spacer(),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: exclusive == -1
                        ? null
                        : () {
                            sendAcceptanceMessage().then((value) {
                              print(value.body);
                            });
                            FirebaseFirestore.instance
                                .collection("appointments")
                                .doc(widget.aptId)
                                .update({
                              "client_watched": false,
                              "service_status": "CONFIRMED",
                              "barber_id": selectedBarber["uid"],
                            });
                          },
                    child: Text("Accept"),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
