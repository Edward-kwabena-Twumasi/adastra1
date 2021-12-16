import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/updated_screens/NewClient/client_home_screen.dart';
import 'package:thecut/screens/updated_screens/newshop/book_appointment_screen.dart';
import 'package:thecut/screens/updated_screens/newshop/shop_main_screen.dart';

//import 'package:theshave/screens/Shop/shop_home_screen.dart';


class AboutShop extends StatefulWidget {
  const AboutShop({Key? key}) : super(key: key);

  @override
  AboutShopState createState() => AboutShopState();
}

class AboutShopState extends State<AboutShop> {
  //BuildContext context =ScaffoldState().context;
  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
  //List<String> titles = ["", "Payment", "Notifications", "History"];
late Future<DocumentSnapshot<Map<String, dynamic>>> shop;
 
  int index = 0;
  bool showsearch = true;
@override
  void initState(){
    super.initState();
    shop =
        Provider.of<ApplicationProvider>(context, listen: false).getShopForUser();

   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
        key: scaffolKey,
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: [ SliverAppBar(
          stretch: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.pink,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 6,
          
          expandedHeight: MediaQuery.of(context).size.height*0.4,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: [
              StretchMode.zoomBackground,
              StretchMode.blurBackground
            ],
            background: Header(context,shop),
          ),
        ),
            SliverFillRemaining(
              
              child: Wrap(
                 
                  children: [
                   
                    SizedBox(height: MediaQuery.of(context).size.height*0.55,
                    
                     child: ShopHome())
                  ]),
            ),
          ],
        ));
  }
}

Widget Header(BuildContext context,Future<DocumentSnapshot<Map<String, dynamic>>> shop) {
  return  Stack(
    children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "images/salon.jpg",
                ),
                fit: BoxFit.cover)),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration:
            BoxDecoration(color: Colors.black.withOpacity(0.6)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                                
                                future: shop,
                                builder:
                                  (BuildContext,
                                      AsyncSnapshot<DocumentSnapshot<Object?>>
                                          snapshot) {
                                            if (snapshot.connectionState==ConnectionState.waiting) {
                                               return Center(
              child: CircularProgressIndicator(
                color:Colors.white
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
                                return  ListTile(
                  title: Text(snapshot.data!["name"],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 19)),
                  subtitle: Text("Obuasi mangoase road",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      )));
                              })
             ,
              SizedBox(
                height: 3,
              ),
             
                  Row(
                    children: [
                      Text("3.0"),
                      Icon(Icons.star_border,
                                color: Colors.white),
                    ],
                  ),
                            
                  
              Divider(
                color: Colors.white,
              ),
              Row(
                children: [
                  Spacer(),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.save,
                              color: Colors.white)),
                      Text("Save",
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.directions,
                              color: Colors.white)),
                      Text("Directios",
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.phone,
                              color: Colors.white)),
                      Text("Contact",
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.share,
                              color: Colors.white)),
                      Text("Share",
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                  Spacer(),
                ],
              )
            ],
          ),
        ),
      ),
    ],
  );
}

//search delegate
class Specialists {
  String image;
  String tagname;
  Specialists(this.image, this.tagname);
}

//shop info tabs
class ShopHome extends StatefulWidget {
  const ShopHome({Key? key}) : super(key: key);

