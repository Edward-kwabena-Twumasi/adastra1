                                                

import 'package:flutter/material.dart';

class clientPayment extends StatefulWidget {
  const clientPayment({ Key? key }) : super(key: key);

  @override
  _clientPaymentState createState() => _clientPaymentState();
}

class _clientPaymentState extends State<clientPayment> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height:MediaQuery.of(context).size.height*0.3,
            child: Image.asset("images/lovecut.jpg", fit: BoxFit.cover,)
            
            ),
            Container(
               height:MediaQuery.of(context).size.height*0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Make payments for every service,to every shop tirelessly",textAlign: TextAlign.center,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold ),
                    ),
                  ),
                  SizedBox(height: 20,
                  )
                  ,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Available payment options",textAlign: TextAlign.center,style: TextStyle(fontSize: 20)
    
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                 SizedBox(
                 
                   width: MediaQuery.of(context).size.width,
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Card(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(15),
                       ),
                       elevation: 3,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                        Text("Mobile Money",style: TextStyle(fontSize: 25),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.all(20.0),
                                         child: Text("|",style: TextStyle(color: Colors.lightBlue)),
                                       ),
                                       Text("Credit Card",style: TextStyle(fontSize: 25),
                                       ),
                     
                                       ],
                        ),
                     ),
                   ),
                 ),
                 SizedBox(
                    height: 20,
                  ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("Account cards",style: TextStyle(fontSize: 20)),
                 ),
                 SizedBox(
                    height: 10,
                  ),
                  Card(
                    color:Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(15),
                   ),
                    elevation: 3,
                    child: Container(
                      padding:EdgeInsets.all(10),
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
      
                   Padding(
                     padding: const EdgeInsets.all(4.0),
                     child: Text("Name : Edward",style: TextStyle(fontSize: 25,color: Colors.white),),
                   ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text("Number : 0552489602",style: TextStyle(fontSize: 25,color: Colors.white),),
                    ),
                     Padding(
                       padding: const EdgeInsets.all(4.0),
                       child: Text("Bank : Mobile Money",style: TextStyle(fontSize: 25,color: Colors.white),),
                     ),
                                     ],
                      ),
                    ),
                  ),
    
    
                ],
              ),
            )
        ],
      ),
    );
  }
}