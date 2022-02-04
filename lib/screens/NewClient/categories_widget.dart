import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thecut/screens/NewClient/tag_results.dart';

class Category extends StatefulWidget {
  final String title;
  const Category({Key? key, required this.title}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    String assetImage="images/${widget.title.toLowerCase()}.png";
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) {
              return TagResults(thistag: widget.title);
            }));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
             CircleAvatar(
              radius: 18,
              //backgroundColor: Colors.black54,
             backgroundImage: AssetImage(assetImage),
            ),
            Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.fade),
            )
          ],
        ),
      ),
    );
  }
}
