import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/newshop/shop_about_screen.dart';

class TagResults extends StatefulWidget {
  const TagResults({Key? key, required this.thistag}) : super(key: key);
  final String thistag;

  @override
  _TagResultsState createState() => _TagResultsState();
}

class _TagResultsState extends State<TagResults> {
bool isLoading=true;
  late StreamSubscription tag_resultssSubscription;
List<Map<String,dynamic>> tagResults=[];
  String client = "";

  void initState() {
    print(widget.thistag);
    super.initState();
    setState(() {
      tag_resultssSubscription =
         FirebaseFirestore.instance.collection("shops")
             .where("tags",arrayContains: widget.thistag )
             .snapshots()
              .listen((event) {
            setState(() {
              isLoading = true;
            });

            tagResults = [];
            event.docs.forEach((element) {
              setState(() {
                tagResults.add(element.data());
              });
              print(element.data());
              print("Shop tag Results !!!");
            });
            setState(() {
              isLoading = false;
            });

          });
    });
    setState(() {
      tag_resultssSubscription =
          Provider.of<ApplicationProvider>(context, listen: false)
              .getUser()
              .listen((event) {
            setState(() {
              client = event.data()!["name"];
            });
          });
    });


  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();

    tag_resultssSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Colors.black,
            )),
        centerTitle: true,
        title: Text(
          "Results for " + widget.thistag,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: isLoading?4:tagResults.length ,
            itemBuilder: (context, index) {
              return isLoading?Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ShimmerWidget.circular(
                          width: 80,
                          height: 85,
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ShimmerWidget.rectangular(
                                  width: 200, height: 15),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ShimmerWidget.rectangular(
                                  width: 100, height: 12),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ShimmerWidget.rectangular(
                                  width: 70, height: 10),
                            )
                          ],
                        )
                      ],
                    )),
              ) :
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) {
                          return AboutShop(shopId: tagResults[index]["uid"]);
                        }));
                  },child:SalonCard("https://d2zdpiztbgorvt.cloudfront.net/region1/us/270012/biz_photo/7d1a76a087e84fa4b4e0ca73120aa8-Alphas-Cutz-biz-photo-e14e8d52566246d6a3a2e3ac578893-booksy.jpeg?size=640x427",
                  tagResults[index]["name"],
                  ( index%5).toDouble(), tagResults[index]["landmark"], context, isLoading));
            })
      ),
    );
  }
}

//The shimmer widget
class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({required this.width, required this.height})
      : this.shapeBorder = const RoundedRectangleBorder();

  //const ShimmerSalonCard({Key? key}) : super(key: key);

  const ShimmerWidget.circular(
      {required this.width,
        required this.height,
        this.shapeBorder = const CircleBorder()});

  //const ShimmerSalonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: height,
          width: width,
          decoration:
          ShapeDecoration(color: Colors.grey[400]!, shape: shapeBorder),
        ));
  }
}
//Salon card
Widget SalonCard(String image, String name, double rating, String description,
    BuildContext context, bool isLoading) =>
    SizedBox(
        height: 120,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          elevation: 4,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 110,
                  child: ListTile(
                    title: Text(name, style: TextStyle(fontSize: 15)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(description, style: TextStyle(fontSize: 12)),
                        Wrap(children: [
                          Text(rating.toString(), textAlign: TextAlign.end),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          )
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));