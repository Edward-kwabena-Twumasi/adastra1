import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ApplicationProvider provider({bool listen = false}) {
    return Provider.of<ApplicationProvider>(context, listen: listen);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                                     provider().shopDetails['photo_url'] !=null && provider().shopDetails['photo_url'] !=""?provider().shopDetails['photo_url']:
                                        "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                      ), fit: BoxFit.cover)
                    )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: DashInfoCards(
              provider(listen: true).payments, provider(listen: true).pending, provider(listen: true).confirmed),
        )
      ],
    );
  }
}

Widget DashInfoCards(int payments, int pending, int confirmed) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(7.0),
        child: SizedBox(
          height: 170,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.pink, width: 2))),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Categories(icon: Icons.category),
                          Text(pending.toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink)),
                          Text("Requests")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.indigo, width: 2))),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Categories(icon: Icons.lock_clock),
                          Center(
                              child: Text(confirmed.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo))),
                          Text("Appointments")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 170,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.pink, width: 2))),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Categories(icon: Icons.payment),
                          Center(
                              child: Text(payments.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink))),
                          Text("Payments")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.indigo, width: 2))),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Categories(icon: Icons.takeout_dining),
                          Center(
                              child: Text("10",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo))),
                          Text("Job Applications")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

//tags model class
class Categories extends StatelessWidget {
  const Categories({Key? key, required this.icon}) : super(key: key);
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.red.shade50,
        child: IconButton(
          onPressed: () {},
          icon: Icon(icon),
          color: Colors.black,
        ),
      ),
    );
  }
}
