import 'package:easykhataasg/ContactPickerClass/addcustomerscontactlist.dart';
import 'package:easykhataasg/GetxControllers/AddCustomerScreenController,.dart';
import 'package:easykhataasg/IndividualcustomerHandling.dart';
import 'package:easykhataasg/Model_and_DataBaseHandler/DBHandler.dart';
import 'package:easykhataasg/Model_and_DataBaseHandler/DeleteCustomers.dart';
import 'package:easykhataasg/Model_and_DataBaseHandler/OnlyCustomerslst.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({Key? key}) : super(key: key);

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  // Dbhandler? db;
  // _createInstance() {
  //   Dbhandler.getInstance().then((value) => db = value);
  // }

  // double ihavegot = 0;
  // double ihavetogive = 0;
  // List<OnlyCustomersinfo> lstc = <OnlyCustomersinfo>[].obs;
  // customers() async {
  //   await db!.getCustomerInfo().then((value) => lstc = value);
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _createInstance();

  //   customers();

  // }

  final controller = Get.put(AddCustomerScreenController());

  @override
  Widget build(BuildContext context) {
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
                  color: Color(0xFFFAE6E9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                          size: 20,
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Obx(() => Text(
                              "RS ${controller.ihavegot.value}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "I have to get",
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 80,
                width: 140,
                margin: EdgeInsets.only(left: 20, top: 10, bottom: 0, right: 0),
                decoration: BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                          size: 20,
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Obx(() => Text(
                              "RS ${controller.ihavegot.value}",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "I have to give",
                          style: TextStyle(color: Colors.green),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.green[200],
          ),
          Container(
            height: 400,
            width: 380,
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Obx(() => ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, int i) {
                            return InkWell(
                              child: ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return CustomersGaveGotChk(
                                        titleofscreen: controller.lstc[i].cname,
                                        cname: controller.lstc[i].cname,
                                        cnum: controller.lstc[i].cnum,
                                      );
                                    }));
                                  },
                                  onLongPress: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return DeleteCustomers(
                                          lstc: controller.lstc);
                                    }));
                                  },
                                  title: Obx(() => Text(
                                        controller.lstc[i].cname,
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  trailing: Obx(() => Text(
                                        "Rs ${controller.lstc[i].Rs}",
                                        style:
                                            TextStyle(color: Colors.green[300]),
                                      )),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.grey[300],
                                    child: Obx(() => Text(
                                          "${controller.lstc[i].cname.substring(0, 2).toUpperCase()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )),
                                  )),
                            );
                          },
                          itemCount: controller.lstc.length,
                        ))),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 250,
            // decoration: BoxDecoration(
            //     color: Colors.black, borderRadius: BorderRadius.circular(30)),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => AddCustomerfromContacts())));
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.add),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "ADD CUSTOMER",
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
          )
        ],
      ),
    );
  }
}
