import 'package:flutter/material.dart';
import 'package:thecut/screens/register_client_screen.dart';
import 'register_barber_screen.dart';
import 'register_shop_screen.dart';

// Widget ClientStatusDropDown(){
//   String? newValue;

//  List<String> locations=["","",""];

//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black, width: 2),
//         borderRadius: BorderRadius.circular(10.0),
//         color: Colors.black,
//       ),
//       child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
//           child: DropdownButton<String>(
//             borderRadius: BorderRadius.all(Radius.circular(15.0)),
//             hint: const Text('Choose Status'),
//             isExpanded: false,
//             value: newValue,
//             focusColor: Colors.black,
//             items: locations.map((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(
//                   value,
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               );
//             }).toList(),
//             dropdownColor: Colors.black,
//             onChanged: (value) => {
//               setState(() {
//                 newValue = value;
//                 widget.changeData();
//                 print(newValue);
//               })
//             },
//           )),
//     );

// }

class StatusPage extends StatefulWidget {
  StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  List<String> locations = ['Shop', 'Client', 'Barber'];
  String? newValue;




  Widget ClientStatusDropDown() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black,
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          child: DropdownButton<String>(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            hint: const Text('Choose Status'),
            isExpanded: false,
            value: newValue,
            focusColor: Colors.black,
            items: locations.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
            dropdownColor: Colors.black,
            onChanged: (value) => {
              setState(() {
                newValue = value;

                print(newValue);
              })
            },
          )),
    );
  }

  String selectedTrade = '';
  bool hasselected = false;

  void changeSelection(String selected) {}

  @override
  void initState() {
    super.initState();
     newValue=locations.first;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Status ?"),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.black,
      foregroundColor: Colors.white,
        onPressed: () {
          if (newValue == "Barber") {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BarberRegistrationScreen();
            }));
          } else  if (newValue == "Client"){
 Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ClientRegistrationScreen();
            }));
          }
          else  if (newValue == "Shop"){
 Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ShopRegistrationScreen();
            }));
          }
        },
        child: Icon(Icons.arrow_right,color: Colors.white,)
      ),
      body: Container(
        color: Colors.black87.withAlpha(80),
        child: Center(child: ClientStatusDropDown()),
      ),
    );
  }
}
