import 'package:flutter/material.dart';

class DetailDisplayScreen extends StatefulWidget {
  final String imagePath;
  final String firstName;
  final String lastName;
  final String location;
  final String email;
  final String phone;

  const DetailDisplayScreen(
      {Key? key,
      required this.imagePath,
      required this.firstName,
      required this.lastName,
      required this.location,
      required this.email,
      required this.phone})
      : super(key: key);

  @override
  _DetailDisplayScreenState createState() => _DetailDisplayScreenState();
}

class _DetailDisplayScreenState extends State<DetailDisplayScreen> {

  TextEditingController fnameCtrl = TextEditingController();
  TextEditingController lnameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController gpsCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.imagePath))),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.green,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 35.0),
              child: TextField(
                enabled: false,
                controller: fnameCtrl,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'First Name',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Eg. John',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.4),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 35.0),
              child: TextField(
                controller: lnameCtrl,
                enabled: false,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Surname',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Eg. Doe',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.4),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 35.0),
              child: TextField(
                controller: phoneCtrl,
                enabled: false,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Phone',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Eg. 0541000000',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.4),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 35.0),
              child: TextField(
                enabled: false,
                controller:emailCtrl,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Email',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Eg. barber@shop.com',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.4),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 35.0),
              child: TextField(
                enabled: false,
                controller: gpsCtrl,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Location',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Eg. WS-100-1000 Kentinkrono ABC Blcok',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.4),
                    )),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fnameCtrl.text=widget.firstName;
      lnameCtrl.text=widget.lastName;
      emailCtrl.text=widget.email;
      gpsCtrl.text=widget.location;
      phoneCtrl.text=widget.phone;
    });
  }
}
