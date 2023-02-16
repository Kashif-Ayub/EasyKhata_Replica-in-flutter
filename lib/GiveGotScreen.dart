import 'package:easykhataasg/Model_and_DataBaseHandler/CashinCashOut.dart';
import 'package:easykhataasg/Model_and_DataBaseHandler/Customer.dart';
import 'package:easykhataasg/Model_and_DataBaseHandler/DBHandler.dart';
import 'package:flutter/material.dart';
import 'dart:math' as mth;

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GiveGotScreen extends StatefulWidget {
  String? title;
  String? cname;
  String? cnum;

  GiveGotScreen({this.title, this.cname, this.cnum});

  @override
  State<GiveGotScreen> createState() => _GiveGotScreenState(
      title: this.title, custname: this.cname, custnum: this.cnum);
}

class _GiveGotScreenState extends State<GiveGotScreen> {
  String? title;
  String? custname;
  String? custnum;
  _GiveGotScreenState(
      {this.title, required this.custname, required this.custnum});
  TextEditingController nums = TextEditingController();
  TextEditingController details = TextEditingController();
  var _selectedDate = DateTime.now().obs;
  _ExpressionEvaluator() {
    List<String> numbers = [];
    dynamic ans;
    if (nums.text.contains('/') ||
        nums.text.contains('X') ||
        nums.text.contains('+') ||
        nums.text.contains('-')) {
      if (nums.text.toString().contains('/')) {
        numbers = nums.text.split('/');
        if (int.parse(numbers[1]) > 0) {
          ans = double.parse(numbers[0]) / double.parse(numbers[1]);

          nums.text = ans.toString();
        }
      } else if (nums.text.toString().contains('X')) {
        numbers = nums.text.split('X');

        ans = double.parse(numbers[0]) * double.parse(numbers[1]);
        nums.text = ans.toString();
      } else if (nums.text.toString().contains('+')) {
        numbers = nums.text.split('+');

        ans = double.parse(numbers[0]) + double.parse(numbers[1]);
        nums.text = ans.toString();
      } else if (nums.text.toString().contains('-')) {
        numbers = nums.text.split('-');

        ans = double.parse(numbers[0]) - double.parse(numbers[1]);
        nums.text = ans.toString();
      }
    }
  }

  _ChooseDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != _selectedDate.value) {
      _selectedDate.value = pickedDate;
    }
  }

  late Dbhandler db;
  _createInstance() async {
    Dbhandler.getInstance().then((value) {
      return db = value;
    });
    setState(() {});
  }

  _cashincashOut() async {
    db.InsertCashinCashOut(CashInCashOut(
        time: TimeOfDay.fromDateTime(DateTime.now()).toString(),
        date: DateFormat("dd-MM-yyyy").format(_selectedDate.value).toString(),
        cashin: title == "Cash In"
            ? int.parse(nums.text) == null
                ? 0
                : int.parse(nums.text)
            : 0,
        cashout: title == "Cash Out"
            ? int.parse(nums.text) == null
                ? 0
                : int.parse(nums.text)
            : 0));
  }

  _gavegotsavingdata() async {
    db.InsertCustomer(CustomersData(
            custno: custnum,
            custname: custname,
            datetime:
                DateFormat("dd-MM-yyyy").format(_selectedDate.value).toString(),
            igave: title == "I GAVE"
                ? int.parse(nums.text) == null
                    ? 0
                    : int.parse(nums.text)
                : 0,
            igot: title == "I GOT"
                ? int.parse(nums.text) == null
                    ? 0
                    : int.parse(nums.text)
                : 0,
            shopno: "not yet",
            balrs: 0))
        .then((value) => value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          title!,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
                width: 350,
                child: TextField(
                  keyboardType: TextInputType.none,
                  controller: nums,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black)),
                      hintText: "Amount",
                      prefix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "RS",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: 350,
                child: TextField(
                  controller: details,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black)),
                      hintText: "Details (Optional)",
                      suffixIcon: InkWell(
                        onTap: () {
                          print("mic pressed");
                        },
                        child: Icon(
                          Icons.mic_none_outlined,
                          color: Colors.black,
                        ),
                      )),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _ChooseDate();
                    },
                    child: Container(
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: new BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.edit_calendar_outlined,
                            size: 25,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Obx((() => Text(
                                DateFormat("dd-MM-yyyy")
                                    .format(_selectedDate.value)
                                    .toString(),
                                style: TextStyle(color: Colors.black),
                              ))),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: new BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 25,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Add bills",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 200),
                width: 300,
                // decoration: BoxDecoration(
                //     color: Colors.black, borderRadius: BorderRadius.circular(30)),
                child: ElevatedButton(
                  onPressed: () {
                    title == "I GAVE" || title == "I GOT"
                        ? _gavegotsavingdata()
                        : _cashincashOut();
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent[700],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.save),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "SAVE",
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
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      nums.text = "";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 80,
                      child: Center(
                          child: Text(
                        "C",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      _ExpressionEvaluator();
                      nums.text += "/";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 80,
                      child: Center(
                          child: Text(
                        "/",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      _ExpressionEvaluator();
                      nums.text += "X";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 80,
                      child: Center(
                        child: Icon(Icons.clear),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      print("Clear");
                      List<String> numbers = [];
                      numbers = nums.text.split('');
                      numbers.removeAt(numbers.length - 1);
                      nums.text = numbers.join();
                      print(numbers.join());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 80,
                      child: Center(
                        child: Icon(Icons.cancel_presentation),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      nums.text += "7";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 80,
                      child: Center(
                          child: Text(
                        "7",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      nums.text += "8";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 80,
                      child: Center(
                          child: Text(
                        "8",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      nums.text += "9";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 80,
                      child: Center(
                        child: Text(
                          "9",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      _ExpressionEvaluator();
                      nums.text += "-";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[500]),
                      height: 50,
                      width: 80,
                      child: Center(
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      nums.text += "4";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 80,
                      child: Center(
                          child: Text(
                        "4",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      print("5");
                      nums.text += "5";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 80,
                      child: Center(
                          child: Text(
                        "5",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      nums.text += "6";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 80,
                      child: Center(
                        child: Text(
                          "6",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      _ExpressionEvaluator();
                      nums.text += "+";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[500]),
                      height: 50,
                      width: 80,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      nums.text += "1";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 80,
                      child: Center(
                          child: Text(
                        "1",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      nums.text += "2";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 80,
                      child: Center(
                          child: Text(
                        "2",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      nums.text += "3";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 80,
                      child: Center(
                        child: Text(
                          "3",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      _ExpressionEvaluator();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[500]),
                      height: 50,
                      width: 80,
                      child: Center(
                        child: Text(
                          "=",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      nums.text += "0";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 80,
                      child: Center(
                          child: Text(
                        "0",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      nums.text += "00";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 80,
                      child: Center(
                          child: Text(
                        "00",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      nums.text += ".";
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[300]),
                      height: 50,
                      width: 80,
                      child: Center(
                        child: Text(
                          ".",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
