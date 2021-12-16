
//This is the shops dashboad.it shows reminders 
//monthloy transsactions
//money spendt and received,reviews 
//and service patronage statistics
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thecut/screens/newshop/linecharts.dart';
import 'package:thecut/screens/newshop/piechart.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentPage = 0;

  final _controller = PageController();

  double percent = 20.0;
  @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                color: Color(0x4427b6fc),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                color: Colors.white,
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Joined",style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                )),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("20 th,October",style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                )),
                    ),
                    trailing: SizedBox(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                            backgroundImage: AssetImage(
                          "images/nicesalon.jpg",
                        )))),
                ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: () {
                         _controller.animateToPage(0,
                                duration: Duration(milliseconds: 200 ), curve: Curves.bounceIn);
                      }, child: Text("Reminders")),
                      TextButton(
                          onPressed: () {
                            _controller.animateToPage(1,
                                duration: Duration(milliseconds: 200), curve: Curves.bounceIn);
                          },
                          child: Text("Monthly Transactions"))
                    ]),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 303,
                    width: MediaQuery.of(context).size.width,
                    child: PageView(
                      controller: _controller,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey, blurRadius: 5)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Reminders"),
                                  ListTile(
                                    title: Text("Pay bills"),
                                    subtitle: LinearProgressIndicator(
                                      semanticsLabel:"Remind me to pay bills",
                                        value: percent / 100),
                                  ),
                                  ListTile(
                                    title: Text("Buy new clippers"),
                                    subtitle: LinearProgressIndicator(
                                        value: 30 / 100),
                                  ),
                                  ListTile(
                                    title: Text("Shop meeting"),
                                    subtitle: LinearProgressIndicator(
                                        value: 70 / 100),
                                  ),
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SingleChildScrollView(
                            child:LineChartSample1()
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:SizedBox(
                    height:130,
                  child: ListView(
                    scrollDirection:Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation:5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("Ratings"),

                                  Text("0 rating",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 22 )  ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                           elevation:5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("Money"),
                               Row(
                                 children: [
                                   FaIcon(FontAwesomeIcons.arrowUp),

                                  Text("0 GHS",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 22 )  ),




                                 ],
                               )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation:5,
                          
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("Visits"),
                                Text("2",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 22 )),
                                TextButton(onPressed: (){}, child: Text("Detailes"))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),)
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 5)
                          ]),
                      width: MediaQuery.of(context).size.width - 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Services patronage"),
                          Expanded(child: PieChartSample2())
                        ],
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
