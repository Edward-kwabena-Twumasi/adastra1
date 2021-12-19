
import 'package:flutter/material.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({ Key? key }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
     shrinkWrap: true,
      children: [
        Container(
           height:MediaQuery.of(context).size.height*0.3,
           decoration:BoxDecoration(
             image: DecorationImage(image: AssetImage("images/salon.jpg"),fit:BoxFit.cover )
           )
         
        ),
        SizedBox(
          height:MediaQuery.of(context).size.height*0.7,
child: DashInfoCards(),
          //theses are tabs for the shop dashboard
        //   child: DefaultTabController(length: 2, child:  Scaffold(
         
         
        
        //   appBar: PreferredSize(
        //     preferredSize: const Size.fromHeight(50),
        //     child: AppBar(
        //       titleSpacing: 0,
        //       backgroundColor: Colors.white,
        //       elevation: 0.0,
        //       bottom: TabBar(
        //         indicatorSize: TabBarIndicatorSize.tab,
               
        //         indicator:BoxDecoration(
        //           color:Colors.blue,
        //           borderRadius: BorderRadius.circular(25)
    
        //         ),
              
        //         unselectedLabelColor: Colors.blue,
        //         labelColor: Colors.white,
        //         tabs: [
        //           Tab(
        //              text:"Recents",
                  
        //           ),
        //           Tab(
        //             text:"Statistics"
        //           ),
                 
        //         ],
        //       ),
        //     ),
        //   ),
        //   body: TabBarView(
        //     children: [
        //      Column(
        //        children: [
        //          Padding(
        //            padding: const EdgeInsets.all(7.0),
        //            child: SizedBox(
        //               height: 170,                                                                                  
        //              child: Row(
                       
        //                children: [
        //                  Expanded(
        //                    child: Padding(
        //                      padding: const EdgeInsets.all(15.0),
        //                      child: Container(
        //                         padding:EdgeInsets.zero,
        //                        decoration: BoxDecoration(
        //                          border: Border(
        //                            top: BorderSide(
        //                              color:Colors.pink,
        //                              width: 2
        //                            )
        //                          )
        //                        ),
        //                        child: Card(
                                
        //                          elevation: 4,
        //                          shape: RoundedRectangleBorder(
        //                            borderRadius:BorderRadius.circular(10)
        //                          ),
        //                          child: Column(
        //                             mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                  children: [
        //                        Center(child: Text("20",style:TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color:Colors.pink ) )),
        //                        Text("Requests")
        //                  ],
        //                          ),
        //                        ),
        //                      ),
        //                    ),
        //                  ),
        //                  Expanded(
        //                    child: Padding(
        //                      padding: const EdgeInsets.all(15.0),
        //                      child: Container(
        //                         padding:EdgeInsets.zero,
        //                        decoration: BoxDecoration(
        //                          border: Border(
        //                            top: BorderSide(
        //                              color:Colors.indigo,
        //                              width: 2
        //                            )
        //                          )
        //                        ),
        //                        child: Card(
                                
        //                          elevation: 2,
        //                          shape: RoundedRectangleBorder(
        //                            borderRadius:BorderRadius.circular(10)
        //                          ),
        //                          child: Column(
        //                             mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                  children: [
        //                        Center(child: Text("10",style:TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color:Colors.indigo ) )),
        //                        Text("Appointments")
        //                  ],
        //                          ),
        //                        ),
        //                      ),
        //                    ),
        //                  ),
                        
                         
        //                ],
        //              ),
        //            ),
        //          ),
        //          Padding(
        //            padding: const EdgeInsets.all(8.0),
        //            child: SizedBox(
        //               height: 170,                                                                                  
        //              child: Row(
                       
        //                children: [
        //                  Expanded(
        //                    child: Padding(
        //                      padding: const EdgeInsets.all(15.0),
        //                      child: Container(
        //                         padding:EdgeInsets.zero,
        //                        decoration: BoxDecoration(
        //                          border: Border(
        //                            top: BorderSide(
        //                              color:Colors.pink,
        //                              width: 2
        //                            )
        //                          )
        //                        ),
        //                        child: Card(
                                
        //                          elevation: 4,
        //                          shape: RoundedRectangleBorder(
        //                            borderRadius:BorderRadius.circular(10)
        //                          ),
        //                          child: Column(
        //                             mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                  children: [
        //                        Center(child: Text("20",style:TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color:Colors.pink ) )),
        //                        Text("Requests")
        //                  ],
        //                          ),
        //                        ),
        //                      ),
        //                    ),
        //                  ),
        //                  Expanded(
        //                    child: Padding(
        //                      padding: const EdgeInsets.all(15.0),
        //                      child: Container(
        //                         padding:EdgeInsets.zero,
        //                        decoration: BoxDecoration(
        //                          border: Border(
        //                            top: BorderSide(
        //                              color:Colors.indigo,
        //                              width: 2
        //                            )
        //                          )
        //                        ),
        //                        child: Card(
                                
        //                          elevation: 2,
        //                          shape: RoundedRectangleBorder(
        //                            borderRadius:BorderRadius.circular(10)
        //                          ),
        //                          child: Column(
        //                             mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                  children: [
        //                        Center(child: Text("10",style:TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color:Colors.indigo ) )),
        //                        Text("Appointments")
        //                  ],
        //                          ),
        //                        ),
        //                      ),
        //                    ),
        //                  ),
                        
                         
        //                ],
        //              ),
        //            ),
        //          ),
              
             
            
        //       ],
        //      ),
        //      //send child in second tab
        //      SizedBox(
        //        height: MediaQuery.of(context).size.height-180,
        //        child: ListView(
        //          shrinkWrap: true,
                
        //          children: [
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Text("Services patronage",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold )),
        //           ),
        //           PieChartSample2(),
        //           Divider(),
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Text("User Categories",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold )),
        //           ),
        //           Divider(
        //            color: Colors.transparent,
        //              ),
        //              DataTable(columns: [
        //            DataColumn(label: Text("Category")),
        //             DataColumn(label: Text("Total Usage")),
        //              ], rows: [
        //            DataRow(cells: [
        //              DataCell(Text("Adult Males")),
        //               DataCell(Text("10"))
        //            ]),
        //            DataRow(cells: [
        //              DataCell(Text("Adult Females")),
        //               DataCell(Text("15")
        //               )
        //            ]),
        //             DataRow(cells: [
        //              DataCell(Text("Teenagers")),
        //               DataCell(Text("25")
        //               )
        //            ])
        //              ]),
    
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Text("Revenue",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold )),
        //           ),
        //           Divider(),
        //            LineChartSample1()
        //          ],
        //        ),
        //      )
        //     ],
        //   ),
        // ),
        // ),
        )
      ],
    );
  }
}

