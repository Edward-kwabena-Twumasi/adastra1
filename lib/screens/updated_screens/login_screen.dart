//This page is the login home screen 
//it contains a button
//a little information text and i icon
//all arranged in a colums
import 'package:flutter/material.dart';

import 'NewClient/client_main_screen.dart';


//parent class named LoginScreen
//A stack is used to stack the main contents on an 
//image .The top container is overlayed on the bottom with 
//some opacity

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
  

    return Scaffold(
        //parent stack
        body: Stack(
          children: [
            //botttome container containing a full
            //width image
            Container(
              height:double.infinity,
              decoration:BoxDecoration(
                image:DecorationImage(image:AssetImage("images/manshaving.jpg",),fit:BoxFit.cover)
              ),
     
              
            ),
            //overlayed container with opacity
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6)
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                     Container(
                       padding:EdgeInsets.all(10),
                       
                       decoration:BoxDecoration(
                         borderRadius:BorderRadius.circular(10),
                         gradient:LinearGradient(colors: [
                           Colors.pink,Colors.indigo
                         ]
                         ,
                         begin: Alignment.bottomLeft,
                         end: Alignment.topRight
                         ),
                       ),
                       child: Icon(Icons.cut_rounded,color:Colors.white ,)),
                      SizedBox(
                        height: 10,
                      
                      ),
                      Text("Book appointment with Salon Barber shop and more",style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize: 22 )),
                      SizedBox(
                        height: 30,
                      
                      ),
                      SizedBox(
                        height:40,
                         width: MediaQuery.of(context).size.width-20,
                         child: ElevatedButton(onPressed: (){
                        Navigator.push(context,
                                  MaterialPageRoute(builder: (contex) {
                                return ClientMainScreen();
                              }));

                         }, child: Text("Sign in",style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize: 18 )),
                         style: ElevatedButton.styleFrom(
                           elevation:6,
                           padding: EdgeInsets.all(8),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(20)
                           )
                         ),
                         ),
                      ),
                     SizedBox(
                        height: 40,
                      
                      ),
                     
                    ],
                  ),
              ),
            ),
          ],
        ));
  }
}
//From this page we move on to the auth page for 
//phone auth sign in