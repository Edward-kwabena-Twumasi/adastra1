import 'dart:async';

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
//import 'package:thecut/screens/NewClient/client_home_screen.dart';
import 'package:thecut/screens/newshop/book_appointment_screen.dart';
import 'package:thecut/screens/newshop/shop_main_screen.dart';

//import 'package:theshave/screens/Shop/shop_home_screen.dart';

class AboutShop extends StatefulWidget {
  final String shopId;
  const AboutShop({Key? key, required this.shopId}) : super(key: key);

  @override
  AboutShopState createState() => AboutShopState();
}

class AboutShopState extends State<AboutShop> {
  //BuildContext context =ScaffoldState().context;
  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
  /* late String shopname = "";
  late String shopMail = "";*/

  late StreamSubscription shopSubscription;
  //List<String> titles = ["", "Payment", "Notifications", "History"];
  Map<String, dynamic> shop = {"name": "", "landmark": ""};

  int index = 0;
  bool showsearch = true;

  @override
  void initState() {
    super.initState();
    shopSubscription = Provider.of<ApplicationProvider>(context, listen: false)
        .getShopForUser(widget.shopId)
        .listen((event) {
      setState(() {
        shop = event.data()!;
        print(shop);
        /*shopname=event.data()!['name'];
        shopMail=event.data()!['email'];*/
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffolKey,
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Scaffold(
            body: CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  stretch: true,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 6,
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Header(context, shop),
                  ),
                ),
                SliverFillRemaining(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.60,
                      child: ShopHome(
                        shopId: widget.shopId,
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  Widget Header(BuildContext context, Map<String, dynamic> shop) {
    ApplicationProvider provider() {
      return Provider.of<ApplicationProvider>(context, listen: false);
    }

    List<dynamic> favorites = provider().userDetails["favorites"];
    bool isFavorite =
        favorites.any((element) => element["shop_id"] == shop["uid"]);

    print(favorites.any((element) => element["shop_id"] == shop["uid"]));
    return Stack(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    'https://d2zdpiztbgorvt.cloudfront.net/region1/us/270012/biz_photo/7d1a76a087e84fa4b4e0ca73120aa8-Alphas-Cutz-biz-photo-e14e8d52566246d6a3a2e3ac578893-booksy.jpeg?size=640x427',
                  ),
                  fit: BoxFit.cover),
            )),
        Positioned(
          left: 15,
          bottom: 50,
          child: Text(
            shop["name"],
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white),
          ),
        ),
        Positioned(
          left: 15,
          bottom: 30,
          child: Text(
            shop["landmark"],
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        Positioned(
          left: 15,
          bottom: 12,
          child: RatingBar.builder(
            initialRating: 3.5,
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            tapOnlyMode: false,
            updateOnDrag: false,
            itemSize: 20,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
              size: 9.0,
            ),
            onRatingUpdate: (double value) {},
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(color: Colors.transparent)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
                onPressed: () {
                  String? thisclient =
                      Provider.of<ApplicationProvider>(context, listen: false)
                          .phoneNumber;
                  if (isFavorite) {
                    FirebaseFirestore.instance
                        .collection("clients")
                        .doc(thisclient)
                        .update({
                      'favorites': FieldValue.arrayRemove([
                        {"shop_id": shop["uid"], "name": shop["name"]}
                      ])
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Removed from Favourites'),
                      ));
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                      // print("Shop "+shop["uid"]+"added to favorites");
                    });
                  } else {
                    FirebaseFirestore.instance
                        .collection("clients")
                        .doc(thisclient)
                        .update({
                      'favorites': FieldValue.arrayUnion([
                        {"shop_id": shop["uid"], "name": shop["name"]}
                      ])
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Added to Favourites'),
                      ));
                       setState(() {
                        isFavorite = !isFavorite;
                      });
                      // print("Shop "+shop["uid"]+"added to favorites");
                    });
                  }
                },
                icon: Icon(
                 isFavorite ?FontAwesomeIcons.solidHeart:FontAwesomeIcons.heart,
                  color: isFavorite ? Colors.red : Colors.white,
                  size:isFavorite ? 30:24 ,
                ))
          ],
        ),
        //Book button
        Positioned(
            bottom: 7,
            right: 9,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: StadiumBorder(),
                    primary: Colors.black54,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    side: BorderSide(color: Colors.white, width: 1.5)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (contex) {
                    return BookAppointment(
                        shopId: shop["uid"], shopName: shop["name"]);
                  }));
                },
                child: Text(
                  "Book",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                )))
      ],
    );
  }
}

//item class for expansionpansel list
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> items = [
  Item(expandedValue: "This is info about this shop", headerValue: "About"),
  Item(expandedValue: "Shop opening hours", headerValue: "Opening Hours"),
  Item(expandedValue: "Shop opening Facilities", headerValue: "Facilities"),
  Item(expandedValue: "Shop contact info", headerValue: "Contact"),
];
//the header widget

class Specialists {
  String image;
  String tagname;

  Specialists(this.image, this.tagname);
}

//shop info tabs
class ShopHome extends StatefulWidget {
  final String shopId;
  ShopHome({Key? key, required this.shopId}) : super(key: key);

  @override
  _ShopHomeState createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> with TickerProviderStateMixin {
  List<Map<String, dynamic>> shopProducts = [];
  late StreamSubscription shopProductSubscription;

  @override
  initState() {
    super.initState();
    print("Init of SHOP HOME");
    setState(() {
      shopProductSubscription = FirebaseFirestore.instance
          .collection('shop_styles')
          .doc(widget.shopId)
          .collection('style')
          .snapshots()
          .listen((event) {
        setState(() {
          shopProducts = [];
        });
        print(event.docs.length);

        for (var style in event.docs) {
          //print(oldStyle.data().runtimeType);
          print('HERE');
          print(style.data());
          setState(() {
            shopProducts.add(style.data());
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Shop ID: ${widget.shopId}");
    return DefaultTabController(
      length: 4,
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
            Center(
              child: Text("Reviews of shop"),
            )
            //Review(context)
          ],
        ),
      ),
    );
  }

//shop about info

  Widget About(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                items[index].isExpanded = !isExpanded;
              });
            },
            children: items.map<ExpansionPanel>((Item item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 4),
                    child: Text(
                      item.headerValue,
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  );
                },
                body: Text(item.expandedValue),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget Services(BuildContext context) {
    return shopProducts.length == 0
        ? Center(child: Text('No Products'))
        : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: shopProducts
                  .map((e) => ShopDisplayProduct(e['name'], e['price']))
                  .toList(),
            ),
          );
  }

  Widget ShopDisplayProduct(String title, String price) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          minVerticalPadding: 0,

          leading: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/cutcut.png"),
                        fit: BoxFit.cover)),
                width: 60,
                height: 60,
              )),
          title: Text(title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          // subtitle: Text(category,style: TextStyle(fontSize: 11),),
          trailing: Text(
            "GH¢ $price",
          ),
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
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 2,
              children: List.generate(urls.length, (index) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      urls[index],
                      fit: BoxFit.cover,
                    ));
              })),
        ),
      ],
    );
  }

//old gallery ends here

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
}
