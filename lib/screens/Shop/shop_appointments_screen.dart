import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class shopAppointments extends StatefulWidget {
  const shopAppointments({Key? key}) : super(key: key);

  @override
  shopAppointmentsState createState() => shopAppointmentsState();
}

class shopAppointmentsState extends State<shopAppointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,                                                     
        appBar: AppBar(
          elevation: 0.0,
          
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text("Appointment",style:TextStyle(color:Colors.white)),
            bottom: PreferredSize(child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: TextField(
                    decoration:InputDecoration(
                      hintText: "search",
                      border: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(20),
                        borderSide: BorderSide.none
                      ),
                      filled:true,
                      fillColor:Colors.white.withOpacity(0.5)
                    )
                  ),
                ), preferredSize: Size.fromHeight(30)),
            
            
                
                ),
        body: Stack(
        
          children: [
           Positioned.fill(
              child: Stack(
                children: [
                  Container(
                    
                   decoration: BoxDecoration(
                   image: DecorationImage(image: NetworkImage("https://cdn.dribbble.com/users/3765746/screenshots/6722645/calender.png",),fit: BoxFit.cover)
                   ),

                  
                  ),
                  Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height*0.3,
                    child: Center(
                      child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ChoiceChip(
                    elevation: 5,
                    label: Text("2 Upcoming", style: TextStyle(fontWeight: FontWeight.bold)), selected: true,
                  labelPadding:EdgeInsets.all(8) ,),
                ),
                Padding(
                  
                  padding: const EdgeInsets.all(4.0),
                  child: ChoiceChip(
                     elevation: 5,
                    label: Text("10 Total",style: TextStyle(fontWeight: FontWeight.bold)), selected: true,
                    labelPadding:EdgeInsets.all(8)),
                ),
                
              ],
            ),
                    ),
                  )
                ],
              ),
            ),
            // Positioned(
            //   top: 100,
            //   child: Center(

            //   ),
            //    ),
          Align(
            alignment: const Alignment(1, 1),
             child: Container(
             height: MediaQuery.of(context).size.height*0.7,
               decoration: BoxDecoration(
                
                 color: Colors.white,
        borderRadius: BorderRadius.only(
             topLeft: Radius.circular(20),topRight: Radius.circular(30)
        )
               ),
               
               margin: EdgeInsets.zero,
               child: SingleChildScrollView(
                 child: Column(
                   crossAxisAlignment:CrossAxisAlignment.start,
                   children: [
                     SizedBox(
                       height: 40,
                     ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text("Recents",style:TextStyle(color:Colors.black,fontSize: 25  )),
                      ),
                      
                     Padding(
                       padding: const EdgeInsets.all(3.0),
                       child: AppointmentCards("images/barbclip.jpg", "Eddie", "20/10/21", "13:30"),
                     ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text("Older",style:TextStyle(color:Colors.black,fontSize: 25  )),
                      ),
                     Padding(
                       padding: const EdgeInsets.all(3.0),
                       child: AppointmentCards("images/barbclip.jpg", "Bob", "20/10/21", "13:30"),
                     ),
                     Divider(),
                     Padding(
                       padding: const EdgeInsets.all(3.0),
                       child: AppointmentCards("images/barbclip.jpg", "Kofi", "20/10/21", "13:30"),
                     ),
                      Divider(),
                     Padding(
                       padding: const EdgeInsets.all(3.0),
                       child: AppointmentCards("images/barbclip.jpg", "Noah", "20/10/21", "13:30"),
                     )
                   ],
                 ),
               ),
             ),
           ),
          ],
        ));
  }
}

// ignore: non_constant_identifier_names
Widget AppointmentCards(String img , String name, String date, String time) {
  return ListTile(
    tileColor:Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8)
    ),
    leading: DecoratedBox(
      decoration:BoxDecoration(
 borderRadius: BorderRadius.circular(30),
 border: Border.all(color:Colors.black)
      )
     ,
      child: CircleAvatar(
     
        backgroundImage: AssetImage(img),
      )),
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(name),
    ),
    subtitle: Row(
      children: [
        Expanded(child: Text(date)),
         Expanded(child: Text(time)),
      ],
    ),
    trailing: Icon(Icons.remove_red_eye),
  );
}
