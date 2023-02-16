import 'package:easykhataasg/HomeScreen.dart';
import 'package:easykhataasg/ShopNameScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPControllerScreen extends StatefulWidget {
  final String phone;
  final String codeDigits;
  OTPControllerScreen({required this.phone, required this.codeDigits});
  @override
  State<OTPControllerScreen> createState() => _OTPControllerScreenState();
}

class _OTPControllerScreenState extends State<OTPControllerScreen> {
  void Logged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("logged", "success");
    prefs.setString("number", widget.phone);
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  final TextEditingController _pinOTPController = new TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();
  String? verificatioCode;
  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: Colors.grey),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    VerifyPhoneNumber();
  }

  VerifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${widget.codeDigits + widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            if (value.user != null) {
              Logged();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (c) => HomeScreen()));
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 5),
          ));
        },
        codeSent: (String vID, int? resentToken) {
          setState(() {
            verificatioCode = vID;
          });
        },
        codeAutoRetrievalTimeout: (String vID) {
          setState(() {
            verificatioCode = vID;
          });
        },
        timeout: Duration(seconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(
          "OTP Verification",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 10, 0),
              child: Text(
                "SMS code darj karein ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    VerifyPhoneNumber();
                  },
                  child: Text(
                    "${widget.codeDigits}-${widget.phone} par code SMS kia Jayega",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey[600]),
                  ),
                ),
              )),
          Padding(
              padding: EdgeInsets.all(40.0),
              child: PinPut(
                fieldsCount: 6,
                textStyle: TextStyle(fontSize: 25.0, color: Colors.white),
                eachFieldWidth: 40.0,
                eachFieldHeight: 50.0,
                focusNode: _pinOTPCodeFocus,
                controller: _pinOTPController,
                submittedFieldDecoration: pinOTPCodeDecoration,
                selectedFieldDecoration: pinOTPCodeDecoration,
                followingFieldDecoration: pinOTPCodeDecoration,
                pinAnimationType: PinAnimationType.rotation,
                onSubmit: (pin) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: verificatioCode!, smsCode: pin))
                        .then((value) {
                      if (value.user != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (c) => ShopNameScreen()));
                      }
                    });
                  } catch (ex) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Invalid OTP"),
                      duration: Duration(seconds: 5),
                    ));
                  }
                },
              ))
        ],
      ),
    );
  }
}
