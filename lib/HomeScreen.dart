import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easykhataasg/AccountScreen.dart';
import 'package:easykhataasg/AddCustomerScreen.dart';
import 'package:easykhataasg/ShopNameScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BottomSheets/firstbottomsheet.dart';
import 'ShopNameScreen.dart';
import 'CashbookScreen.dart';
import 'main.dart';

class HomeScreen extends StatefulWidget {
  static String? shop;
  static void setshop(String x) {
    shop = x;
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  PageController _pageController = new PageController(initialPage: 0);

  // List<Widget> _Screens = <Widget>[
  //   AddCustomerScreen(),
  //   CashBookScreen(),
  //   AccountScreen()
  // ];

  @override
  Widget build(BuildContext context) {
    String shop1 = "";
    HomeScreen.shop == false
        ? shop1 = "ADD Shop"
        : shop1 = HomeScreen.shop.toString();

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.blue,
        color: Colors.white,
        animationDuration: Duration(microseconds: 600),
        items: [
          Icon(Icons.menu_book),
          Icon(Icons.attach_money),
          Icon(Icons.account_box_rounded),
        ],
        onTap: (index) {
          setState(() {
            // _selectedIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(microseconds: 600), curve: Curves.ease);
          });
        },
      ),
      // body: _Screens.elementAt(_selectedIndex),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 180, 0),
              child: MyElevatedButton()),
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("logged");
                FirebaseAuth.instance.signOut();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((c) => AuthenticationScreen())));
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: PageView(
          controller: _pageController,
          onPageChanged: (newindex) {
            setState(() {
              _selectedIndex = newindex;
            });
          },
          children: [AddCustomerScreen(), CashBookScreen(), AccountScreen()]),
    );
  }
}

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        var sheetController = showBottomSheet(
            context: context, builder: (context) => BottomSheetWidget());
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("EasyShop",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          Icon(
            Icons.arrow_drop_down,
            size: 30.0,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
        



      //     // Container(
      //     //   margin: EdgeInsets.all(65),
      //     //   width: double.infinity,
      //     //   child: ElevatedButton(
      //     //     style: ElevatedButton.styleFrom(
      //     //       primary: Colors.red,
      //     //     ),
      //     //     onPressed: () async {
      //     //       SharedPreferences prefs = await SharedPreferences.getInstance();
      //     //       prefs.remove("logged");
      //     //       FirebaseAuth.instance.signOut();
      //     //       Navigator.of(context).push(MaterialPageRoute(
      //     //           builder: ((c) => AuthenticationScreen())));
      //     //     },
      //     //     child: Text(
      //     //       "LogOut",
      //     //       style: TextStyle(
      //     //           fontSize: 16,
      //     //           color: Colors.white,
      //     //           backgroundColor: Colors.black,
      //     //           fontWeight: FontWeight.bold),
      //     //     ),
      //     //   ),
      //     // )
      //   ],
      // ),
 
 
 
 
    

