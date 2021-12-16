import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thecut/screens/updated_screens/newshop/shop_appointments_screen.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {

  Map<String,dynamic> requestObject={
    "img": "images/nicesalon.jpg",
    "name": "Kay",
    "date": "20th Oct",
    "time": "12:00 pm",
    "message": "Hello"
  };
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
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.notifications),Text('Pending Requests',style: TextStyle(fontWeight: FontWeight.bold),)],
                ),
              ),
              (items.length>0)? Container(
                height: 155,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, i) => Request(
                        requestObject["date"],
                        requestObject["time"],
                        requestObject["img"],
                        requestObject["name"],
                        context)),
              ) : Text('No Request Pending'),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.book),Text('Confirmed Appointments',style: TextStyle(fontWeight: FontWeight.bold),)],
                ),
              ),

            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: List.generate(4, (index) =>
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: appointmentCard(requestObject["date"], requestObject["time"],
                        requestObject["img"],requestObject["name"], context),
                  )
              ),
            )
          )
        ],
      ),
    );
  }


  Widget Request(
      String date, String time, String image, String name, BuildContext context) {
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

}
