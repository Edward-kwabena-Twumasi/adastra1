import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  ChatsState createState() => ChatsState();
}

class ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        
        body: Column(
          
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height*0.2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width-20 ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [TextField(
                        decoration: InputDecoration(
                            hintText: "search",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.5))
                            ),
                            Row(
                              children: [
                                Text("Chats"),
                                Chip(label: Text(items.length.toString())),
                              ],
                            )
                            ]
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap:true,
              itemCount: items.length,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  child: chatCard(items[index]["img"] ,items[index]["name"], items[index]["date"],
                   items[index]["time"], items[index]["message"]),
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
          ],
        ));
  }
}

// ignore: non_constant_identifier_names
Widget chatCard(String img, String name, String date, String time,String message) {
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
      child: Row(
        children: [
          Text(name),
          Spacer(),
Text(time),
        ],
      ),
    ),
    subtitle: Text(message),
  );
}

List items = [{"img":"images/nicesalon.jpg","name":"Kay","date":"20th Oct","time":"12:00 pm","message":"Hello"},
{"img":"images/salon.jpg","name":"Joe","date":"20th Oct","time":"12:00 pm","message":"Are you there?"},
];
