import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class shopNotifications extends StatefulWidget {
  const shopNotifications({Key? key}) : super(key: key);

  @override
  shopNotificationsState createState() => shopNotificationsState();
}

class shopNotificationsState extends State<shopNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        
        body: SingleChildScrollView(
          child: Column(
            
            children: [
              Container(
                color: Colors.amber,
                height: MediaQuery.of(context).size.height*0.3,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width ,
                  child: Center(
                    child: TextField(
                        decoration: InputDecoration(
                            hintText: "search",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.5))),
                  ),
                ),
              ),
              Container(
                margin:EdgeInsets.only(
                  top:10,left:2,right: 2
                ),
                 height: MediaQuery.of(context).size.height*0.7,
                child: ListView.separated(
                   separatorBuilder: (_, i) => Divider(
                    color: Colors.black,
                  ),
                  shrinkWrap:true,
                  itemCount: items.length,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      child: notificationCard(items[index]["img"] ,items[index]["title"], items[index]["date"], items[index]["time"]),
                      background: Container(
                        color: Colors.green,
                      ),
                      key: ValueKey<String>(items[index]["time"]),
                      onDismissed: (DismissDirection direction) {
                        setState(() {
                          items.removeAt(index);
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

// ignore: non_constant_identifier_names
Widget notificationCard(String img, String title, String date, String time) {
  return ListTile(
    tileColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    leading: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.amber)),
        child: CircleAvatar(
          backgroundImage: AssetImage(img),
        )),
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title),
    ),
    subtitle: Row(
      children: [
        Expanded(child: Text(date)),
        Expanded(child: Text(time)),
      ],
    ),
  );
}

List items = [{"img":"images/nicesalon.jpg","title":"Appointment successful","date":"20th Oct","time":"12:00 pm",},
{"img":"images/nicesalon.jpg","title":"Appointment successful","date":"20th Oct","time":"12:00 pm",},
{"img":"images/nicesalon.jpg","title":"Appointment successful","date":"20th Oct","time":"12:00 pm",}
];
