import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/Shop/shop_appointments_screen.dart';
import 'package:thecut/screens/Shop/shop_clients_screen.dart';
import 'package:thecut/screens/Shop/shop_notification_screen.dart';

// void main() {
//   runApp(Shop());
// }
//
// var urls = [
//   "https://i.pinimg.com/originals/c0/42/05/c04205e9ceea185248a2fea57a097013.jpg",
//   "https://lh4.googleusercontent.com/cagmRTOuku0HdjeIddWnn08Hbux8JMT2tbp22XM7f5qU6xw5Ak3T0zqbWoUixfw7B4IcdDZ0HMx7f_BIE8NJPhMbwO9FgfY4lqciL5xmMP8EFY4osPcvh8BqZj1YFTDkTvg2ZH8W",
//   "https://i.pinimg.com/originals/40/12/e0/4012e065e6d4fd525ac9c43e15731ab1.jpg",
//   "https://content.latest-hairstyles.com/wp-content/uploads/temp-fade-haircuts-1000x690.jpg",
//   "https://media.gq.com/photos/575841b355243a9335f33944/master/w_2000,h_2666,c_limit/the-barbershop-fade-gq-style-0616-04.jpg",
//   "https://i.pinimg.com/736x/ab/bb/78/abbb78a5f1e835497fef8ea6254041cb.jpg"
// ];

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => ShopState();
}

class ShopState extends State<Shop> {
  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
  List<String> titles = ["Home", "Notifications", "Appointments", "Clients"];


  static List<Widget> pages = [
    ShopHome()
    ,
    //appointments

    shopNotifications(),
//appointmens
    shopAppointments(),
    //Clients
    shopClients()
  ];
  int currentindx = 0;

  void swithnav(int value) {
    setState(() {
      currentindx = value;
    });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(titles.elementAt(currentindx),style:TextStyle(color:Colors.black)),
          backgroundColor: Colors.white,
          actions: [IconButton(onPressed: () {
            scaffolKey.currentState!.openEndDrawer();

          }, icon: Icon(Icons.menu,color:Colors.black))],
        ),
        endDrawer: SizedBox(
          width: 300,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Align(
                  alignment: Alignment(-1, 1),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 4,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: Image.asset(
                    "images/lovecut.jpg",
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                ),
                ListTile(
                  title: Center(child: Text("shop admin")),
                  subtitle: Center(
                    child: Text(
                      "rdoetothemoon@gmail.com",
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, -1),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                  thickness: 3,
                  color: Colors.black,
                ),
                //end of top container
                Expanded(
                    child: Column(children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (contex) {
                        return const Text(" ");
                      }));
                    },
                    leading: Icon(Icons.watch),
                    title: const Text(
                      "Appointments",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (contex) {
                        return const Text("");
                      }));
                    },
                    leading: Icon(Icons.people),
                    title: Text("My barbers", style: TextStyle(fontSize: 16)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    leading: Icon(Icons.lens),
                    title: Text("Shop lookup", style: TextStyle(fontSize: 16)),
                  )
                ]))
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.black,
          selectedIconTheme: IconThemeData(color: Colors.amber, size: 40),
          currentIndex: currentindx,
          onTap: swithnav,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.watch),
              label: 'Appointments',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Clients',
            ),
          ],
        ),
        body: pages.elementAt(currentindx));
  }
}

Widget TopBox(BuildContext context) {
  final appProv=Provider.of<ApplicationProvider>(context,listen:false);

  CollectionReference shops = FirebaseFirestore.instance.collection('shops');
  return Stack(children: [
    FutureBuilder(
      future: shops.doc(appProv.phoneNumber).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if(!snapshot.hasData){
            return Center(
              child:CircularProgressIndicator()
            );
          }


          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/barbershop.jpg'),
                    fit: BoxFit.cover)),
            height: 230,
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                      (snapshot.data!.data() as Map<String,dynamic>)['name'] ,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 26),
                  ),
                )),
          );
        })

    // Align(
    //   alignment: Alignment.bottomRight,
    //   child: Container(
    //     height: 60,
    //     width: 600,
    //     child: Card()
    //   ),
    // )
  ]);
}

