import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ShopAccount extends StatefulWidget {
  const ShopAccount({Key? key}) : super(key: key);

  @override
  _ShopAccountState createState() => _ShopAccountState();
}

class _ShopAccountState extends State<ShopAccount> {
  late PageController cardsview;
  int initial = 0;
  @override
  void initState() {
    super.initState();
    cardsview = PageController(initialPage: initial, viewportFraction: 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: PageView(
                  dragStartBehavior: DragStartBehavior.down,
                  controller: cardsview,
                  children: [AccountCard(context), AccountCard(context), AccountCard(context)],
                  onPageChanged: (int pgid) {
                    setState(() {
                      initial = pgid;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: initial == 0
                                ? Colors.black
                                : Colors.black.withOpacity(0.5))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: initial == 1
                                ? Colors.black
                                : Colors.black.withOpacity(0.5))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: initial == 2
                                ? Colors.black
                                : Colors.black.withOpacity(0.5))),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  tileColor: Colors.black.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Add a new card",
                        style: TextStyle(color: Colors.white.withOpacity(0.8))),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Receive payments on it",
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.8))),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(child: Icon(Icons.add)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text("Transactions summary"),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.black.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text("Income",
                        style: TextStyle(color: Colors.white.withOpacity(0.8))),
                    subtitle: Text("Total payments received",
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.8))),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: Colors.black.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: Text(
                    "Withdrawals",
                    style: TextStyle(color: Colors.white.withOpacity(0.8)),
                  ),
                  subtitle: Text("Total withdrawals",
                      style: TextStyle(
                          fontSize: 11, color: Colors.white.withOpacity(0.8))),
                ),
              )
              // RichText(text: TextSpan(
              //   children: [TextSpan(text: "Add a card to receive funds"),
              //   WidgetSpan(
              //     child: Padding(
              //     padding: const EdgeInsets.all(3.0),
              //     child: IconButton(
              //       color: Colors.black,
              //       padding: EdgeInsets.all(10),

              //       onPressed: (){}, icon: Icon(Icons.add)),
              //   ))
              //   ]
              // ))
            ],
          ),
        ),
      ),
    );
  }
}

Widget AccountCard(BuildContext context) {
  return Padding(
    padding:
        const EdgeInsets.only(top: 20.0, right: 6.0, bottom: 20.0, left: 6.0),
    child: Container(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black.withOpacity(0.6)),
      child: Stack(
        children: [
          Positioned(
              top: -17,
              left: -12,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white)),
              )),
          Positioned.fill(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text("Total balance",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.8),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    "300",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Text("0xxxxxxxxxxxxx1234",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
          )),
          Positioned(
              bottom: -60,
              right: -80,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white)),
              )),
          Positioned(
              bottom: 60,
              right: -70,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white)),
              ))
        ],
      ),
    ),
  );
}
