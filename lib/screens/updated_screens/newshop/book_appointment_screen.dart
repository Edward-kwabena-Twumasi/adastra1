import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

DateTime selectedtime = DateTime.now();

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  BookAppointmentState createState() => BookAppointmentState();
}

class BookAppointmentState extends State<BookAppointment> {
  bool selected = false;
  int total = 0;
  List servicechosen = [false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
       appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title:Text(" ",style:TextStyle( color:Colors.black ) ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);

              },
              icon: Icon(Icons.arrow_back,color: Colors.black, ))
              ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/nicesalon.jpg"),
                      fit: BoxFit.cover)),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                 color: Colors.black45)
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView(
                  padding:EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Pick preferred date and time",
                        style: TextStyle(color: Colors.black, fontSize: 22,fontWeight: FontWeight.w400 ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: ListTile(
                            autofocus: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            title: Text(selectedtime.toString().split(" ")[0]),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: FaIcon(FontAwesomeIcons.calendar),
                            ))),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: ListTile(
                            autofocus: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            title: Text(selectedtime.toString().split(" ")[1]),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: FaIcon(FontAwesomeIcons.clock),
                            ))),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Select service or services",
                        style: TextStyle(color: Colors.black, fontSize: 22,fontWeight: FontWeight.w400 ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                             padding: EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 1),
                borderRadius: BorderRadius.circular(10)),
                            child: CheckboxListTile(
                                title: Text("Hair Cut"),
                                subtitle: Text("10 GHS"),
                                checkColor: Colors.green[100],
                                value: servicechosen[0],
                                onChanged: (state) {
                                  setState(() {
                                    if (state!) {
                                      total += 10;
                                    } else {
                                      total -= 10;
                                    }
                                    servicechosen[0] = state;
                                    // selected = state!;
                                  });
                                }),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                             padding: EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 1),
                borderRadius: BorderRadius.circular(10)),
                            child: CheckboxListTile(
                                title: Text("Beard"),
                                subtitle: Text("8 GHS"),
                                checkColor: Colors.green[100],
                                value: servicechosen[1],
                                onChanged: (state1) {
                                  setState(() {
                                    if (state1!) {
                                      total += 8;
                                    } else {
                                      total -= 8;
                                    }
                                    servicechosen[1] = state1;
                                    //selected = state!;
                                  });
                                }),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                             padding: EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 1),
                borderRadius: BorderRadius.circular(10)),
                            child: CheckboxListTile(
                                title: Text("Shape Up"),
                                subtitle: Text("7 GHS"),
                                checkColor: Colors.green[100],
                                value: servicechosen[2],
                                onChanged: (state2) {
                                  setState(() {
                                    if (state2!) {
                                      total += 7;
                                    } else {
                                      total -= 7;
                                    }
                                    servicechosen[2] = state2;
                                    //selected = state!;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                                text: "Total GHS - ",
                                style: TextStyle(color: Colors.lightBlue)),
                            TextSpan(
                                text: total.toString(),
                                style:
                                    TextStyle(fontSize: 27, color: Colors.blue))
                          ],
                        ),
                      ),
                    ),
                    // Text(+total.toString()),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 80,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape:RoundedRectangleBorder(
                              borderRadius:BorderRadius.circular(15)
                            )
                          ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => PaymentPage()));
                            },
                            child: Text("Continue ")),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Appointment info and confirmation.show appointment info
// together with shop info and ask for payment option

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  BoxDecoration unselected = BoxDecoration();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title:Text("",style:TextStyle( color:Colors.black ) ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);

              },
              icon: Icon(Icons.arrow_back,color: Colors.black, ))
              ),
      body: Column(children: [
        SizedBox(
          height: 120,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 80,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("images/salon.jpg"),
                          fit: BoxFit.cover)),
                ),
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Street cuts",style: TextStyle(fontWeight: FontWeight.bold,fontSize:22) ),
                       
                        Icon(Icons.star,color: Colors.amber)
                      ],
                    ),
                    subtitle: Text("Obuasi hign street"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text("Services chosen"),
                  ),
                  Wrap(
                    children:[
                      Text("Service1 ,"), Text("Service2 ,"), Text("Service3 ,"), Text("Service4 ,")
                    ]
                  )
                ],
              ))
            ],
          ),
        ),
        SizedBox(
          height: 50,
        ),
         Padding(
            padding: const EdgeInsets.all(3.0),
            child: ListTile(
              autofocus: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              title: Center(child: Text(selectedtime.toString().split(" ")[0])),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Payment method",
            style: TextStyle(color: Colors.black, fontSize: 23),
          ),
        ),
       
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 3),
                borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              height: 50,
              child: ListTile(
                  title: Text("Pay with card"), leading: Icon(Icons.payments)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 3),
                borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              height: 50,
              child: ListTile(
                  title: Text("Pay with Momo"), leading: Icon(Icons.payments)),
            ),
          ),
        )
      ]),
    );
  }
}
