import 'package:flutter/material.dart';

class MyBarbers extends StatefulWidget {
  const MyBarbers({Key? key}) : super(key: key);

  @override
  _MyBarbersState createState() => _MyBarbersState();
}

class _MyBarbersState extends State<MyBarbers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        itemCount: dummydb.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? 3
                  : 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: (2 / 1),
        ),
        itemBuilder: (
          context,
          index,
        ) {
          return GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(RouteName.GridViewCustom);
              },
              child: Barber(dummydb[index]["img"], dummydb[index]["name"]));
        },
      ),
    );
  }
}

Widget Barber(String img, String name) {
  return Card(
    elevation: 5,
    child: ListView(
      children: [Image.asset(img,height: 70,fit:BoxFit.cover ), Text(name)],
    ),
  );
}

List dummydb = [
  {"img": "images/nicesalon.jpg", "name": "Joe"},
  {"img": "images/barbershop.jpg", "name": "kofi"},
  {"img": "images/nicesalon.jpg", "name": "Mawuli"},
];
