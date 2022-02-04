import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';

class AddBarber extends StatefulWidget {
  const AddBarber({Key? key}) : super(key: key);

  @override
  _AddBarberState createState() => _AddBarberState();
}

class _AddBarberState extends State<AddBarber> {
  TextEditingController barberid = TextEditingController();

  late StreamSubscription barberSubscription;
  //String shopid = "";
  List<Map<String, dynamic>> barbers = [];

  //bool searching=false;
  @override
  void initState() {
    super.initState();
    barberSubscription = provider().getBarbers().listen((event) {
      setState(() {
        barbers = [];
      });
      event.docs.forEach((e) {
        print('Insider Stream Subscription');
        setState(() {
          barbers.add(e.data());
        });

        print(e.data());
      });
    });
    
  }

  @override
  void dispose() {
    super.dispose();
    barberSubscription.cancel();
  }

  ApplicationProvider provider() {
    return Provider.of<ApplicationProvider>(context, listen: false);
  }

/**/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Barbers"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: GridView.count(
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 2,
        children: [
          ...barbers.map((e) => Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                            border: Border.all(color: Colors.amber, width: 2)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            e["name"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _modalBottomSheetMenu,
        child: Icon(Icons.add),
      ),
    );
  }

  void _modalBottomSheetMenu() {
    bool searching = false;
    bool showresult = false;
    bool exists = true;
    Map<String, dynamic> barber = {};
    setState(() {
      barberid.text = "";
    });
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, StateSetter newState) {
            return Container(
                height: 350.0,
                color: Colors.transparent,
                //could change this to Color(0xFF737373),
                //so you don't have to change MaterialApp canvasColor
                child: new Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          topRight: const Radius.circular(10.0))),
                  child: Column(children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: barberid,
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone Number is required';
                          } else if (value.length < 10) {
                            return 'Number must equal 10 digits';
                          }
                          return null;
                        },
                        autofocus: false,
                        maxLength: 10,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Barber id",
                          /*labelText: 'Phone Number',
                            labelStyle: TextStyle(color: Colors.black),*/
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {},
                          ),
                          // enabledBorder: const OutlineInputBorder(
                          //   borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                          // ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          primary: Colors.deepOrange,
                          onPrimary: Colors.white,
                          shadowColor: Colors.deepPurple,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17.0)),
                        ),
                        onPressed: () {
                          newState(() {
                            searching = true;
                            print(searching.toString());
                          });
                          // setState(() {
                          //   searching=true;
                          // });
                          FirebaseFirestore.instance
                              .collection("barbers")
                              .doc(barberid.text)
                              .get()
                              .then((value) {
                            newState(() {
                              showresult = true;
                            });

                            if (value.exists) {
                              print("Hey");
                              newState(() {
                                searching = false;
                                exists = true;
                                print(searching.toString());
                                barber = value.data()!;
                                print(barber);
                              });
                            } else {
                              newState(() {
                                exists = false;
                                searching = false;
                              });
                            }
                          });
                        },
                        child: searching
                            ? SizedBox(
                                height: 19,
                                width: 19,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3.0,
                                ),
                              )
                            : Text('Find'),
                      ),
                    ),
                    Spacer(),
                    showresult
                        ? exists
                            ? SizedBox(
                                height: 100,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.black),
                                      ),
                                      Expanded(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(barber["name"]),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              // child: barber[
                                              //             "shop_affilition"] ==
                                              //         "none"
                                              //     ? 
                                                child:  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              shape:
                                                                  StadiumBorder()),
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "barbers")
                                                            .doc(barberid.text)
                                                            .update({
                                                          "shop_affiliation":
                                                              provider()
                                                                  .phoneNumber
                                                        }).then((value) {
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("shops")
                                                            .doc(provider()
                                                                .phoneNumber)
                                                            .update({
                                                          "barbers": FieldValue
                                                              .arrayRemove(
                                                                  [barberid])
                                                        });
                                                      },
                                                      child: Text("Add"))
                                                  // : Text(
                                                  //     "Affiliated to a shop"),
                                            ),
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("No resutls found"),
                              )
                        : Text("")
                  ]),
                ));
          });
        });
  }
}
