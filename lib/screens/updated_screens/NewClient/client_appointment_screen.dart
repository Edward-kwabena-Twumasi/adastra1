//this page gives every information related to a clients appointment



import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClientAppointments extends StatefulWidget {
  const ClientAppointments({Key? key}) : super(key: key);

  @override
  _ClientAppointmentsState createState() => _ClientAppointmentsState();
}

class _ClientAppointmentsState extends State<ClientAppointments> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: 60,
            padding:EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius:BorderRadius.circular(20)
            ),
            child: Text("Saved shops",style:TextStyle(fontWeight:FontWeight.bold,fontSize: 20,color: Colors.black )),
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 50,
              child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(50),
                      child: AppBar(
                        titleSpacing: 0,
                        backgroundColor: Colors.white,
                        elevation: 0.0,
                        bottom: TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(25)),
                          unselectedLabelColor: Colors.blue,
                          labelColor: Colors.white,
                          tabs: [
                            Tab(
                              text: "Upcoming",
                            ),
                            Tab(text: "Later"),
                            Tab(text: "History"),
                          ],
                        ),
                      ),
                    ),
                    body: TabBarView(children: [
                      //upcoming appointments
                      Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text("Today",style:TextStyle(fontWeight:FontWeight.bold,fontSize: 20 )),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: AppointmentCard(context, "EDD", "Best cuts", "13:30"),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: AppointmentCard(context, "Nana", "Best cuts", "13:30"),
                        )
                      ]),
                      //later appointments
                     Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                       children: [
                         Align(
                           alignment:Alignment.topRight,
                           child: Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: OptionButton(context),
                           )),
    
                            Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: AppointmentCard(context, "EDD", "Best cuts", "13:30"),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: AppointmentCard(context, "Joe", "Best cuts", "13:30"),
                        )
                       ],
                     ),
                      Column(
                        children: [
                          Center(
                            child: Text("No History yet"),
                          )
                        ],
                      )
                    ]),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

Widget AppointmentCard(
    BuildContext context, String name, String shop, String time) {
  return SizedBox(
      width: MediaQuery.of(context).size.width -30,
      height: 60,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(10)
        ),
        tileColor: Colors.white,
        leading: SizedBox(
                      height: 70,
                      width: 70,
                      child: CircleAvatar(
                          backgroundColor: Colors.amber,
                          child: Icon(Icons.notifications, color: Colors.white)),
                    ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [Text(shop),Spacer(), Text(time)],
          ),
        ),
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.info_sharp)),
      ));
}

Widget OptionButton(BuildContext context) {
  return SizedBox(
    width: 100,
    height: 40,
    child: Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
       color:Colors.green[50],
       border: Border.all(
         color: Colors.green
       ),
       borderRadius: BorderRadius.circular(25)
      ),
      child: PopupMenuButton(
       child:Row(
         children: [
           Padding(
             padding: const EdgeInsets.all(5.0),
             child: Text("This week",style: TextStyle(color: Colors.green), ),
           ),
           
           Icon(Icons.arrow_downward,color: Colors.green,)
         ],
       ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10) ),
        color:Colors.green[50],
        initialValue: "This week",
        itemBuilder: (BuildContext cntxt) {
        return <PopupMenuEntry>[
          PopupMenuItem(child: Text("Next Week"),value:"Next Week" , ),
           PopupMenuItem(child: Text("This month"),value:"This month"),
          ];
      }),
    ),
  );
}
