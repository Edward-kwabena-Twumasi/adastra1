//this is the the client homescreen
//the home sreen features a rounded-bottom header container
//white contains a search bar
//it gives a gist to users on which services are available to find
//listed for them at screen load are best rated shops based on customer ratings
import 'package:flutter/material.dart';
import 'package:thecut/screens/NewClient/nested_scroll.dart';
import 'package:thecut/screens/newshop/shop_about_screen.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  //list of category objects
  List<Tags> categories = [
    Tags("images/nicesalon.jpg", "Salon"),
    Tags("images/hairapist.jpg", "Hair cut"),
    Tags("images/lovecut.jpg", "Styling")
  ];
  //list of salon objects
  List<Salons> salons = [
    Salons("images/nicesalon.jpg", "Afias Salon", 4.3,
        "Unisex salon located at Adenta"),
    Salons("images/barbclip.jpg", "American barbers", 4.2,
        "Unisex Barbering shop located at Tech")
  ];
  //A stack is used to create the aligning effect and overlaying
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //first child of parent stack aligned at bottom container most of the
        //information on the client home screen
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //tags or popular categories
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        const Text("Services you will find",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18)),
                        const SizedBox(
                          height: 3,
                        ),
                        SizedBox(
                          height: 90,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              itemBuilder: (buildContext, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: (){
                                       Navigator.push(context, MaterialPageRoute(builder: (contex) {
                          return const MyStatelessWidget();
                        }));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 70,
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: const LinearGradient(
                                                colors: [
                                                  Colors.pink,
                                                  Colors.indigo
                                                ],
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight),
                                          ),
                                          child: Image.asset(
                                              categories[index].image,
                                              fit: BoxFit.cover),
                                        ),
                                        ShaderMask(
                                            shaderCallback: (shader) {
                                             return LinearGradient(colors: [
                                                Colors.pink,
                                                Colors.indigo
                                              ]).createShader(shader);
                                            },
                                            child:
                                                Text(categories[index].tagname))
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        //best shops
                        SizedBox(
                          height: 10,
                        ),
                        Text("Best rated salons",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 18)),
                        SizedBox(
                          height: 3,
                        ),
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: salons.length,
                              itemBuilder: (buildContext, index) {
                                return SalonCards(
                                    salons[index].image,
                                    salons[index].name,
                                    salons[index].rating,
                                    salons[index].description,
                                    context);
                              }),
                        )
                      ]),
                ),
              )),
        ),
        //An aligned containeer at the top ,child of the parent stack
        //it also contains a stack to create the overlay effect
        Align(
          alignment: Alignment.topCenter,
          child: ClipPath(
            clipper: ClipPathClass(),
            child: Stack(
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Find and book appointment ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22)),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 20,
                            child: TextField(
                                decoration: InputDecoration(
                                    hintText: "find shop",
                                    fillColor: Colors.white.withOpacity(0.5),
                                    filled: true))),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//tags model class
class Tags {
  String image;
  String tagname;
  Tags(this.image, this.tagname);
}

//salons model class
class Salons {
  String image;
  String name;
  double rating;
  String description;

  Salons(this.image, this.name, this.rating, this.description);
}

Widget SalonCards(String image, String name, double rating, String description,
    BuildContext context) {
  return Container(
    width: 250,
    height: 170,
    child: GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (contex) {
          return const AboutShop();
        }));
      },
      child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            image,
                          ),
                          fit: BoxFit.cover))),
              ListTile(
                title: Row(
                  children: [
                    Text(name),
                    Spacer(),
                    Text(rating.toString(), textAlign: TextAlign.end),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    )
                  ],
                ),
                subtitle: Text(description),
              ),
            ],
          )),
    ),
  );
}
