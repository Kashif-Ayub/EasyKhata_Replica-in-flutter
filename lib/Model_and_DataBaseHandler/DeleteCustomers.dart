import 'dart:ui';

import 'package:easykhataasg/Model_and_DataBaseHandler/DBHandler.dart';
import 'package:easykhataasg/Model_and_DataBaseHandler/OnlyCustomerslst.dart';
import 'package:flutter/material.dart';

class DeleteCustomers extends StatefulWidget {
  List<OnlyCustomersinfo> lstc = [];
  DeleteCustomers({required this.lstc});

  @override
  State<DeleteCustomers> createState() => _DeleteCustomersState(lstc);
}

class _DeleteCustomersState extends State<DeleteCustomers> {
  bool all_selected = false;
  late Dbhandler db;
  _createInstance() {
    Dbhandler.getInstance().then((value) => db = value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createInstance();
  }

  List<OnlyCustomersinfo> lstc = [];
  String selected = "Select";
  _DeleteCustomersState(this.lstc);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("$selected",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        actions: [
          Row(
            children: [
              Text(
                "ALL",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Container(
                child: Checkbox(
                  value: all_selected,
                  onChanged: (v) {},
                ),
              ),
            ],
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
      body: SafeArea(
        child: Container(
          height: 400,
          width: 380,
          child: Column(
            children: <Widget>[
              if (lstc.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, int i) {
                      return ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (cnt) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      overflow: Overflow.visible,
                                      children: [
                                        Container(
                                          height: 250,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 70, 10, 10),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Warning!!!",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Are you sure you Want to Delete ${lstc[i].cname}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          OnlyCustomersinfo
                                                              cust =
                                                              new OnlyCustomersinfo(
                                                                  cname: lstc[i]
                                                                      .cname,
                                                                  cnum: lstc[i]
                                                                      .cnum,
                                                                  Rs: lstc[i]
                                                                      .Rs);
                                                          lstc.removeAt(i);

                                                          db.DelCustomerinfo(
                                                              cust);
                                                          setState(() {});
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          "Yes",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        )),
                                                    SizedBox(
                                                      width: 50,
                                                    ),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          "No",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 18),
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          child: CircleAvatar(
                                            backgroundColor: Colors.redAccent,
                                            radius: 60,
                                            child: Icon(Icons.delete,
                                                size: 50, color: Colors.white),
                                          ),
                                          top: -60,
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                          title: Text(
                            lstc[i].cname,
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: Text(
                            "Rs ${lstc[i].Rs}",
                            style: TextStyle(color: Colors.green[300]),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: Text(
                              lstc[i].cname.substring(0, 2).toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ));
                    },
                    itemCount: lstc.length,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
