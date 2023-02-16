import 'package:easykhataasg/Model_and_DataBaseHandler/Customer.dart';
import 'package:easykhataasg/Model_and_DataBaseHandler/DBHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:get/get.dart';

import 'GiveGotScreen.dart';

class CustomersGaveGotChk extends StatefulWidget {
  String titleofscreen = "no one selected yet";
  String cname;
  String cnum;
  CustomersGaveGotChk(
      {required this.titleofscreen, required this.cname, required this.cnum});
  @override
  State<CustomersGaveGotChk> createState() => _CustomersGaveGotChkState(
      ttl: titleofscreen, custname: this.cname, custnum: this.cnum);
}

class _CustomersGaveGotChkState extends State<CustomersGaveGotChk> {
  String ttl;
  String custname;
  String custnum;
  List<CustomersData> dt = <CustomersData>[];

  _CustomersGaveGotChkState(
      {required this.ttl, required this.custname, required this.custnum});
  double ihavetogivegot = 0;

  Dbhandler? db;

  _createInstance() async {
    setState(() {
      Dbhandler.getInstance().then((value) {
        return db = value;
      });
    });
  }

  _getcustomer() async {
    print("get customer called");
    setState(() {
      if (db != null) db!.getCustomers(custnum).then((value) => dt = value);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createInstance();
    _getcustomer();
    setState(() {});
  }

  int gv = 0;
  int gt = 0;
  String _blrssetting(int indx) {
    // print(dt[indx].igave.toString());
    gv += int.parse(dt[indx].igave.toString());

    gt += int.parse(dt[indx].igot.toString());
    if (gv > gt) {
      print(gv.toString());
      return "0";
    }
    if (gt > gv) {
      print(gt.toString());

      return (gt - gv).toString();
    }
    if (gt == gv) {
      return (gt - gv).toString();
    }
    return "0";
  }

  Color clr = Color(0xFFE8F5E9);
  Color clr1 = Colors.green;

  String txt = "Clear";
  IconData? icn = Icons.arrow_upward_outlined;
  _givegetassign() {
    if (gt < gv) {
      ihavetogivegot = double.parse((gv - gt).toString());

      ihavetogivegot == 0 ? txt = "Clear" : txt = "i have to get";
      clr = Color(0xFFFAE6E9);
      clr1 = Colors.red;
      icn = Icons.arrow_downward_outlined;
    } else {
      ihavetogivegot = double.parse((gt - gv).toString());
      ihavetogivegot == 0 ? txt = "Clear" : txt = "i have to give";
      clr = Color(0xFFE8F5E9);
      clr1 = Colors.green;
      icn = Icons.arrow_upward_outlined;
    }
  }

  _chk(indx) {
    if (dt.length - 1 == indx) {
      _givegetassign();
      gt = 0;
      gv = 0;
    }
  }

  List<String> recipients = [];
  void _sendSMS() async {
    recipients.add(custnum);
    String m = txt == "i have to get"
        ? "you have to give Rs $ihavetogivegot "
        : txt == "i have to give"
            ? "you have to get Rs $ihavetogivegot "
            : "We are clear now neither i have to get nor you thanks";

    String message = m;
    String _result = await sendSMS(message: message, recipients: recipients)
        .catchError((onerr) {
      print(onerr);
    });
    recipients.remove(custnum);
    Get.snackbar("Sms Sent", message, snackPosition: SnackPosition.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    _getcustomer();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          ttl,
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
        child: Column(
          children: [
            Container(
              height: 70,
              width: 330,
              margin: EdgeInsets.only(left: 10, top: 10, bottom: 0, right: 10),
              decoration: BoxDecoration(
                color: clr,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        color: clr1,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        icn,
                        color: Colors.white,
                        size: 20,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "RS $ihavetogivegot",
                        style:
                            TextStyle(color: clr1, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(txt, style: TextStyle(color: clr1)),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[100]),
                  margin: EdgeInsets.only(top: 10, right: 20),
                  child: IconButton(
                      tooltip: "SMS",
                      onPressed: () {
                        _sendSMS();
                      },
                      icon: Icon(
                        Icons.sms,
                        color: Colors.blue,
                        size: 25,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[100]),
                  margin: EdgeInsets.only(top: 10, left: 40, right: 20),
                  child: IconButton(
                      tooltip: "WhatsApp",
                      onPressed: () {},
                      icon: Icon(
                        Icons.whatsapp_rounded,
                        color: Colors.green[800],
                        size: 25,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[100]),
                  margin: EdgeInsets.only(top: 10, left: 40),
                  child: IconButton(
                      tooltip: "Reports",
                      onPressed: () {},
                      icon: Icon(
                        Icons.picture_as_pdf_rounded,
                        color: Colors.red,
                        size: 25,
                      )),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 60),
                  child: Text(
                    "SMS",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 55),
                  child: Text("WhatsApp"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 55),
                  child: Text("Reports"),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Date",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                SizedBox(
                  width: 120,
                ),
                Text(
                  "I gave",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                SizedBox(
                  width: 60,
                ),
                Text(
                  "I got",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
            Divider(),
            Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 5, right: 5),
                height: 350,
                child: ListView.builder(
                  itemBuilder: ((context, index) => Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    dt[index].datetime.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 5,
                                    ),
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 248, 216, 227),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      "Bal.Rs ${_blrssetting(index)}${_chk(index) == null ? '' : ''}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                      ),
                                    )),
                                  ),
                                ],
                              ),
                              dt[index].igave != 0
                                  ? Container(
                                      height: 60,
                                      width: 80,
                                      margin: EdgeInsets.only(left: 60),
                                      color: Color.fromARGB(255, 248, 248, 248),
                                      child: Center(
                                        child: Text(
                                            "Rs " + dt[index].igave.toString(),
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
                              if (dt[index].igot != 0)
                                Container(
                                  height: 60,
                                  width: 80,
                                  margin: EdgeInsets.only(left: 15),
                                  color: Color.fromARGB(255, 248, 248, 248),
                                  child: Center(
                                    child:
                                        Text("Rs " + dt[index].igot.toString(),
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
                )),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: 180,
                  // decoration: BoxDecoration(
                  //     color: Colors.black, borderRadius: BorderRadius.circular(30)),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => GiveGotScreen(
                                title: "I GAVE",
                                cname: custname,
                                cnum: custnum,
                              ))));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red[500],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_upward),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "I GAVE",
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
                  padding: EdgeInsets.all(10),
                  width: 180,
                  // decoration: BoxDecoration(
                  //     color: Colors.black, borderRadius: BorderRadius.circular(30)),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => GiveGotScreen(
                                title: "I GOT",
                                cname: custname,
                                cnum: custnum,
                              ))));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green[500],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_downward),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "I GOT",
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
            ),
          ],
        ),
      ),
    );
  }
}