class ShopHome extends StatefulWidget {
  const ShopHome({Key? key}) : super(key: key);

  @override
  _ShopHomeState createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> {
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          stretch: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.pink,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 6,
          expandedHeight: 230,
          flexibleSpace: FlexibleSpaceBar(
            background: TopBox(context),
          ),
        ),
        SliverFillRemaining(
          child: Container(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(50),
                      child: AppBar(
                        titleSpacing: 0,
                        backgroundColor: Colors.black,
                        elevation: 6,
                        bottom: TabBar(
                          indicatorColor: Colors.black,
                          tabs: [
                            Tab(
                              text: "Basic Info",
                            ),
                            Tab(
                              text: "Ratings",
                            ),
                            Tab(
                              text: "Account",
                            ),
                          ],
                        ),
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        //info pane
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              //working days
                              DaysTime(false),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Services", style: header),
                              ),
                              //services
                              Services(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Barbers", style: header),
                              ),
                              //barbers
                              Barbers(),
                            ],
                          ),
                        ),
                        //ratings pane
                        SingleChildScrollView(child: Ratings()),
                        //Account and settings

                        Portfolio()
                      ],
                    ),
                  ),
                ),
              )),
        )
      ],
    );



     ;
  }
}

var stylehead = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
var header =
    TextStyle(fontWeight: FontWeight.w300, fontSize: 25, color: Colors.pink);
var stylesub = TextStyle(fontWeight: FontWeight.normal, fontSize: 18);

//Details page
Widget Details() {
  return ExpansionTile(
    title: Text(
      "Shop info",
      style: stylehead,
    ),
    children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
            leading: Icon(Icons.person),
            title: Text(
              "Name",
              style: stylehead,
            ),
            subtitle: Text(
              "Street Cutz",
              style: stylesub,
            ),
            trailing: IconButton(
                onPressed: () {}, icon: FaIcon(FontAwesomeIcons.edit))),
      ),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
            leading: Icon(Icons.phone),
            title: Text(
              "Phone",
              style: stylehead,
            ),
            subtitle: Text(
              "0271302702",
              style: stylesub,
            ),
            trailing: IconButton(
                onPressed: () {}, icon: FaIcon(FontAwesomeIcons.edit))),
      ),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
            leading: Icon(Icons.cut),
            title: Text(
              "Location",
              style: stylehead,
            ),
            subtitle: Text(
              "Obiri Yeboah Street,Kumasi",
              style: stylesub,
            ),
            trailing: IconButton(
                onPressed: () {}, icon: FaIcon(FontAwesomeIcons.edit))),
      ),
    ],
  );
}

//days and time
Widget DaysTime(bool editable) {
  return ExpansionTile(
    title: Text(
      "Monday to Friday",
      style: stylehead,
    ),
    children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
            tileColor: Colors.blueAccent[100],
            title: Text(
              "Monday",
              style: stylehead,
            ),
            subtitle: Text(
              "08:00 am - 05:30 pm",
              style: stylesub,
            )),
      ),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
            tileColor: Colors.blueAccent[100],
            title: Text(
              "Tuesday",
              style: stylehead,
            ),
            subtitle: Text(
              "08:00 am - 05:30 pm",
              style: stylesub,
            ),
            trailing: editable
                ? IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                : null),
      ),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
            tileColor: Colors.blueAccent[100],
            title: Text(
              "Wednesday",
              style: stylehead,
            ),
            subtitle: Text(
              "08:00 am - 05:30 pm",
              style: stylesub,
            )),
      ),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
            tileColor: Colors.blueAccent[100],
            title: Text(
              "Thursday",
              style: stylehead,
            ),
            subtitle: Text(
              "08:00 am - 05:30 pm",
              style: stylesub,
            ),
            trailing: editable
                ? IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                : null),
      ),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
            tileColor: Colors.blueAccent[100],
            title: Text(
              "Friday",
              style: stylehead,
            ),
            subtitle: Text(
              "08:00 am - 05:30 pm",
              style: stylesub,
            ),
            trailing: editable
                ? IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                : null),
      ),
    ],
  );
}

