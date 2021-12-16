import 'package:flutter/material.dart';

class BarberMainScreen extends StatefulWidget {
  const BarberMainScreen({ Key? key }) : super(key: key);

  @override
  _BarberMainScreenState createState() => _BarberMainScreenState();
}

class _BarberMainScreenState extends State<BarberMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
     floatingActionButton: FloatingActionButton(onPressed: (){
       Navigator.pop(context);
     },
     child: Icon(Icons.arrow_back,color: Colors.black,),
       backgroundColor: Colors.transparent,
       elevation: 0.0,
     ),
      body: Stack(
        children: [
          Column(
    children: [
      Container(
          height:MediaQuery.of(context).size.height*0.2,
          width:MediaQuery.of(context).size.width,
          decoration:BoxDecoration(
            image: DecorationImage(image: AssetImage("images/nicesalon.jpg", ),fit:BoxFit.cover )
          )
      ),
       Container(
      height:MediaQuery.of(context).size.height*0.8,
      color: Colors.white,
      child: Wrap(
            children:[

              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: ListTile(
                  title: Center(child: Text("Steve wonder",style: TextStyle(fontWeight:FontWeight.bold) )),
                  subtitle: Center(child: Column(
                    children: [
                      Text("Barber at best street salon"),
                      Container(
                              height: 20,
                              child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.star_border,
                                        color: Colors.yellow)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.star_border,
                                        color: Colors.yellow)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.star_border,
                                        color: Colors.yellow)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.star_border,
                                       )),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.star_border,
                                        )),
                              ]),
  )
                    ],
                  )),
                  isThreeLine: true,
                ),
              ),
              SizedBox(
                height:50,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
  IconButton(onPressed: (){}, icon: Icon(Icons.phone,size:35)),
  IconButton(onPressed: (){}, icon: Icon(Icons.message,size:35)),
  IconButton(onPressed: (){}, icon: Icon(Icons.video_call,size:35)),
  IconButton(onPressed: (){}, icon: Icon(Icons.share,size:35)),


                  ]
                )
              ),
              SizedBox(
                height: 600,
                child:BarberHome()
              )

            ]
      ),
      )
      
    ],
    
            
          ),
    
          Align(
            alignment:Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.2-40
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color:Colors.green,
                    ),
                    child: SizedBox(
                      height: 80,
                      width:80,
                      child: CircleAvatar(
                        backgroundImage: AssetImage("images/nicesalon.jpg") ,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


//shop info tabs
class BarberHome extends StatefulWidget {
  const BarberHome({Key? key}) : super(key: key);

  @override
  _BarberHomeState createState() => _BarberHomeState();
}

class _BarberHomeState extends State<BarberHome> with TickerProviderStateMixin {
  // int initial = 0;
  // TabController tabController =
  //     TabController(
  //       initialIndex: 0,
  //       length: 4, vsync: );

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              titleSpacing: 0,
              backgroundColor: Colors.white,
              elevation: 6,
              bottom: TabBar(
                indicatorColor: Colors.green,
                labelStyle: TextStyle(color: Colors.green),
                unselectedLabelColor: Colors.black,
                labelColor: Colors.green,
                tabs: [
                  Tab(
                    text: "Basic Info",
                  ),
                  Tab(
                    text: "Portfolio",
                  ),
                 
                  Tab(
                    text: "Review",
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              About(context),
        
              Gallery(context),
              Review(context)
            ],
          ),
        ),
      ),
    );
  }
}

Widget About(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("About",style:TextStyle( fontSize:23 )  ,),
          ),
        ),
        Text(
            "I am Steve and i work at best street salon"),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Other info",style:TextStyle( fontSize:23 )),
        ),
        ListTile(
            title: Row(
          children: [
            Text("Email - steve@gmail.com"),
            Spacer(),
            Text("Phone - 02345345"),
          ],
        )),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Address",style:TextStyle( fontSize:23 )),
        ),
        ListTile(
          title: Text("kUMASI,ABUAKWA"),
          subtitle: Text("Close to Shell filling station"),
        )
      ],
    ),
  );
}



Widget Gallery(BuildContext context) {
  return GridView.builder(
    itemCount: 7,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing:2,
        mainAxisSpacing: 2
      ),
      itemBuilder: (context, photos) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
image: DecorationImage(image: AssetImage("images/nicesalon.jpg"),fit: BoxFit.cover)

          ),
          height: 150,
          child:Text("Nice fade"),
        );
      });
}


Widget chatCard(String img, String name, String date, String time,String message) {
  return ListTile(
    tileColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    leading: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.amber)),
        child: CircleAvatar(
          backgroundImage: AssetImage(img),
        )),
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(name),
          Spacer(),
Text(time),
        ],
      ),
    ),
    subtitle: Container(
                              height: 20,
                              child: Row(children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.star_border,
                                        color: Colors.yellow)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.star_border,
                                        color: Colors.yellow)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.star_border,
                                        color: Colors.yellow)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.star_border,
                                       )),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.star_border,
                                        )),
                              ]),
  ));
}

Widget Review(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
       
        ListView.builder(
              shrinkWrap:true,
              itemCount: items.length,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    child: ListView(
                       shrinkWrap:true,
                      children: [
                        chatCard(items[index]["img"] ,items[index]["name"], items[index]["date"], items[index]["time"],
                         items[index]["message"]),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text("This cut was pretty cool for me"),
                          )
                      ],
                    ),
                  ),
                );
              },
            ),
       
        ],
    ),
  );
}

List items = [{"img":"images/nicesalon.jpg","name":"Kay","date":"20th Oct","time":"12:00 pm","message":"Hello"},
{"img":"images/lovecut.jpg","name":"Joe","date":"20th Oct","time":"12:00 pm","message":"Are you there?"},
];