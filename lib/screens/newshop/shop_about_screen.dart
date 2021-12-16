import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:thecut/screens/NewClient/client_home_screen.dart';
//import 'package:thecut/screens/NewClient/nearby_screen.dart';
import 'package:thecut/screens/Shop/shop_home_screen.dart';
//import 'package:thecut/screens/newbarber/barber_main_screen.dart';
import 'package:thecut/screens/newshop/book_appointment_screen.dart';
import 'package:thecut/screens/newshop/shop_dashboard_screen.dart';
import 'package:thecut/screens/newshop/shop_main_screen.dart';

class AboutShop extends StatefulWidget {
  const AboutShop({Key? key}) : super(key: key);

  @override
  AboutShopState createState() => AboutShopState();
}

class AboutShopState extends State<AboutShop> {
  //BuildContext context =ScaffoldState().context;
  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
  //List<String> titles = ["", "Payment", "Notifications", "History"];

  List<Tags> specialists = [
    Tags("images/salon.jpg", "Lord"),
    Tags("images/haircut.jpg", "King"),
    Tags("images/styling.jpg", "Manny")
  ];
  int index = 0;
  bool showsearch = true;

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
          
          expandedHeight: MediaQuery.of(context).size.height*0.36,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: [
              StretchMode.zoomBackground,
              StretchMode.blurBackground
            ],
            background: Header(context),
          ),
        ),
            SliverFillRemaining(
              
              child: Wrap(
                 
                  children: [
                    //tags or popular categories
                    //This top widgget is the shop specialists tab
                    // Padding(
                    //   padding: const EdgeInsets.all(5.0),
                    //   child: const Text("Shop Specialists",
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.w300,
                    //           fontSize: 18)),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // SizedBox(
                    //   height: 80,
                    //   child: ListView.builder(
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: specialists.length,
                    //       itemBuilder: (buildContext, index) {
                    //         return Padding(
                    //           padding: const EdgeInsets.all(4.0),
                    //           child: GestureDetector(
                    //             onTap: () {
                    //               Navigator.push(context,
                    //                   MaterialPageRoute(
                    //                       builder: (contex) {
                    //                 return const BarberMainScreen();
                    //               }));
                    //             },
                    //             child: Column(
                    //               children: [
                    //                 SizedBox(
                    //                   height: 50,
                    //                   width: 50,
                    //                   child: CircleAvatar(
                    //                       backgroundImage: AssetImage(
                    //                           specialists[index]
                    //                               .image)),
                    //                 ),
                    //                 Text(specialists[index].tagname)
                    //               ],
                    //             ),
                    //           ),
                    //         );
                    //       }),
                    // ),
                    //best shops
                    SizedBox(height: MediaQuery.of(context).size.height*0.55,
                    
                     child: ShopHome())
                  ]),
            ),
          ],
        ));
  }
}

Widget Header(BuildContext context) {
  return  Stack(
    children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "images/nicesalon.jpg",
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
              ListTile(
                  title: Text("Best Street Salon ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 19)),
                  subtitle: Text("Obuasi mangoase road",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ))),
              SizedBox(
                height: 3,
              ),
              Container(
                  height: 40,
                  child: Row(children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.star_border,
                            color: Colors.white)),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.star_border,
                            color: Colors.white)),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.star_border,
                            color: Colors.white)),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.star_border,
                            color: Colors.white)),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.star_border,
                            color: Colors.white)),
                  ])),
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
                          icon: Icon(Icons.web,
                              color: Colors.white)),
                      Text("Website",
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
          floatingActionButtonLocation:FloatingActionButtonLocation.endDocked,
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
        ListTile(
          leading: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.grey),
                BoxShadow(color: Colors.black),
                BoxShadow(color: Colors.grey),
                BoxShadow(color: Colors.amber),
              ]),
              child: Image.asset("images/lovecut.jpg")),
          title: Row(
            children: [
              Text("Hair cut"),
              Spacer(),
              Text("15 GHS",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.white)),
            ],
          ),
          subtitle: Text("Find styles"),

        ),
        ListTile(
          leading: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.grey),
                BoxShadow(color: Colors.black),
                BoxShadow(color: Colors.grey),
                BoxShadow(color: Colors.amber),
              ]),
              child: Image.asset("images/lovecut.jpg")),
          title: Row(
            children: [
              Text("Hair styling"),
              Spacer(),
              Text("20 GHS",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          subtitle: Text("Find styles"),

        ),
        ListTile(
          leading: Container(
              decoration: BoxDecoration(),
              child: Image.asset("images/lovecut.jpg")),
          title: Row(
            children: [
              Text("Hair coloring"),
              Spacer(),
              Text("7 GHS",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
          subtitle: Text("Find styles"),

        )
      ],
    ),
  );
}

//old gallery
// Widget Gallery(BuildContext context) {
//   return SingleChildScrollView(
//     child: MediaQuery.removePadding(
//       context: context,
//       removeTop: true,
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height * 9.8,
//         child: GridView.builder(
//             itemCount: 7,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2),
//             itemBuilder: (context, photos) {
//               return Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                         image: AssetImage("images/manshaving.jpg"),
//                         fit: BoxFit.cover)),
//                 height: 150,
//                 child: Text("Nice fade"),
//               );
//             }),
//       ),
//     ),
//   );
// }

List urls = [
  "images/logo.png",
  "images/nicesalon.jpg",
  "images/hairapist.jpg",
  "images/barbershop.jpg",
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
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            crossAxisCount: 2,
            
            children: List.generate(urls.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: Wrap(
                  children: [
                    Card(
                        elevation: 3,
                        child: Image.asset(
                          urls[index],

                        )
                        ),
                    Text("Style " + index.toString())
                  ],
                ),
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
          padding: const EdgeInsets.all(5.0),
          child: Text("Shop reviews"),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: ListTile(
            title: TextField(
              decoration: InputDecoration(
                hintText: "Write review"
              ),

            ),
            subtitle: TextButton(onPressed: (){},
            child: Text("Submit"),),
          ),
        ),

        ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Card(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: chatCard(
                          items[index]["img"],
                          items[index]["name"],
                          items[index]["date"],
                          items[index]["time"],
                          items[index]["message"]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("This cut was pretty cool for me"),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

Widget chatCard(
    String img, String name, String date, String time, String message) {
  return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      leading: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.amber)),
          child: CircleAvatar(
            backgroundImage: AssetImage(img),
          )),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(name),
            Spacer(),
            Text(time),
          ],
        ),
      ),
      subtitle: Container(
        height: 20,
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
    "img": "images/barbclip.jpg",
    "name": "Joe",
    "date": "20th Oct",
    "time": "12:00 pm",
    "message": "Are you there?"
  },
];

class Tags{
  String image;String tagname;
  Tags(this.image,this.tagname);
}