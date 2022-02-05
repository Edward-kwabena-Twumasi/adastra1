import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/newshop/shop_about_screen.dart';

class PerformSearch extends SearchDelegate {
  final List<Map<String, dynamic>> shops;
  //final BuildContext context;
  //list of salon objects

  List<String> recentsquery = [];
  List shopMatch = [];
  PerformSearch(this.shops);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            //set query to empty string and build suggestions
            query = '';
            showSuggestions(context);
          },
          icon: Icon(Icons.close)),
      IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.filter))
    ];
  }

  // @override
  // PreferredSizeWidget buildBottom(BuildContext context) {
  //   return PreferredSize(
  //       preferredSize: recentsquery.length < 1
  //           ? Size.fromHeight(60.0)
  //           : Size.fromHeight(0.0),
  //       child: ListView(
  //        shrinkWrap: true,
  //         children: [
  //           Text("Recent searches"),
  //           Wrap(
  //             alignment: WrapAlignment.start,
  //             children: recentsquery
  //                 .map((e) => Chip(
  //                     labelStyle:
  //                         TextStyle(color: Colors.black.withOpacity(0.7)),
  //                     label: Text(e)))
  //                 .toList(),
  //           ),
  //         ],
  //       ));
  // }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // final appProv = Provider.of<ApplicationProvider>(context, listen: false);
    // appProv.addQuery(query);
    if (!query.isEmpty) {
      if (!recentsquery.contains(query)) {
        recentsquery.add(query);
      }
    }
    // TODO: implement buildResults
    return query.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Your query was empty"),
            ),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Search Results for " + query),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: shops.length,
                    itemBuilder: (buildContext, index) {
                      return shops[index]["name"]
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase())
                          ? GestureDetector(
                              onTap: () {
                                close(context, shops[index]["name"]);
                                if (!recentsquery.contains(query)) {
                                  recentsquery.add(query);
                                }
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (contex) {
                                  return AboutShop(shopId: shops[index]["uid"]);
                                }));
                              },
                              child: SalonCards(shops[index], context),
                            )
                          : SizedBox(
                              height: 0,
                            );
                    }),
              ),
            ],
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // final appProv = Provider.of<ApplicationProvider>(context, listen: false);
    // recentsquery = appProv.recentQuery;

    return query.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: shops.length,
            itemBuilder: (buildContext, index) {
              return shops[index]["name"]
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase())
                  ? Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: GestureDetector(
                        onTap: () {
                          close(context, shops[index]["name"]);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (contex) {
                            return AboutShop(shopId: shops[index]["uid"]);
                          }));
                        },
                        child: SalonCards(shops[index], context),
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    );
            })
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: shops.length,
                    itemBuilder: (buildContext, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            close(context, shops[index]["name"]);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (contex) {
                              return AboutShop(shopId: shops[index]["uid"]);
                            }));
                          },
                          child: SalonCards(shops[index], context),
                        ),
                      );
                    }),
              ),
            ],
          );
  }
}

Widget SalonCards(Map<String, dynamic> shop, BuildContext context) {
  String defaultshopImage = "https://media.istockphoto.com/photos/hair-beauty-salon-picture-id1341429602?b=1&k=20&m=1341429602&s=170667a&w=0&h=996IdyjbO3EO1HXiobW382SLiDlJ8zYqOZxzKw17U7U=";
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 95,
            width: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage(
                      shop["photo_url"] == ""
                          ? 
                           defaultshopImage:shop["photo_url"],
                    ),
                    fit: BoxFit.cover))),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(shop["name"]),
                subtitle: Text(shop["landmark"]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Wrap(
                  children: [
                    Text("1", textAlign: TextAlign.end),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

//salon class
class Salons {
  String image;
  String name;
  double rating;
  String description;

  Salons(this.image, this.name, this.rating, this.description);
}
