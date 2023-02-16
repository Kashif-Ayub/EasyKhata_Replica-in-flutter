import 'package:easykhataasg/Model_and_DataBaseHandler/CashinCashOut.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'GiveGotScreen.dart';
import 'Model_and_DataBaseHandler/DBHandler.dart';

class CashBookScreen extends StatefulWidget {
  const CashBookScreen({Key? key}) : super(key: key);

  @override
  State<CashBookScreen> createState() => _CashBookScreenState();
}

class _CashBookScreenState extends State<CashBookScreen> {
  double cashinhand = 0;

  double todaysbalance = 0;
  var _selectedDate = DateTime.now().obs;
  List<CashInCashOut> dt = [];
  Dbhandler? db;

  _createInstance() async {
    Dbhandler.getInstance().then((value) => db = value);
    setState(() {});
  }

  _getcashinout() async {
    print("get customer called");

    if (db != null) {
      db!
          .getCashinOut(
              DateFormat("dd-MM-yyyy").format(_selectedDate.value).toString())
          .then((value) => dt = value);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createInstance();
    _getcashinout();
  }

  @override
  Widget build(BuildContext context) {
    _getcashinout();
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 80,
                width: 140,
                margin:
                    EdgeInsets.only(left: 10, top: 10, bottom: 0, right: 30),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "RS $cashinhand",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "Cash in hand",
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 80,
                width: 140,
                margin: EdgeInsets.only(left: 20, top: 10, bottom: 0, right: 0),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "RS $todaysbalance",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "Today's balance",
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Divider(),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Obx((() => Text(
                    DateFormat("dd-MM-yyyy")
                        .format(_selectedDate.value)
                        .toString(),
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ))),
              SizedBox(
                width: 60,
              ),
              Text(
                "Cash Out",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              SizedBox(
                width: 60,
              ),
              Text(
                "Cash In",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
          Divider(),
          Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 5, right: 5),
              height: 350,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemBuilder: ((context, index) => Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                dt[index].time.toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                              dt[index].cashout != 0
                                  ? Container(
                                      height: 60,
                                      width: 80,
                                      margin: EdgeInsets.only(left: 40),
                                      color: Color.fromARGB(255, 248, 248, 248),
                                      child: Center(
                                        child: Text(
                                            "Rs " +
                                                dt[index].cashout.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                      ),
                                    )
                                  : Container(
                                      height: 60,
                                      width: 80,
                                      margin: EdgeInsets.only(left: 50),
                                    ),
                              if (dt[index].cashin != 0)
                                Container(
                                  height: 60,
                                  width: 80,
                                  margin: EdgeInsets.only(left: 15),
                                  color: Color.fromARGB(255, 248, 248, 248),
                                  child: Center(
                                    child: Text(
                                        "Rs " + dt[index].cashin.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                        )),
                                  ),
                                )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      )),
                  itemCount: dt.length,
                ),
              )),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                width: 180,
                // decoration: BoxDecoration(
                //     color: Colors.black, borderRadius: BorderRadius.circular(30)),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => GiveGotScreen(
                              title: "Cash Out",
                            ))));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.remove),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "CASH OUT",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                width: 180,
                // decoration: BoxDecoration(
                //     color: Colors.black, borderRadius: BorderRadius.circular(30)),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => GiveGotScreen(
                              title: "Cash In",
                            ))));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "CASH IN",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
