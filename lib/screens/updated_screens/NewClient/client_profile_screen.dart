//This page contains information
//relating to a client's profile

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClientProfile extends StatefulWidget {
  const ClientProfile({Key? key}) : super(key: key);

  @override
  _ClientProfileState createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 150,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 15, top: 5),
                    child: SizedBox(
                      height: 90,
                      width: 90,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3.0),
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image: AssetImage(
                                  "images/salon.jpg",
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Doe Roberts"),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("027130202"),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => EditProfile()));
                                },
                                icon: Icon(Icons.edit))
                                ),

                                Text("robertdoe60@gmail.com")
                      ],
                    ),
                  )
                ]),
              ],
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 40),
        //   child: Text("Interests"),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(15.0),
        //   child: SizedBox(
        //     height: 70,
        //     child: ListView(scrollDirection: Axis.horizontal, children: [
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Chip(
        //           padding: EdgeInsets.all(6),
        //           labelPadding: EdgeInsets.all(4),
        //           labelStyle:
        //               TextStyle(fontSize: 26, fontWeight: FontWeight.normal),
        //           label: Text("Barbering"),
        //           avatar: Icon(Icons.face),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Chip(
        //           padding: EdgeInsets.all(6),
        //           labelPadding: EdgeInsets.all(4),
        //           labelStyle:
        //               TextStyle(fontSize: 26, fontWeight: FontWeight.normal),
        //           label: Text("Salon"),
        //           avatar: Icon(Icons.face),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Chip(
        //           padding: EdgeInsets.all(6),
        //           labelPadding: EdgeInsets.all(4),
        //           labelStyle:
        //               TextStyle(fontSize: 26, fontWeight: FontWeight.normal),
        //           label: Text("Hair coloring"),
        //           avatar: Icon(Icons.face),
        //         ),
        //       )
        //     ]),
        //   ),
        // ),
        SizedBox(
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(
            "Dashboard",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: SizedBox(
                  height: 70,
                  width: 70,
                  child: CircleAvatar(
                      backgroundColor: Colors.red[200],
                      child: Icon(Icons.payments, color: Colors.white)),
                ),
                title: Text(
                  "Payments",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                trailing: SizedBox(
                  width: 80,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.lightBlue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child:
                          Text("View", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: SizedBox(
                  height: 70,
                  width: 70,
                  child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Icon(Icons.notifications, color: Colors.white)),
                ),
                title: Text(
                  "Appointments",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                trailing: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.lightBlue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("5", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: SizedBox(
                  height: 70,
                  width: 70,
                  child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.history, color: Colors.white)),
                ),
                title: Text("History",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                trailing: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.lightBlue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:
                        Text("Se all", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40,top: 5),
          child: Text("My Account", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: Colors.lightBlue[50],
                title: TextButton(onPressed: () {}, child: Text("Sign Out"))),
          ),
        )
      ],
    ));
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String name = "Name", mail = "a@gmail.com", phone = "0271302702";
  TextEditingController editname = TextEditingController();
  TextEditingController editmail = TextEditingController();
  TextEditingController editphone = TextEditingController();

  void initState() {
    super.initState();

    editname.addListener(() {
      editname.text = name;
    });
    editmail.addListener(() {
      editmail.text = mail;
    });
    editphone.addListener(() {
      editphone.text = phone;
    });

    editname.text = name;
    editmail.text = mail;
    editphone.text = phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Profile"),
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      
      body: Column(
        children: [
          //Top container
          SizedBox(height: 60),
          Stack(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: CircleAvatar(
                  child: Text("E"),
                ),
              ),
              Positioned(
                  right: 5,
                  bottom: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.camera_enhance, size: 40
                          ),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Name"),
              subtitle: TextField(
                onSubmitted: (newname) {
                    setState(() {
                      name = newname;
                    });
                  },
                  controller: editname,
                  autofocus: true,
                  decoration: InputDecoration()),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Email"),
              subtitle: TextField(
                  onSubmitted: (newmail) {
                    setState(() {
                      mail = newmail;
                    });
                  },
                  controller: editname,
                  autofocus: true,
                  decoration: InputDecoration()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Phone"),
              subtitle: TextField(
                  onSubmitted: (newphone) {
                    setState(() {
                      phone = newphone;
                    });
                  },
                  controller: editname,
                  autofocus: true,
                  decoration: InputDecoration(
                  
                  )),
                  
            ),
          ),

          SizedBox(
            height: 20,

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
               height: 50,
                          width: MediaQuery.of(context).size.width*0.4,
                          child: ElevatedButton(
                              onPressed: () {
                               
                              },
                              child: Text("Save ")),
            ),
          )
        ],
      ),
    );
  }
}
