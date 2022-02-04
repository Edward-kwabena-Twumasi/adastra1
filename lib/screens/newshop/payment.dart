//Appointment info and confirmation.show appointment info
// together with shop info and ask for payment option

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/NewClient/client_main_screen.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage(
      {Key? key,
      required this.services,
      required this.datetime,
      required this.shopId,
      required this.shopName
      })
      : super(key: key);
  final List<Map<String, dynamic>> services;
  final DateTime datetime;
  final String shopId;
  final String shopName;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  ApplicationProvider provider() {
    return Provider.of<ApplicationProvider>(context, listen: false);
  }
  double total = 0;
  int duration = 0;
  String phone = "";

  void initState() {
    super.initState();
    setState(() {
      phone =
          Provider.of<ApplicationProvider>(context, listen: false).phoneNumber!;
    });
    for (var ob in widget.services) {
      setState(() {
        total += double.parse(ob["price"].toString());
        duration += int.parse(ob["duration"].toString());
      });
    }
  }

  BoxDecoration unselected = BoxDecoration();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text("Pay", style: TextStyle(color: Colors.black)),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ))),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: ListTile(
                subtitle: RichText(
                    text: TextSpan(children: [
                  // TextSpan(text: "Booking at  ",style: TextStyle(
                  //     fontSize: 17,color:Colors.black
                  // ) ),
                  TextSpan(
                      text: DateFormat(' dd MMM. yyyy, EEE   hh:mm aaa')
                          .format(widget.datetime)
                          .toString(),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ))
                ])),
                title: Text(
                 widget.shopName,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 5, top: 10),
            child: Text("Selected services"),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.services.length,
              itemBuilder: (itemBuilder, idx) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/cutcut.png"),
                                    fit: BoxFit.cover)),
                            width: 60,
                            height: 60,
                          )),
                      title: Row(
                        children: [
                          Text(widget.services[idx]["name"]),
                          Spacer(),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: widget.services[idx]["price"].toString(),
                                style: TextStyle(
                                    fontSize: 19, color: Colors.black)),
                            TextSpan(
                                text: " GHS",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black))
                          ])),
                        ],
                      ),
                      subtitle: Text(
                          widget.services[idx]["duration"].toString() +
                              " mins"),
                    ),
                  ),
                );
              })
// }),
//
          ,
          Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text("Total  ",
                              style: TextStyle(color: Colors.blue)),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: total.toString(),
                              style:
                                  TextStyle(fontSize: 19, color: Colors.black)),
                          TextSpan(
                              text: " GHS",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black))
                        ])),
                      ])),
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text("Duration",
                              style: TextStyle(color: Colors.blue)),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: duration.toString(),
                              style:
                                  TextStyle(fontSize: 19, color: Colors.black)),
                          TextSpan(
                              text: " mins",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black))
                        ])),
                      ])),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 5),
            child: Row(
              children: [
                Text("Payment methods"),
                Spacer(),
                TextButton(onPressed: () {}, child: Text("Add more cards"))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (build) {
                      return AlertDialog(
                        actionsPadding: EdgeInsets.zero,
                        content: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Confirm payment of  GHS ",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black)),
                          TextSpan(
                              text: total.toString(),
                              style:
                                  TextStyle(fontSize: 17, color: Colors.blue))
                        ])),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(build);
                              },
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("appointments")
                                    .add({
                                  "barber_id": "",
                                  "client_id": phone,
                                  "client_name":provider().userDetails["firstName"],
                                  "comment": "",
                                  "date": widget.datetime,
                                  "duration": duration,
                                  "payment": {
                                    "amount": total,
                                    "date": DateTime.now(),
                                    "status": "DONE"
                                  },
                                  "rate": 0,
                                  "service_status": "PENDING",
                                  "services": [],
                                  "shop_id": widget.shopId,
                                  "shop_name":widget.shopName,
                                   "shop_watched": false,
                                  "client_watched":true,
                                }).then((value) { 
                                  Navigator.pop(build);

                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (builder) {
                                        return ClientMainScreen();
                                      }), (route) => false);

                                });
                              },
                              child: Text("Confirm"))
                        ],
                      );
                    });
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 7,
                color: Colors.white,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 70,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/insta.png"),
                                      fit: BoxFit.cover)),
                              width: 70,
                              height: 70,
                            )),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 12.0, top: 2),
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: total.toString(),
                                    style: TextStyle(
                                        fontSize: 21, color: Colors.black)),
                                TextSpan(
                                    text: " GHS",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.black))
                              ])),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 12.0, top: 11),
                              child: Text(
                                phone,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
