import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';

class AddShopStyle extends StatefulWidget {
  const AddShopStyle({Key? key}) : super(key: key);

  @override
  _AddShopStyleState createState() => _AddShopStyleState();
}

class _AddShopStyleState extends State<AddShopStyle> {
  String? _chosenValue;
  final String _clientId = "0271302702";
  TextEditingController styleCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController durationCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /*List<Map<String, String>> styleCat = [
    {"name": "General Cutz"},
    {"name": "Shave"},
    {"name": "Dying"},
    {"name": "Trimming"}
  ];*/
  List<Map<String, dynamic>> styleCat = [
    /*{"name": "General Cutz"},
    {"name": "Shave"},
    {"name": "Dying"},
    {"name": "Trimming"}*/
  ];
  List<Map<String, dynamic>> shopStyles = [];
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> styleCatSubscription;
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> createdStyleSubscription;

  @override
  initState(){
    print("INIT STATE");
    setState(() {
      styleCatSubscription=FirebaseFirestore.instance
          .collection('style_categories')
          .snapshots()
          .listen((event) {
        setState(() {
          styleCat = [];
        });
        //print(event.docs.toList().runtimeType);
        for (var oldStyle in event.docs) {
          //print(oldStyle.data().runtimeType);
          setState(() {
            styleCat.add(oldStyle.data());
          });
        }
        //print(event.docs.toList());
      });
      print("DONE WITH CATEGIRES");
    });
    setState(() {
      createdStyleSubscription=FirebaseFirestore.instance
          .collection('shop_styles')
          .doc(Provider.of<ApplicationProvider>(context, listen: false).phoneNumber)
          .collection('style')
          .snapshots()
          .listen((event) {
            print(event.docs.length);
            setState(() {
              shopStyles = [];
            });

        for (var oldStyle in event.docs) {
          //print(oldStyle.data().runtimeType);
          print('HERE');
          print(oldStyle.data());
          setState(() {
            shopStyles.add(oldStyle.data());
          });
        }
      });
      print("DONE WITH MAIN CREATED STYES");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    createdStyleSubscription.cancel();
    styleCatSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Shop Styles'),
      ),
      body: Builder(builder: (ctx) {
        return Container(
         /* height: MediaQuery.of(context).size.height,*/
          child: Column(children: [
           /* Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.style),
                  Text('Choose Category of Choice',
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            ),*/
          /*  DropdownButton<String>(
                value: _chosenValue,
                items: styleCat.map((Map<String, dynamic> value) {
                  return DropdownMenuItem<String>(
                    value: value['name'],
                    child: Text(value['name'] ?? ""),
                  );
                }).toList(),
                hint: const Text('Please Chosen Style Category'),
                onChanged: (String? value) {
                  setState(() {
                    _chosenValue = value;
                  });
                }),*/
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name of Service Required';
                          }
                          return null;
                        },
                        controller: styleCtrl,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.style),
                          /*border: OutlineInputBorder(),*/
                          labelText: 'Name of Category',
                          hintText: 'Sakora Cut ',
                          /* labelStyle: TextStyle(
                                    color: er1 == false ? Colors.black : Colors.red,
                                  ),*/
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Price of Service';
                          }
                          return null;
                        },
                        controller: priceCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.price_change_outlined),
                          /*border: OutlineInputBorder(),*/
                          labelText: 'Price Tag',
                          hintText: '15.00',
                          /* labelStyle: TextStyle(
                                    color: er1 == false ? Colors.black : Colors.red,
                                  ),*/
                        ),
                      ), TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Duration of Service';
                          }
                          return null;
                        },
                        controller: durationCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.alarm),
                          /*border: OutlineInputBorder(),*/
                          labelText: 'Duration of Service',
                          hintText: '15',
                          /* labelStyle: TextStyle(
                                    color: er1 == false ? Colors.black : Colors.red,
                                  ),*/
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          /*if(_chosenValue==null){
                            ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Style category required')));
                            return;
                          }*/
                          if(_formKey.currentState!.validate()){

                            print("Name of Category :" + styleCtrl.text);
                            print("Price of Category :" + priceCtrl.text);
                            Map<String, dynamic> newStyle = {
                              'name': styleCtrl.text,
                              'price':  priceCtrl.text,
                              'duration':durationCtrl.text ,
                              /*'category':_chosenValue!*/
                            };

                            FirebaseFirestore.instance
                                .collection('shop_styles')
                                .doc(Provider.of<ApplicationProvider>(context, listen: false).phoneNumber)
                                .collection('style')
                                .doc()
                                .set(newStyle)
                                .then((value) {
                              setState(() {
                                shopStyles.add(newStyle);
                                styleCtrl.text=durationCtrl.text=priceCtrl.text="";
                              });

                              ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                                  content: Text('New Style Added Successfully')));
                            });
                          }
                        },
                        child: Text('Add Style'),
                      )
                    ]),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                children: shopStyles.map((e) {
                  return ListTile(
                    leading: const Icon(Icons.style),
                    title: Text(e['name'] as String),
                    subtitle: Text(e['price'] as String),
                  );
                }).toList(),
              ),
            )
          ]),
        );
      }),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),*/
    );
  }
}
