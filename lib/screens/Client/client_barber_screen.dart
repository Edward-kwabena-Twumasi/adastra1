import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClientBarbers extends StatefulWidget {
  const ClientBarbers({Key? key}) : super(key: key);

  @override
  ClientBarbersState createState() => ClientBarbersState();
}

class ClientBarbersState extends State<ClientBarbers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text("Barbers",style:TextStyle(color:Colors.white)),
             bottom: PreferredSize(child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                 
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  ),
                ), preferredSize: Size.fromHeight(50)),
            
                
                ),
        body: Stack(
        
          children: [
           Positioned.fill(
              child: Container(
                
               decoration: BoxDecoration(
               image:  DecorationImage(image: NetworkImage("https://i.pinimg.com/564x/45/95/46/4595461fca1faea219f8931bd941dfca.jpg",),fit: BoxFit.cover)
               ),

              
              ),
            ),
          Align(
           alignment: Alignment.bottomRight,
             child: GridView.builder(

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0
      ),
      itemCount: 10,
      
      itemBuilder: (BuildContext context, int index) {
        return Card(
         elevation: 0.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
         
          child: Container(
            height:120,
            child: Column(
              
              children: [
        Flexible(
         flex: 2,
          
             child:  ClipRRect(child: Image.network("https://cdn.dribbble.com/users/5031392/screenshots/13869046/media/d66c1320f4c68ecc2e7a80e57813460a.png",fit:BoxFit.cover ))),
           Flexible(
                flex: 1,
                child: ListTile(
                  title: Text("Barbie"),
                  subtitle: Text("Bob cuts"),
                  leading: Icon(Icons.place),
                ),
              )
              ],
            ),
          ),
        );
      }
    ),
           ),
          ],
        ));
  }
}

// ignore: non_constant_identifier_names
