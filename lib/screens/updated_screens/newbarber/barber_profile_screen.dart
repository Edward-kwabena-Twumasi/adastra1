import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';

import '../../../sign_in_option_screen.dart';

class BarberAboutScreen extends StatefulWidget {
  const BarberAboutScreen({ Key? key }) : super(key: key);

  @override
  _BarberAboutScreenState createState() => _BarberAboutScreenState();
}

class _BarberAboutScreenState extends State<BarberAboutScreen> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>> barber;
  
  @override
  void initState() {
    super.initState();
     barber =
        Provider.of<ApplicationProvider>(context, listen: false).getBarber();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        
           Column(
             children: [
                Container(
                   height:MediaQuery.of(context).size.height*0.15,
                   width:MediaQuery.of(context).size.width,
                   decoration:BoxDecoration(
            image: DecorationImage(image: AssetImage("images/nicesalon.jpg", ),fit:BoxFit.cover )
                   )
               ),
               Align(
                 alignment: Alignment.bottomCenter,
                 child: Container(
                             height:MediaQuery.of(context).size.height*0.72,
                     color: Colors.white,
                     child: ListView(
                       physics:NeverScrollableScrollPhysics(),
                       shrinkWrap:true,
                           children: [
                             SizedBox(
                  height: 40,
                             ),
                          StreamBuilder(
                                  
                                  stream: barber,
                                  builder:
                                    (BuildContext,
                                        AsyncSnapshot<DocumentSnapshot<Object?>>
                                            snapshot) {
                                              if (snapshot.connectionState==ConnectionState.waiting) {
                                                 return Center(
                  child: CircularProgressIndicator(
                    color: Colors.transparent,
                  )
                       );
                                              }
                                            else  if (snapshot.hasError) {
                       return Material(
                           child: Center(
                  child: Text('Oops,an error occured'),
                           ),
                       );
                     }
                                  return ListTile(
                                    title: Center(
                                      child: Text(snapshot.data!["name"],
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),),
                                    ),
                                    subtitle: Center(child: Text("Phone . "+snapshot.data!["phone"])),
                                  );
                                }),
                                Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Card(
                                    elevation: 5,
                                    color:Colors.grey.shade50,
                                    shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: IconButton(onPressed: (){}, icon: Icon(Icons.phone)),
                                    ),
                                  ),
                          
                                   Card(
                                     elevation: 5,
                                     color:Colors.grey.shade50,
                                     shape:RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(30)
                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.all(2.0),
                                       child: IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                                     ),
                                   ),
                          
                                   Card(
                                     elevation: 5,
                                     color:Colors.grey.shade50,
                                     shape:RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(30)
                                     ),
                                     child: Padding(
                                       padding: const EdgeInsets.all(2.0),
                                       child: IconButton(onPressed: (){
                                         Provider.of<ApplicationProvider>(context,
                                            listen: false)
                                        .signOut();
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (builder) {
                                      return SignInOptionScreen();
                                    }), (route) => false);
                                       }, icon: FaIcon(FontAwesomeIcons.signOutAlt)),
                                     ),
                                   ),
                                ],
                              ),
                             SizedBox(
                  height: 600,child: BarberHome()),
                           ],
                     )
                 
                     ),
               ),
             ],
           ),
     
      Align(
            alignment:Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.15-40
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color:Colors.green,
                    ),
                    child: SizedBox(
                      height: 80,
                      width:80,
                      child: CircleAvatar(
                        backgroundImage: AssetImage("images/nicesalon.jpg") ,
                      ),
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


//shop info tabs
class BarberHome extends StatefulWidget {
  const BarberHome({Key? key}) : super(key: key);

  @override
  _BarberHomeState createState() => _BarberHomeState();
}

class _BarberHomeState extends State<BarberHome> with TickerProviderStateMixin {
  // int initial = 0;
  // TabController tabController =
  //     TabController(
  //       initialIndex: 0,
  //       length: 4, vsync: );

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              titleSpacing: 0,
              backgroundColor: Colors.white,
              elevation: 6,
              bottom: TabBar(
                indicatorColor: Colors.green,
                labelStyle: TextStyle(color: Colors.green),
                unselectedLabelColor: Colors.black,
                labelColor: Colors.green,
                tabs: [
                  Tab(
                    text: "Basic Info",
                  ),
                  Tab(
                    text: "Portfolio",
                  ),
                 
                  Tab(
                    text: "Review",
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              About(context),
        
              Gallery(context),
              Review(context)
            ],
          ),
        ),
      ),
    );
  }
}



Widget About(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("About"),
        ),
        Text(
            "Best street salon and shop is a unisex salon that offers services of all kinds"),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Opening hours"),
        ),
        ListTile(
            title: Row(
          children: [
            Text("Monday - Friday"),
            Spacer(),
            Text("8am - 4pm"),
          ],
        )),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Address"),
        ),
        ListTile(
          title: Text("Obuasi mangoase"),
          subtitle: Text("You can locate our shop at obuasi off mangoase road"),
        )
      ],
    ),
  );
}



Widget Gallery(BuildContext context) {
  return SingleChildScrollView(
    child: MediaQuery.removePadding(
      context:context,
      removeTop:true,
      child: SizedBox(
        height: MediaQuery.of(context).size.height*9.8,
        child: GridView.builder(
          itemCount: 7,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing:2,
              mainAxisSpacing: 2
            ),
            itemBuilder: (context, photos) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
image: DecorationImage(image: AssetImage("images/manshaving.jpg"),fit: BoxFit.cover)

                ),
                height: 150,
                child:Text("Nice fade"),
              );
            }),
      ),
    ),
  );
}



Widget chatCard(String img, String name, String date, String time,String message) {
  return SizedBox(
    height:80,
    child: Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(10)
      ),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 60,
              width:60,
              child: CircleAvatar(
                      backgroundImage: AssetImage(img),
                    ),
            ),
            Expanded(
              child: ListTile(
         
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
               
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name),
                     Wrap(
                       children:[
                         Text("4.3"),
                         Icon(Icons.star,color: Colors.amber)
                       ]
                     )

                    ],
                  ),
                ),
               
                ),
            ),
           
          ],
        ),
         Flexible(child: Text("This is my review about this shop after having theri service")    )
        
      ],
  ),
    ));
}

Widget Review(BuildContext context) {
  return ListView.builder(
        shrinkWrap:true,
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: chatCard(items[index]["img"] ,items[index]["name"], items[index]["date"], items[index]["time"],
             items[index]["message"]),
          );
        },
      );
}

List items = [{"img":"images/nicesalon.jpg","name":"Kay","date":"20th Oct","time":"12:00 pm","message":"Hello"},
{"img":"images/salon.jpg","name":"Joe","date":"20th Oct","time":"12:00 pm","message":"Are you there?"},
];