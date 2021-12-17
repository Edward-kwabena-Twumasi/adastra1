//this is the the client homescreen
//the home sreen features a rounded-bottom header container
//white contains a search bar
//it gives a gist to users on which services are available to find
//listed for them at screen load are best rated shops based on customer ratings
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
//import 'package:thecut/screens/updated_screens/newbarber/barber_main_screen.dart';
import 'package:thecut/screens/updated_screens/newshop/shop_about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //declase isloading
  late bool isLoading = false;
  late Timer _timer;
  int _start = 2;

  void startTimer() {}

  String client = "";
  void initState() {
    super.initState();
    setState(() {
      isLoading =
          Provider.of<ApplicationProvider>(context, listen: false).isLoading;
      print(isLoading);
    });
    Provider.of<ApplicationProvider>(context, listen: false)
        .getUser()
        .then((value) {
      setState(() {
        client = value.data()!["name"];
      });
    });

    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
                //wrap the parent widget in the big shimmer
                child: Shimmer(
                  linearGradient: _shimmerGradient,
                  child: ListView(padding: EdgeInsets.zero,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //tags or popular categories
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text("Popular categories",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        SizedBox(
                            height: 95,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Categories(icon: Icons.cut),
                                Categories(icon: FontAwesomeIcons.female)
                              ],
                            )),
                        //best shops
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Best rated salons",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        SizedBox(
                            height: 100,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("shops")
                                  .snapshots(),
                              builder: (BuildContext,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshots) {
                                if (snapshots.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: Material(
                                    child: SpinKitPouringHourGlassRefined(
                                      color: Colors.black,
                                    ),
                                  ));
                                } else if (snapshots.hasError) {
                                  return Material(
                                    child: Center(
                                      child: Text('Oops,an error occured'),
                                    ),
                                  );
                                } else if (snapshots.hasData) {
                                  // Provider.of<ApplicationProvider>(context,
                                  //         listen: false)
                                  //     .isLoading = false;
                                }
                                return snapshots.data!.size < 1
                                    ? Center(child: Text("No shops yet!"))
                                    : ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: snapshots.data!.docs
                                            .map(
                                              (doc) => ShimmerLoading(
                                                  isLoading: isLoading,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Provider.of<ApplicationProvider>(
                                                              context,
                                                              listen: false)
                                                          .setShopId(
                                                              doc["phone"]);
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (contex) {
                                                        return const AboutShop();
                                                      }));
                                                    },
                                                    child: SalonCards(
                                                        "images/salon.jpg",
                                                        doc["name"],
                                                        3.0,
                                                        doc["phone"],
                                                        context,
                                                        isLoading),
                                                  )),
                                            )
                                            .toList());
                              },
                            )),
                        //suggeted
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Suggested for you",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        SizedBox(
                            height: 100,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("shops")
                                  .snapshots(),
                              builder: (BuildContext,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshots) {
                                if (snapshots.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: Material(
                                    child: SpinKitPouringHourGlassRefined(
                                      color: Colors.black,
                                    ),
                                  ));
                                } else if (snapshots.hasError) {
                                  return Material(
                                    child: Center(
                                      child: Text('Oops,an error occured'),
                                    ),
                                  );
                                }
                                return snapshots.data!.size < 1
                                    ? Center(child: Text("No shops yet!"))
                                    : ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: snapshots.data!.docs
                                            .map(
                                              (doc) => ShimmerLoading(
                                                  isLoading: isLoading,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Provider.of<ApplicationProvider>(
                                                              context,
                                                              listen: false)
                                                          .setShopId(
                                                              doc["phone"]);
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (contex) {
                                                        return const AboutShop();
                                                      }));
                                                    },
                                                    child: SalonCards(
                                                        "images/salon.jpg",
                                                        doc["name"],
                                                        3.0,
                                                        doc["phone"],
                                                        context,
                                                        isLoading),
                                                  )),
                                            )
                                            .toList());
                              },
                            ))
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
            child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                color: Colors.white),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ClipPath(
            clipper: ClipPathClass(),
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "images/welcome.png",
                          ),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.4)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.white.withOpacity(0.4)),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Hi ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              TextSpan(
                                  text: client,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22)),
                              TextSpan(
                                  text: ",You are welcome",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))
                            ]))),
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
class Categories extends StatelessWidget {
  const Categories({Key? key, required this.icon}) : super(key: key);
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.red.shade50,
        child: IconButton(
          onPressed: () {},
          icon: Icon(icon),
          color: Colors.black,
        ),
      ),
    );
  }
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
        BuildContext context, bool isLoading) =>
    SizedBox(
        height: 81,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),

                  // image: DecorationImage(
                  //     image: AssetImage(
                  //       image,
                  //     ),
                  //     fit: BoxFit.cover)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://flutter'
                    '.dev/docs/cookbook/img-files/effects/split-check/Avatar1.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              isLoading
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    )
                  : Expanded(
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(name),
                            Wrap(children: [
                              Text(rating.toString(), textAlign: TextAlign.end),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              )
                            ]),
                          ],
                        ),
                        subtitle: Text(description),
                      ),
                    ),
            ],
          ),
        ));

//shimmer loading class takes isloading boolean and a
//child returns shimmer if is loading and the widget if done loading
class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  _ShimmerLoadingState createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable? _shimmerChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {
        // update the shimmer painting.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    // Collect ancestor shimmer information.
    final shimmer = Shimmer.of(context)!;
    if (!shimmer.isSized) {
      // The ancestor Shimmer widget isn’t laid
      // out yet. Return an empty box.
      return SizedBox();
    }
    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    final offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
    );

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(
            -offsetWithinShimmer.dx,
            -offsetWithinShimmer.dy,
            shimmerSize.width,
            shimmerSize.height,
          ),
        );
      },
      child: widget.child,
    );
  }
}

//Define a chrome-colored, linear gradient that gets applied to the shimmer shapes.
const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

//giant shimmer
class Shimmer extends StatefulWidget {
  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

  const Shimmer({
    Key? key,
    required this.linearGradient,
    this.child,
  }) : super(key: key);

  final LinearGradient linearGradient;
  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  Listenable get shimmerChanges => _shimmerController;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  Gradient get gradient => LinearGradient(
        colors: widget.linearGradient.colors,
        stops: widget.linearGradient.stops,
        begin: widget.linearGradient.begin,
        end: widget.linearGradient.end,
        transform:
            _SlidingGradientTransform(slidePercent: _shimmerController.value),
      );

  bool get isSized => (context.findRenderObject() as RenderBox).hasSize;

  Size get size => (context.findRenderObject() as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

//now lets animate our shimmer loading gradient
class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
