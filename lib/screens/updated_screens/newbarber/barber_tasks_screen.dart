import 'package:flutter/material.dart';

class BarberTaskScreen extends StatefulWidget {
  const BarberTaskScreen({Key? key}) : super(key: key);

  @override
  _BarberTaskScreenState createState() => _BarberTaskScreenState();
}

class _BarberTaskScreenState extends State<BarberTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      
       Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("General Info",style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: const EdgeInsets.all(7.0),
        child: SizedBox(
          height: 170,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.pink, width: 2))),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                              child: Text("20",
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink))),
                          Text("Timeline")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.indigo, width: 2))),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                              child: Text("10",
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo))),
                          Text("Appointments")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.indigo, width: 2))),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                              child: Text("10",
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo))),
                          Text("Notifications")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      //Secopnd child contaioner

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Timeline",style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    Expanded (child: ListView.builder(
        shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (Buildcontext,index){
        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TimeLine("20th October", "12 am", "Edward", "images/welcome.png", "images/salon.jpg", context),
        );
      }))

    ]);
  }
}

Widget TimeLine(String date,String time,String name,String image1,String image2,BuildContext context ) {
  return Container(
    padding: EdgeInsets.only(
      left: 6,
      top: 25,
      bottom: 0
    ),
    decoration: BoxDecoration(
     
      border: Border(
        left: BorderSide(
          color: Colors.black54,
          width: 2
        )
      )
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
     Row(
       children: [
         Container(
           width: 15,
           height: 15,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(50),
             gradient:LinearGradient(colors: [
               Colors.blue,Colors.pink
             ])
           ),
         ),
         Text(time,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26 ),),
       ],
     ),
       Center(
         child: ListTile(
           title: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text(name),
           ),
           subtitle: Center(
             child: Wrap(
               children: [
                 //first image
                 SizedBox(
                   height: 70,
                   width: 70,
                   child: Container(
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(50),
                         border: Border.all(

                                 color: Colors.blue,
                                 width: 3,
                         ),
                       image: DecorationImage(image: AssetImage(image1))
                     ),
                   )
                 ),
                 //second image
                 SizedBox(
                     height: 70,
                     width: 70,
                     child: Container(
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(50),
                           border: Border.all(

                             color: Colors.blue,
                             width: 3,
                           ),
                           image: DecorationImage(image: AssetImage(image2))
                       ),
                     )
                 )
               ],
             ),
           ),
         ),
       )
    ],),
  )
  ;
}
