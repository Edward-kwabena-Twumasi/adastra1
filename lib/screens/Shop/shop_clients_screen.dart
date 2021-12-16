import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class shopClients extends StatefulWidget {
  const shopClients({Key? key}) : super(key: key);

  @override
  shopClientsState createState() => shopClientsState();
}

class shopClientsState extends State<shopClients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        
        body: SingleChildScrollView(
          child: Column(
            
            children: [
              SizedBox(
                 height: MediaQuery.of(context).size.height*0.2,
                 child:ListTile(
                   title: Center(
                     child:Text("10 Clients")
                   ),
                 )
              ),
              Container(
                margin:EdgeInsets.only(
                  top:10,left:2,right: 2
                ),
                 height: MediaQuery.of(context).size.height*0.8,
                child: ListView.separated(
                   separatorBuilder: (_, i) => Divider(
                    color: Colors.black,
                  ),
                  shrinkWrap:true,
                  itemCount: items.length,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      child: contactCard(items[index]["img"] ,items[index]["name"],items[index]["contact"],),
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
Widget contactCard(String img, String name,String contact) {
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
      child: Text(name),
    ),
    subtitle: Row(
      children: [
        Expanded(child: Text(contact)),
        
      ],
    ),
  );
}

List items = [{"img":"images/nicesalon.jpg","name":"Florence","contact":"0552489602",},
{"img":"images/nicesalon.jpg","name":"Florence","contact":"0552489602",},
{"img":"images/nicesalon.jpg","name":"Florence","contact":"0552489602",},

];
