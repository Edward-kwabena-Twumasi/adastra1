import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:thecut/providers/provider.dart';
import 'package:thecut/screens/status_screen.dart';
import 'package:thecut/screens/verify_registry_futurebuilder.dart';

class OTPScreen extends StatefulWidget {
  String phone;

  OTPScreen({Key? key, required this.phone}) : super(key: key);

  @override
  OTPScreenState createState() => OTPScreenState();
}

class OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  String _verificationCode = '000000';
  String OTP_STATUS = "";
  late String INDEX_ID;
 /* final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();*/
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );



  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        hintColor: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('OTP Verification'),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.black,
          leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: const Icon(Icons.arrow_back),
          ),
        ),
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Code Sent to ' + widget.phone,
                      style:
                      const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const Text('Enter your OTP Code Here'),
                    Container(
                      color: Colors.white,
                      margin: const EdgeInsets.all(20.0),
                      padding: const EdgeInsets.all(20.0),
                      child: PinPut(
                        fieldsCount: 4,
                        onSubmit: (String pin){
                          print("INDEX ID--->$INDEX_ID in onSubmit of PINPUT");
                          verifyPhone(pin).then((value) async {
                            final verifyResponse = jsonDecode(value.body);
                            print(verifyResponse);
                            if (verifyResponse['resp_msg'] == "otp valid") {
                              final appProv=Provider.of<ApplicationProvider>(context,listen:false);
                              print("OTP_NEW PAGE");
                              print(widget.phone.runtimeType);
                              await appProv.setPhoneNumber(widget.phone);

                              Navigator.pushAndRemoveUntil(
                                  context, MaterialPageRoute(builder: (context) =>VerifyRegistryBuilderScreen()),
                                      (route) => false);
                            } else {
                              Navigator.pushAndRemoveUntil(
                                  context, MaterialPageRoute(builder: (context) =>
                              const Center(
                                child: Text('Not Verified'),
                              )),
                                      (route) => false);
                            }
                          }).catchError((onError) {
                            print('Error Getting Code \n');
                            print(onError.toString());
                          });
                          print(pin);
                        },
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        submittedFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        selectedFieldDecoration: _pinPutDecoration,
                        followingFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Colors.deepPurpleAccent.withOpacity(.5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  Future<Response> requestOTP(/*String title*/) {
    return post(
      Uri.parse('https://healthker.com/courier_api/index.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'method': "REQUEST_OTP",
        "api_key": "42353d5c33b45b0a8246b9bf0cd46820e516e3e4",
        "mobile_number": widget.phone,
        "request_type": "signin"
      }),
    );
  }

  Future<Response> verifyPhone(String otp) {
    return post(
      Uri.parse('https://healthker.com/courier_api/index.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'method': "CONFIRM_OTP",
        "api_key": "42353d5c33b45b0a8246b9bf0cd46820e516e3e4",
        "mobile_number": widget.phone,
        "index_id": INDEX_ID,
        "otp_code":otp
      }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    requestOTP().then((value) {
      final otpRequest = jsonDecode(value.body);
      INDEX_ID = otpRequest['index_id'];
      print(otpRequest);
      print("INDEX_ID---->>>$INDEX_ID in initState()");
    }).catchError((onError) {
      print("EROOR from API");
      print(onError.toString());
    });
  }

}
