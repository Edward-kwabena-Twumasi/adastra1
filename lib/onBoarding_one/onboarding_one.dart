import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:thecut/homepage.dart';
import 'package:thecut/screens/register_barber_screen.dart';
import 'package:thecut/screens/register_client_screen.dart';
import 'package:thecut/screens/register_shop_screen.dart';
//import introduction screen

//now, edit the content to what you want

class OnBoardingOne extends StatefulWidget {
  @override
  _OnBoardingOneState createState() => _OnBoardingOneState();
}

class _OnBoardingOneState extends State<OnBoardingOne> {
  final introKey = GlobalKey<IntroductionScreenState>();

  //this function is to call home page when introduction screen done
  void _onIntroEnd(context) {
    /*Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomePage()),
    );*/
  }

//this function is to render images from assets folder
  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    //this is page decoration of background
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        pages: [
          PageViewModel(
              title: "Register your shop now",
              body:
                  "Reach out to millions of customers to day by join the best platform to make it happen",
              image: _buildImage('v1'),
              decoration: pageDecoration,
              footer: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => ShopRegistrationScreen()),
                  );
                },
                child: Text('Join us'),
              )),
          PageViewModel(
              title: "Want a quick shave?",
              body: "With just a few clicks you will have a new look👌",
              image: _buildImage('v2'),
              decoration: pageDecoration,
              footer: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => ClientRegistrationScreen()),
                  );
                },
                child: Text('Get a Cut'),
              )),
          PageViewModel(
              title: "Are you a barber?",
              body: "Join a shop now to do what you do best",
              image: _buildImage('v3'),
              decoration: pageDecoration,
              footer: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => BarberRegistrationScreen()),
                  );
                },
                child: Text('Serve'),
              )),
          PageViewModel(
            title: "Follow & Subscribe",
            body:
                "Join the team💕",
            image: _buildImage('v5'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        //call when introduction done
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        //show skip button, skip to last page
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text('Skip'),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        //this is dot decoration
        dotsDecorator: DotsDecorator(
          //delete const if want to change active color
          activeColor: Color(0xFFBA68C8),
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