//ratings
Widget Ratings() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 3,
          child: Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text(
                    "Bro Kwaku",
                    style: stylehead,
                  ),
                  subtitle: Text("Haircut on Monday"),
                ),
                Divider(thickness: 2),
                Stars(4),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Cut was pretty great",
                    style: stylesub,
                  ),
                ),
                Divider(thickness: 7),
                ButtonBar(children: [
                  IconButton(
                      onPressed: () {}, icon: FaIcon(FontAwesomeIcons.reply)),
                  IconButton(
                      onPressed: () {}, icon: FaIcon(FontAwesomeIcons.heart))
                ])
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 3,
          child: Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text(
                    "Bro Kwaku",
                    style: stylehead,
                  ),
                  subtitle: Text("Haircut on Monday"),
                ),
                Divider(thickness: 2),
                Stars(5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "This cut was excellent!",
                    style: stylesub,
                  ),
                ),
                Divider(thickness: 7),
                ButtonBar(children: [
                  IconButton(
                      onPressed: () {}, icon: FaIcon(FontAwesomeIcons.reply)),
                  IconButton(
                      onPressed: () {}, icon: FaIcon(FontAwesomeIcons.heart))
                ])
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget Stars(int stars) {
  return Container(
    height: 15,
    child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(stars, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5, right: 5),
            child: Icon(
              Icons.star,
              color: Colors.black,
            ),
          );
        })),
  );
}

/*Widget Works() {
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
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Card(
                        elevation: 3,
                        child: Image.network(
                          urls[index],
                          height: 130,
                          width: 210,
                        )),
                    Text("Style " + index.toString())
                  ],
                ),
              );
            })),
      ),
    ],
  );
}*/

Widget Services() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                "Hair Cut",
                style: stylesub,
              ),
              subtitle: Text("Nice cuts"),
              isThreeLine: true,
              trailing: Text(
                "20 GHS",
                style: stylehead,
              ),
            ),
          ),
          Divider(
            thickness: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                "Beard Trimming",
                style: stylesub,
              ),
              subtitle: Text("Nice beard trims"),
              isThreeLine: true,
              trailing: Text(
                "5 GHS",
                style: stylehead,
              ),
            ),
          ),
          Divider(
            thickness: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                "Hair Coloring",
                style: stylesub,
              ),
              subtitle: Text("Nice hair colors"),
              isThreeLine: true,
              trailing: Text(
                "10 GHS",
                style: stylehead,
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget Barbers() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                "Joe Boy",
                style: stylesub,
              ),
              trailing: IconButton(
                  onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
            ),
          ),
          Divider(
            thickness: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                "Yaw",
                style: stylesub,
              ),
              trailing: IconButton(
                  onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget PayAccounts(BuildContext context) {
  return Column(children: [
    AccountNumber("0249806280", "MOMO", context),
    AccountNumber("123456789897667", "GCB", context),
  ]);
}

Widget AccountNumber(String number, String bank, BuildContext context) {
  return Card(
    child: ListTile(
      title: Text(number, style: Theme.of(context).textTheme.headline4),
      subtitle: Text(bank, style: Theme.of(context).textTheme.caption),
      trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
    ),
  );
}

Widget PlanBillsPayments() {
  return Card(
    child: Container(
      child: Column(
        children: [
          Text("Free trial"),
          Text("10 days left"),
          ButtonBar(children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(padding: EdgeInsets.all(8)),
              onPressed: () {},
              label: Text("Available plans"),
              icon: Icon(Icons.arrow_forward),
            )
          ])
        ],
      ),
    ),
  );
}

Widget Portfolio() {
  return Container(
    child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 2.0, mainAxisSpacing: 2.0),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 0.0,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
                height: index.isEven ? 70 : 50,
                child: Image.network(
                    "https://cdn.dribbble.com/users/5031392/screenshots/13869046/media/d66c1320f4c68ecc2e7a80e57813460a.png",
                    fit: BoxFit.cover)),
          );
        }),
  );
}