Widget DashInfoCards() {
  return Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(7.0),
                   child: SizedBox(
                      height: 170,                                                                                  
                     child: Row(
                       
                       children: [
                         Expanded(
                           child: Padding(
                             padding: const EdgeInsets.all(15.0),
                             child: Container(
                                padding:EdgeInsets.zero,
                               decoration: BoxDecoration(
                                 border: Border(
                                   top: BorderSide(
                                     color:Colors.pink,
                                     width: 2
                                   )
                                 )
                               ),
                               child: Card(
                                
                                 elevation: 4,
                                 shape: RoundedRectangleBorder(
                                   borderRadius:BorderRadius.circular(10)
                                 ),
                                 child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
Categories(icon: Icons.category),
                               Text("20",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.pink ) ),
                               Text("Requests")
                         ],
                                 ),
                               ),
                             ),
                           ),
                         ),
                         Expanded(
                           child: Padding(
                             padding: const EdgeInsets.all(15.0),
                             child: Container(
                                padding:EdgeInsets.zero,
                               decoration: BoxDecoration(
                                 border: Border(
                                   top: BorderSide(
                                     color:Colors.indigo,
                                     width: 2
                                   )
                                 )
                               ),
                               child: Card(
                                
                                 elevation: 2,
                                 shape: RoundedRectangleBorder(
                                   borderRadius:BorderRadius.circular(10)
                                 ),
                                 child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           Categories(icon: Icons.lock_clock),
                               Center(child: Text("10",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.indigo ) )),
                               Text("Appointments")
                         ],
                                 ),
                               ),
                             ),
                           ),
                         ),
                        
                         
                       ],
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: SizedBox(
                      height: 170,                                                                                  
                     child: Row(
                       
                       children: [
                         Expanded(
                           child: Padding(
                             padding: const EdgeInsets.all(15.0),
                             child: Container(
                                padding:EdgeInsets.zero,
                               decoration: BoxDecoration(
                                 border: Border(
                                   top: BorderSide(
                                     color:Colors.pink,
                                     width: 2
                                   )
                                 )
                               ),
                               child: Card(
                                
                                 elevation: 4,
                                 shape: RoundedRectangleBorder(
                                   borderRadius:BorderRadius.circular(10)
                                 ),
                                 child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           Categories(icon: Icons.payment),
                               Center(child: Text("20",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.pink ) )),
                               Text("Payments")
                         ],
                                 ),
                               ),
                             ),
                           ),
                         ),
                         Expanded(
                           child: Padding(
                             padding: const EdgeInsets.all(15.0),
                             child: Container(
                                padding:EdgeInsets.zero,
                               decoration: BoxDecoration(
                                 border: Border(
                                   top: BorderSide(
                                     color:Colors.indigo,
                                     width: 2
                                   )
                                 )
                               ),
                               child: Card(
                                
                                 elevation: 2,
                                 shape: RoundedRectangleBorder(
                                   borderRadius:BorderRadius.circular(10)
                                 ),
                                 child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           Categories(icon: Icons.takeout_dining),

                               Center(child: Text("10",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.indigo ) )),
                               Text("Job Applications")
                         ],
                                 ),
                               ),
                             ),
                           ),
                         ),
                        
                         
                       ],
                     ),
                   ),
                 ),
              
             
            
              ],
             );
}

//tags model class
class Categories extends StatelessWidget {
  const Categories({Key? key, required this.icon}) : super(key: key);
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.red.shade50,
        child: IconButton(
          onPressed: () {},
          icon: Icon(icon),
          color: Colors.black,
        ),
      ),
    );
  }
}