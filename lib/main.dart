import 'package:country_code_picker/country_code_picker.dart';
import 'package:easykhataasg/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ContactPickerClass/addcustomerscontactlist.dart';

import 'IndividualcustomerHandling.dart';
import 'OTPController.dart';
import 'ShopNameScreen.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var loginstatus = prefs.getString("logged");
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: loginstatus == null ? AuthenticationScreen() : HomeScreen(),
//   ));
// }

class AuthenticationScreen extends StatefulWidget {
  @override
  State<AuthenticationScreen> createState() {
    return _AuthenticationScreen();
  }
}

class _AuthenticationScreen extends State<AuthenticationScreen> {
  String dialCodeDigits = "+00";
  TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 10, 0),
                child: Text(
                  "Na uthaiyn ghata ,abhi istemal",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 4, 10, 25),
                child: Text(
                  "karein Easy Khata!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 20, 28),
                child: Text(
                  "App use karne ky liye number darj karein",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.grey[600]),
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              children: [
                SizedBox(
                  width: 140,
                  height: 60,
                  child: CountryCodePicker(
                    onChanged: (country) {
                      setState(() {
                        dialCodeDigits = country.dialCode!;
                      });
                    },
                    initialSelection: "PAK",
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    favorite: ["+92", "PAK", "+1", "US"],
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Phone Number",
                        prefix: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Text(dialCodeDigits),
                        )),
                    maxLength: 12,
                    keyboardType: TextInputType.number,
                    controller: _controller,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              margin: EdgeInsets.all(15),
              width: double.infinity,
              // decoration: BoxDecoration(
              //     color: Colors.black, borderRadius: BorderRadius.circular(30)),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((c) => OTPControllerScreen(
                            phone: _controller.text,
                            codeDigits: dialCodeDigits,
                          ))));
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Text(
                  "SEND CODE",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
