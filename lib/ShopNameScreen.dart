import 'package:easykhataasg/HomeScreen.dart';
import 'package:flutter/material.dart';

class ShopNameScreen extends StatefulWidget {
  @override
  State<ShopNameScreen> createState() {
    return _ShopeNameScreen();
  }
}

class _ShopeNameScreen extends State<ShopNameScreen> {
  static TextEditingController _shopname = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 120,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 10, 0),
                child: Text(
                  "Karobar ki tafseelat",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 20, 28),
                child: Text(
                  "Apny karobar ka naam likhain",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.grey[600]),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: _shopname,
              decoration: InputDecoration(
                labelText: "Dukan ka naam",
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 320, 10, 10),
              width: double.infinity,
              // decoration: BoxDecoration(
              //     color: Colors.black, borderRadius: BorderRadius.circular(30)),
              child: ElevatedButton(
                onPressed: () {
                  HomeScreen.setshop(_shopname.text.toString());
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (c) => HomeScreen()));
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Text(
                  "AAGAY BARHEIN",
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