  @override
  _ShopHomeState createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> with TickerProviderStateMixin {
  // int initial = 0;
  // TabController tabController =
  //     TabController(
  //       initialIndex: 0,
  //       length: 4, vsync: );

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
          floatingActionButton:FloatingActionButton(onPressed: (){
             Navigator.push(context,
              MaterialPageRoute(builder: (contex) {
            return const BookAppointment();
          }));
          },
          child:FaIcon(FontAwesomeIcons.book)
          ),
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
                    text: "About",
                  ),
                  Tab(
                    text: "Services",
                  ),
                  Tab(
                    text: "Gallery",
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
              Services(context),
              Newgallery(context),
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

Widget Services(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
         Padding(
           padding: const EdgeInsets.all(3.0),
           child: Container(
              padding: EdgeInsets.zero,
             decoration: BoxDecoration(
              border: Border.all(
                color: Colors.orange
              ),
              borderRadius:BorderRadius.circular(10)
            ),
            height: 70,
            child: Row(
              children: [
Container(
  height:70,
  width: 50,
  child:  Image.asset("images/lovecut.jpg",fit: BoxFit.cover,),
),
                Expanded(
                  child: ListTile(
                   
                    title: Text("Hair shaving"),
                    subtitle: Text("Find styles"),
                    trailing: Text("20 GHS",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            ),
        ),
         )
        ,
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
              padding: EdgeInsets.zero,
             decoration: BoxDecoration(
              border: Border.all(
                color: Colors.orange
              ),
              borderRadius:BorderRadius.circular(10)
            ),
            height: 70,
            child: Row(
              children: [
Container(
  height:70,
  width: 50,
  child:  Image.asset("images/lovecut.jpg",fit: BoxFit.cover,),
),
                Expanded(
                  child: ListTile(
                   
                    title: Text("Hair coloring"),
                    subtitle: Text("Find styles"),
                    trailing: Text("20 GHS",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
              padding: EdgeInsets.zero,
             decoration: BoxDecoration(
              border: Border.all(
                color: Colors.orange
              ),
              borderRadius:BorderRadius.circular(10)
            ),
            height: 70,
            child: Row(
              children: [
Container(
  height:70,
  width: 50,
  child:  Image.asset("images/lovecut.jpg",fit: BoxFit.cover),

),
                Expanded(
                  child: ListTile(
                   
                    title: Text("Beard Trim"),
                    subtitle: Text("Find styles"),
                    trailing: Text("20 GHS",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

//old gallery
Widget Gallery(BuildContext context) {
  return SingleChildScrollView(
    child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 9.8,
        child: GridView.builder(
            itemCount: 7,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2),
            itemBuilder: (context, photos) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage("images/manshaving.jpg"),
                        fit: BoxFit.cover)),
                height: 150,
                child: Text("Nice fade"),
              );
            }),
      ),
    ),
  );
}

List urls = [
  "images/logo.png",
  "images/salon.jpg",
  "images/styling.jpg",
  "images/nicesalon.jpg",
  "images/lovecut.jpg"
];
//new gallery
Widget Newgallery(BuildContext context) {
  return CustomScrollView(
    primary: false,
    slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.all(20),
        sliver: SliverGrid.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            
            children: List.generate(urls.length, (index) {
              return Container(
                  height: index%2==1?70:50,
                  child: Image.asset(
                    urls[index],
                    fit: BoxFit.cover,
                  )
                  );
            })),
      ),
    ],
  );
}

//old gallery ends here
Widget Review(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Shop reviews"),
        ),
       
        ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (BuildContext context, int index) {
            return ListView(
              shrinkWrap: true,
              children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: reviewCard(
                      items[index]["img"],
                      items[index]["name"],
                      items[index]["date"],
                      items[index]["time"],
                      items[index]["message"]),
               ),
               
              ],
            );
          },
        ),
      ],
    ),
  );
}

Widget reviewCard(
    String img, String name, String date, String time, String message) {
  return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      leading: CircleAvatar(
        backgroundImage: AssetImage(img),
      ),
      title: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Text(name),
            Spacer(),
            Text(time),
          ],
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(children: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.star_border, color: Colors.yellow)),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.star_border, color: Colors.yellow)),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.star_border, color: Colors.yellow)),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.star_border,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.star_border,
              )),
        ]),
      ));
}

List items = [
  {
    "img": "images/nicesalon.jpg",
    "name": "Kay",
    "date": "20th Oct",
    "time": "12:00 pm",
    "message": "Hello"
  },
  {
    "img": "images/salon.jpg",
    "name": "Joe",
    "date": "20th Oct",
    "time": "12:00 pm",
    "message": "Are you there?"
  },
];
