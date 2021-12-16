import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  List items = [
    {
      "img": "images/nicesalon.jpg",
      "name": "Kay",
      "date": "20th Oct",
      "time": "12:00 pm",
      "message": "Hello"
    },
    {
      "img": "images/salon.jpg",
      "name": "Joe",
      "date": "20th Oct",
      "time": "12:00 pm",
      "message": "Are you there?"
    },
     {
      "img": "images/salon.jpg",
      "name": "Joe",
      "date": "20th Oct",
      "time": "12:00 pm",
      "message": "Are you there?"
    },
    {
      "img": "images/nicesalon.jpg",
      "name": "Kay",
      "date": "20th Oct",
      "time": "12:00 pm",
      "message": "Hello"
    },
    {
      "img": "images/salon.jpg",
      "name": "Joe",
      "date": "20th Oct",
      "time": "12:00 pm",
      "message": "Are you there?"
    },
     {
      "img": "images/salon.jpg",
      "name": "Joe",
      "date": "20th Oct",
      "time": "12:00 pm",
      "message": "Are you there?"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
     
      children: [
       Align(
alignment:Alignment.bottomCenter,
         child: SizedBox(
            height: MediaQuery.of(context).size.height*0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation:3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Appointments",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              ),
            ),
          ),
           SizedBox(height: 5),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, i) => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: appointmentCard(items[i]["date"], items[i]["time"],
                                items[i]["img"], items[i]["name"], context),
                          )),
                ),
              ],
            ),
          ),
       ),
       Align(
         alignment: Alignment.topCenter,
         child: Container(
           color: Colors.white,
           height:MediaQuery.of(context).size.height*0.3,
         ),
       )
       , Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
              height:MediaQuery.of(context).size.height*0.3,
              child: Column(
                children: [
                   SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Service Requests",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          
                  Expanded(
                    child: SizedBox(
                      height: 160,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (context, i) => Request(
                              items[i]["date"],
                              items[i]["time"],
                              items[i]["img"],
                              items[i]["name"],
                              context)),
                    ),
                  ),
                ],
              )
                      ),
        ),
                  
      
        
      ],
    );
  }
}

Widget Request(
    String date, String time, String image, String name, BuildContext context) {
  return SizedBox(
    height: 140,
    width: MediaQuery.of(context).size.width - 30,
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
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.clock, color: Colors.white),
              title: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Text(date, style: TextStyle(color: Colors.white)),
                    Text(" , " + time, style: TextStyle(color: Colors.white)),
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
                      backgroundImage: AssetImage(image),
                    )),
                title: Text(name),
                trailing: IconButton(
                    onPressed: () {
          
                    },
                    icon: Icon(Icons.info, color: Colors.blue)),
              ),
            ),
          ),
          
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ButtonBar(alignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    onPressed: () {},
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
              ]),
            ),
          ),
        ],
      ),
    ),
  );
}

//appointment card

Widget appointmentCard(
    String date, String time, String img, String name, BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 20,
    height:70,
    child: ListTile(
      
      tileColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      leading: SizedBox(
        height: 70,
        width: 70,
        child: CircleAvatar(
          backgroundImage: AssetImage(img),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(name,style: TextStyle(color: Colors.white)),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: [
            Text(date, style: TextStyle(color: Colors.white)),
            Text(" , " + time, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    ),
  );
}

// class AppointmentInfo extends StatefulWidget {
//   const AppointmentInfo({Key? key,required this.date,required this.image,required this.name,required this.time }) : super(key: key);

//   final String name;
//   final String date;
//   final String time;
//   final String image;

//   @override
//   _AppointmentInfoState createState() => _AppointmentInfoState();
// }

// class _AppointmentInfoState extends State<AppointmentInfo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
        
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height*0.3,
//             decoration: BoxDecoration(
//               color: Colors.blue,
              
//             ),
//             child:Wrap(
//                 children: [
//                   Text(widget.date, style: TextStyle(color: Colors.white)),
//                   Text(" , " + widget.time, style: TextStyle(color: Colors.white)),
//                 ],
//               ),
           
//           ),
         
         
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: ButtonBar(alignment: MainAxisAlignment.center, children: [
//               SizedBox(
//                 width:100,
//                 child: ElevatedButton(
//                     onPressed: () {},
//                     child: Text("Accept"),
//                     style: ElevatedButton.styleFrom(
//                         padding: EdgeInsets.only(
//                             top: 10, bottom: 10, left: 25, right: 25),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         primary: Colors.blue,
//                         textStyle: TextStyle(color: Colors.white))),
//               ),
//               ElevatedButton(
//                   onPressed: () {},
//                   child: Text(
//                     "Decline",
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.only(
//                           top: 5, bottom: 5, left: 15, right: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       primary: Colors.grey[200],
//                       textStyle: TextStyle(color: Colors.blue))),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
// }
