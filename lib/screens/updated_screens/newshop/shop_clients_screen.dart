import 'package:flutter/material.dart';

class ShopClients extends StatefulWidget {
  ShopClients({Key? key}) : super(key: key);

  @override
  _ShopClientsState createState() => _ShopClientsState();
}

class _ShopClientsState extends State<ShopClients> {
  int total=6;
  @override
  Widget build(BuildContext context) {
    return Column(
      
      children:[
        Expanded(
          child: Container(
           // width: double.infinity,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(
                color: Colors.blue,
                width: 3
              ))
            ),
            child: RichText(
                          text: TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                  text: total.toString(),
                                  style:
                                      TextStyle(fontSize: 25, color: Colors.blue),
                                      ),
                              TextSpan(
                                  text: " Clients",
                                  style: TextStyle(color: Colors.lightBlue)),
                              
                            ],
                          ),
                        ),
          ),
        ),
    Align(
    alignment: Alignment.bottomCenter,
    child:   SizedBox(
    
    height:MediaQuery.of(context).size.height*0.8,
    
    child:ListView.builder(
    
      shrinkWrap: true,
    
      itemCount: 6,
    
      itemBuilder: (BuildContext context, int index) {
    
        return    SizedBox(
    
            height: 120,
    
            child: Row(
    
              children: [
    
                Padding(
    
                  padding: const EdgeInsets.all(5.0),
    
                  child: Container(
    
                    height: 60,
    
                    width: 60,
    
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
    
                      title: Row(
    
                        children: [
    
                          Text("Steve harvey"),
    
                          Spacer(),
    
                          Icon(Icons.info,color: Colors.amber)
    
                        ],
    
                      ),
    
                      subtitle: Text("Washington"),
    
                    ),
    
                    Padding(
    
                      padding: const EdgeInsets.all(8.0),
    
                      child: Text("Last visit   Yesterday"),
    
                    )
    
                  ],
    
                ))
    
              ],
    
            ),
    
          );
    
      },
    
    ),
    
    ),
    )
                    
      ]
    );
  }
}