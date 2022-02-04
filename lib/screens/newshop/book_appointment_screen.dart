import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
//import 'package:thecut/screens/newshop/appointment.dart';
import 'package:thecut/screens/newshop/payment.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

DateTime selectedtime = DateTime.now();

class BookAppointment extends StatefulWidget {
  final String shopId;
  final String shopName;

  const BookAppointment({Key? key, required this.shopId,required this.shopName}) : super(key: key);

  @override
  BookAppointmentState createState() => BookAppointmentState();
}

class BookAppointmentState extends State<BookAppointment> {
  bool selected = false;

  int total = 0;
  List servicechosen = [false, false, false];

  List<Map<String, dynamic>> prefServices = [];
  List<Map<String, dynamic>> services = [
    /* {"id": "service1", "price": 500, "name": 'Down Cut'},
    {"id": "service2", "price": 400, "name": 'Upper Cut'}*/
  ];

  //List<Appointment> listOfAppointments = <Appointment>[];
  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();
  late StreamSubscription shopProductSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      shopProductSubscription = FirebaseFirestore.instance
          .collection('shop_styles')
          .doc(widget.shopId)
          .collection('style')
          .snapshots()
          .listen((event) {
        setState(() {
          services = [];
        });
        print(event.docs.length);

        for (var style in event.docs) {
          //print(oldStyle.data().runtimeType);
          print('HERE');
          print(style.data());
          setState(() {
            services.add(style.data());
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          /*centerTitle: true,*/
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text("Book Appointment",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ))),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/nicesalon.jpg"),
                      fit: BoxFit.cover,
                      alignment: Alignment.centerRight)),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(color: Colors.black45)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              height: MediaQuery.of(context).size.height * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(padding: EdgeInsets.only(left: 11,bottom: 4,top: 8),
                    child: Text(
                      'Select time for appointment',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, ),
                    child: Card(
                      elevation: 1,
                      color: Colors.grey.shade300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(
                            DateFormat(' dd MMM. yyyy, EEE   hh:mm aaa')
                                .format(date),
                            style: TextStyle(fontWeight: FontWeight.w400),
                          )),
                          IconButton(
                            icon: Icon(Icons.calendar_today),
                            color: Colors.green,
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate:
                                          DateTime(DateTime.now().year + 100))
                                  .then((chosenDate) {
                                setState(() {
                                  date = chosenDate != null
                                      ? DateTime(
                                          chosenDate.year,
                                          chosenDate.month,
                                          chosenDate.day,
                                          time.hour,
                                          time.minute)
                                      : date;
                                });
                                //print(chosenDate.toString());
                              });
                            },
                          ),
                          IconButton(
                            color: Colors.orange,
                            onPressed: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((chosenTime) {
                                setState(() {
                                  time = chosenTime ?? time;
                                  date = DateTime(date.year, date.month,
                                      date.day, time.hour, time.minute);
                                  print(date.toString());
                                  print(chosenTime.toString());
                                });
                              });
                            },
                            icon: Icon(Icons.access_time),
                          )
                        ],
                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.only(left: 11,bottom: 4,top: 8),
                  child: Text('Select Services', style: TextStyle(fontWeight: FontWeight.w600),)),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: services.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        final service = services[index];
                        return StyleListTile(
                            update: updatePreServices, state: service);
                      },
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: Colors.green
                        ),
                        onPressed: prefServices.length == 0
                            ? null
                            : () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return PaymentPage(services:prefServices,datetime: date,shopId: widget.shopId,shopName: widget.shopName,);
                                }));
                              },
                        child: Text("Proceed"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  updatePreServices(bool selected, Map<String, dynamic> service) {
    if (selected) {
      setState(() {
        prefServices.add(service);
      });
    } else {
      setState(() {
        prefServices.remove(service);
      });
    }
    print(prefServices);
    /*}else{
      print('Outside Condition');
      print(prefServices);
    }*/
  }
}

class StyleListTile extends StatefulWidget {
  final Function(bool, Map<String, dynamic>) update;
  final Map<String, dynamic> state;

  StyleListTile({
    Key? key,
    required this.update,
    required this.state,
  }) : super(key: key);

  @override
  State<StyleListTile> createState() => _StyleListTileState();
}

class _StyleListTileState extends State<StyleListTile> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: CheckboxListTile(
          title: Text(
            widget.state['name'],
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
          subtitle: Text(
            'GH₵${widget.state['price']}',
            style: TextStyle(fontSize: 12),
          ),
          onChanged: (value) {
            setState(() {
              isSelected = !isSelected;
            });
            widget.update(value!, widget.state);
          },
          value: isSelected,
          secondary: FaIcon(FontAwesomeIcons.hashtag),
        ),
      ),
    );
  }
}

//Appointment info and confirmation.show appointment info
// together with shop info and ask for payment option

// class PaymentPage extends StatefulWidget {
//   const PaymentPage({Key? key}) : super(key: key);
//
//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }
//
// class _PaymentPageState extends State<PaymentPage> {
//   BoxDecoration unselected = BoxDecoration();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//             centerTitle: true,
//             backgroundColor: Colors.white,
//             elevation: 0.0,
//             title: Text("Book Appointment",
//                 style: TextStyle(
//                     color: Colors.white, fontWeight: FontWeight.bold)),
//             leading: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(
//                   Icons.arrow_back,
//                   color: Colors.white,
//                 ))),
//         body: Column(children: [
//           SizedBox(
//             height: 120,
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Container(
//                     height: 80,
//                     width: 90,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         image: DecorationImage(
//                             image: AssetImage("images/salon.jpg"),
//                             fit: BoxFit.cover)),
//                   ),
//                 ),
//                 Expanded(
//                     child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ListTile(
//                       title: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Street cuts",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 22)),
//                           Icon(Icons.star, color: Colors.amber)
//                         ],
//                       ),
//                       subtitle: Text("Obuasi hign street"),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Text("Services chosen"),
//                     ),
//                     Wrap(children: [
//                       Text("Service1 ,"),
//                       Text("Service2 ,"),
//                       Text("Service3 ,"),
//                       Text("Service4 ,")
//                     ])
//                   ],
//                 ))
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           Padding(
//               padding: const EdgeInsets.all(3.0),
//               child: ListTile(
//                 autofocus: true,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 title:
//                     Center(child: Text(selectedtime.toString().split(" ")[0])),
//               )),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               "Payment method",
//               style: TextStyle(color: Colors.black, fontSize: 23),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               padding: EdgeInsets.zero,
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.green, width: 3),
//                   borderRadius: BorderRadius.circular(10)),
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width - 20,
//                 height: 50,
//                 child: ListTile(
//                     title: Text("Pay with card"),
//                     leading: Icon(Icons.payments)),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               padding: EdgeInsets.zero,
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.green, width: 3),
//                   borderRadius: BorderRadius.circular(10)),
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width - 20,
//                 height: 50,
//                 child: ListTile(
//                     title: Text("Pay with Momo"),
//                     leading: Icon(Icons.payments)),
//               ),
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }
