import 'package:flutter/material.dart';

class ClientAppointments extends StatefulWidget {
  const ClientAppointments({Key? key}) : super(key: key);

  @override
  _ClientAppointmentsState createState() => _ClientAppointmentsState();
}

class _ClientAppointmentsState extends State<ClientAppointments> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text("Your appointments appear here" ,style: Theme.of(context).textTheme.headline2,),
        ),
      ],
    );
  }
}
//this page gives every information related to a clients appointment