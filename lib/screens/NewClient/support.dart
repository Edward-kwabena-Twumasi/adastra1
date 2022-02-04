import 'package:flutter/material.dart';

class Support extends StatefulWidget {
  const Support({Key? key}) : super(key: key);

  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Support",style:TextStyle(color:Colors.black)),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,color: Colors.black,)),
        ),
        body: Column(
          children: [
            Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
                child: Stack(children: [
                  Transform(
                    transform: Matrix4.identity()..translate(-70.0,-40.0),
                    child: Container(
                      height: 200,
                      width:200,
                      decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white.withOpacity(0.7),
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: Offset.fromDirection(2.0))
                      ]),
                    ),
                  ),
                  Positioned(
                      top: 50,
                      left: 50,
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "TheCut  ",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        TextSpan(
                            text: "  Support ",
                            style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))
                      ]))),
                  Transform(
                    transform: Matrix4.identity()..translate(295.0, 140.0),
                    child: Positioned(
                        top: 170,
                        left: 170,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.white.withOpacity(0.7),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: Offset.fromDirection(2.0))
                              ]),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.help,color:Colors.orange,size: 50,),
                              ),
                        )
                        ),
                  )
                ])),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 13.0,
                mainAxisSpacing: 13.0,
                shrinkWrap: true,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(color: Colors.pink),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.message,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "FAQ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.message, color: Colors.white),
                          ),
                          Text(
                            "How to",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(color: Colors.orange),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.message, color: Colors.white),
                          ),
                          Text(
                            "Conplaint",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(color: Colors.indigo),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.message, color: Colors.white),
                          ),
                          Text(
                            "TS & Cs",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(color: Colors.black),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.message, color: Colors.white),
                          ),
                          Text(
                            "Contact",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
