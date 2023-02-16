import 'dart:ui';

import 'package:flutter/material.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key? key}) : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 155,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10, color: Colors.grey, spreadRadius: 5),
                ]),
            child: Column(
              children: <Widget>[
                Center(
                    child: Text(
                  "Naya Karobar Darj Karyn",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
                SizedBox(
                  height: 10,
                ),
                DecoratedTextField(),
                SheetButtonWidget()
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DecoratedTextField extends StatelessWidget {
  const DecoratedTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration.collapsed(hintText: "Enter your Shop Name"),
      ),
    );
  }
}

class SheetButtonWidget extends StatefulWidget {
  const SheetButtonWidget({Key? key}) : super(key: key);

  @override
  State<SheetButtonWidget> createState() => _SheetButtonWidgetState();
}

class _SheetButtonWidgetState extends State<SheetButtonWidget> {
  bool chkshopadd = false;
  bool success = false;
  @override
  Widget build(BuildContext context) {
    return !chkshopadd
        ? MaterialButton(
            onPressed: () async {
              setState(() {
                chkshopadd = true;
              });

              await Future.delayed(Duration(seconds: 1));
              setState(() {
                success = true;
              });
              await Future.delayed(Duration(microseconds: 1000));
              Navigator.pop(context);
            },
            color: Colors.black,
            child: Text("Add Shop", style: TextStyle(color: Colors.white)),
          )
        : !success
            ? CircularProgressIndicator()
            : Icon(
                Icons.check,
                color: Colors.green,
              );
  }
}
