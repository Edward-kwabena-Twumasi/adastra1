import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/register_shop_location.dart';

class Tags extends StatefulWidget {
  const Tags({Key? key}) : super(key: key);

  @override
  _TagsState createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  List<String> prefTags = [];
  List<String> tags = [
    'Down Cut',
    'Upper Cut',
    "Hair coloring ",
    "Beard Trim",
    "Ninga cuts"
  ];

  @override
  Widget build(BuildContext context) {
    final appProv = Provider.of<ApplicationProvider>(context, listen: false);
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: prefTags.length < 1
            ? Text("")
            : FloatingActionButton(
                onPressed: () {
                  appProv.setShopTags(prefTags);
                  Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    return RegisterShopLocation();
                  }));
                },
                child: Icon(FontAwesomeIcons.save),
              ),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(" Related Tags",
              style: TextStyle(color: Colors.black, fontSize: 20)),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  children: tags.map((e) {
                    return Tag(name: e, update: updateTags);
                  }).toList()),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  //updating function
  updateTags(bool selected, String service) {
    if (selected) {
      setState(() {
        prefTags.add(service);
      });
    } else {
      setState(() {
        prefTags.remove(service);
      });
    }
    print(prefTags);
  }
}

List<Map<String, dynamic>> services = [
  {"name": 'Down Cut', "duration": 30, "price": 15},
  {"name": 'Upper Cut', "duration": 30, "price": 15},
  {"name": "Hair coloring ", "duration": 30, "price": 15},
  {"name": "Beard Trim", "duration": 30, "price": 15},
  {"name": "Ninga cuts", "duration": 30, "price": 15}
];

class Tag extends StatefulWidget {
  Tag({Key? key, required this.name, required this.update}) : super(key: key);
  final String name;

  final Function(bool selected, String name) update;

  @override
  State<Tag> createState() => TagState();
}

class TagState extends State<Tag> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: InputChip(
          elevation: 4,
          pressElevation: selected ? 10 : 4,
          padding: EdgeInsets.all(10),
          selected: selected,
          onSelected: (val) {
            setState(() {
              selected = val;
            });
            widget.update(val, widget.name);
          },
          selectedColor: Colors.grey,
          // onPressed: widget.onpressed,
          label: Text(
            widget.name,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black.withOpacity(0.7),
        ),
      ),
    );
  }
}

//chosen tags
class ChosenTag extends StatefulWidget {
  final String name;

  const ChosenTag({Key? key, required this.name}) : super(key: key);

  @override
  State<ChosenTag> createState() => _ChosenTagState();
}

class _ChosenTagState extends State<ChosenTag> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: InputChip(
          elevation: 7,
          deleteIcon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.cancel,
                color: Colors.white,
              )),
          padding: EdgeInsets.all(10),
          onDeleted: () {},
          selected: true,
          selectedColor: Colors.black,

          // onPressed: widget.onpressed,
          label: Text(
            widget.name,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
