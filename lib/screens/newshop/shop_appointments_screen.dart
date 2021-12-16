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
      "img": "images/lovecut.jpg",
      "name": "Joe",
      "date": "20th Oct",
      "time": "12:00 pm",
      "message": "Are you there?"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.lightBlue[50]),
      child: Wrap(
        children: [
          SizedBox(height: 75),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Service Requests",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 22),
            ),
          ),
          SizedBox(
              height: 220,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, i) => Request(
                      items[i]["date"],
                      items[i]["time"],
                      items[i]["img"],
                      items[i]["name"],
                      context))),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 5,left: 5),
            child: Text("Appointments",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 22)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: appointmentCard(items[i]["date"], items[i]["time"],
                          items[i]["img"], items[i]["name"], context),
                    )),
          )
        ],
      ),
    );
  }
}

Widget Request(
    String date, String time, String image, String name, BuildContext context) {
  return SizedBox(
    height: 190,
    width: MediaQuery.of(context).size.width - 30,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 70,
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
          Padding(
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
//take us to more information screen of this appointment object
                    Navigator.push(context,
                        MaterialPageRoute(builder: (contex) {
                      return const AppointmentInfo(date: '20th October', image: 'images/nicesalon.jpg', name: 'Bob', time: '10 am -10:55 am',);
                    }));
                  },
                  icon: Icon(Icons.info, color: Colors.blue)),
            ),
          ),
          
          Align(
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
        ],
      ),
    ),
  );
}

//appointment card

Widget appointmentCard(
    String date, String time, String img, String name, BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 5,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: ListTile(
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        leading: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.amber, width: 7)),
            child: CircleAvatar(
              backgroundImage: AssetImage(img),
            )),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name),
        ),
        subtitle: Row(
          children: [
            Text(date),
            Text(" , " + time),
          ],
        ),
      ),
    ),
  );
}

class AppointmentInfo extends StatefulWidget {
  const AppointmentInfo({Key? key,required this.date,required this.image,required this.name,required this.time }) : super(key: key);

  final String name;
  final String date;
  final String time;
  final String image;

  @override
  _AppointmentInfoState createState() => _AppointmentInfoState();
}

class _AppointmentInfoState extends State<AppointmentInfo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: FloatingActionButton(onPressed: (){
      Navigator.pop(context);
    },
       child: Icon(Icons.arrow_back),
          elevation: 0.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.4,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child:Center(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                      children: [
                        Text(widget.date, style: TextStyle(color: Colors.white,fontSize: 26)),
                        Text(" , " + widget.time, style: TextStyle(color: Colors.white,fontSize: 24)),
                      ],
                    ),
                ),
              ),
             
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  children:[ DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.amber, width: 8)),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(widget.image),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(widget.name,style: TextStyle(fontWeight: FontWeight.normal, fontSize: 22)),
                  ),
]
                ),
            ),
           
            Align(
              alignment: Alignment.bottomCenter,
              child: ButtonBar(alignment: MainAxisAlignment.center, children: [
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
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
                ),
                SizedBox(
                  width: 140,
                  child: ElevatedButton(
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
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
