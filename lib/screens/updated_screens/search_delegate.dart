import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thecut/screens/updated_screens/newshop/shop_about_screen.dart';

class PerformSearch extends SearchDelegate {
  //list of salon objects
  List<Salons> salons = [
    Salons("images/salon.jpg", "Afias Salon", 4.3,
        "Unisex salon located at Adenta"),
    Salons("images/salon.jpg", "American barbers", 4.2,
        "Unisex Barbering shop located at Tech"),
    Salons("images/salon.jpg", "American barbers", 4.2,
        "Unisex Barbering shop located at Tech"),
    Salons("images/salon.jpg", "American barbers", 4.2,
        "Unisex Barbering shop located at Tech")
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close)),
      IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.filter))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return query.isEmpty?Center(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Enter shop name or category"),
        ) ,
    ): Column(
      
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Search Results for "+query),
        ),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: salons.length,
              itemBuilder: (buildContext, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SalonCards(salons[index].image, salons[index].name,
                      salons[index].rating, salons[index].description, context),
                );
              }),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Column(
      children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text("Search Suggestions"),
         ),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: salons.length,
              itemBuilder: (buildContext, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SalonCards(salons[index].image, salons[index].name,
                      salons[index].rating, salons[index].description, context),
                );
              }),
        ),
      ],
    );
  }
}

Widget SalonCards(String image, String name, double rating, String description,
    BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (contex) {
        return const AboutShop();
      }));
    },
    child: SizedBox(
        height: 81,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                  height: 80,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(
                            image,
                          ),
                          fit: BoxFit.cover))),
              Expanded(
                child: ListTile(
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
              ),
            ],
          ),
        )),
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
