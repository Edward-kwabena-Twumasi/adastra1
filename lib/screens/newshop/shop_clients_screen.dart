import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';

class ShopClients extends StatefulWidget {
  ShopClients({Key? key}) : super(key: key);

  @override
  _ShopClientsState createState() => _ShopClientsState();
}

class _ShopClientsState extends State<ShopClients> {
  int total=6;
  ApplicationProvider provider() {
    return Provider.of<ApplicationProvider>(context, listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      
      children:[
        Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Clients',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
              ],
            ),
          ),
        ),

        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("shop_client_relation")
                .where("shop_id",isEqualTo:provider().phoneNumber ).snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

              if(snapshot.connectionState==ConnectionState.waiting){
                return SpinKitCircle(color: Colors.white,);
              }
              else if(snapshot.hasError){
                return Text("Oops an error occured");
              }


              return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String,dynamic> itemData=Map.from(snapshot.data!.docs[index].data() as Map<String,dynamic>);
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ShopClient(name:itemData["client_name"] ,phone:itemData["client_phone"] ,)
                    );
                  });

            }),

                    
      ]
    );
  }
}

class ShopClient extends StatelessWidget {
  const ShopClient({Key? key,required this.name,required this.phone}) : super(key: key);
final String name;
final String phone;
  @override
  Widget build(BuildContext context) {
    return Row(

      children: [

        Padding(

          padding: const EdgeInsets.all(10.0),

          child: Container(

            height: 40,

            width: 40,

            decoration: BoxDecoration(

                borderRadius:BorderRadius.circular(50),

                image: DecorationImage(

                    image: AssetImage("images/salon.jpg"),

                    fit: BoxFit.cover)),

          ),

        ),

        Expanded(

            child: Column(

              crossAxisAlignment:CrossAxisAlignment.start,

              children: [

                ListTile(

                  title: Text(name),

                  subtitle: Text(phone),

                ),

              ],

            ))

      ],

    );
  }
}
