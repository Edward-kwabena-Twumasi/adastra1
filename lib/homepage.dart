import 'package:flutter/material.dart';

//now, we put something into home page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: Color(0xFFBA68C8),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 120),
              child: Center(
                child: Text(
                  'Follow and Subscribe',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Image.asset('assets/youtube.png', fit: BoxFit.fill),
                title: Text('YouTube Channel'),
                subtitle: Text('TechnoLX'),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Image.asset('assets/insta.png', fit: BoxFit.fill),
                title: Text('Instagram'),
                subtitle: Text('TechnoLX21 (codelx21)'),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Image.asset('assets/github.png', fit: BoxFit.fill),
                title: Text('Github'),
                subtitle: Text('TechnoLX'),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Image.asset('assets/twitter.png', fit: BoxFit.fill),
                title: Text('Twitter'),
                subtitle: Text('TechnoLX (@LxTechno)'),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
