import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShareApp extends StatefulWidget {
  const ShareApp({ Key? key }) : super(key: key);

  @override
  _ShareAppState createState() => _ShareAppState();
}

class _ShareAppState extends State<ShareApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Share"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,

        children:[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Share app with others",style: TextStyle(fontSize: 23,fontWeight:FontWeight.bold ),),
          ),

 Wrap(children: [
          IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.facebook)),
          IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.twitter)),
          IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.instagram)),
          IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.whatsapp)),
        ]),

        ]
      ),
    );
  }
}