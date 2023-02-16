import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Model_and_DataBaseHandler/DBHandler.dart';
import '../Model_and_DataBaseHandler/OnlyCustomerslst.dart';

class AddCustomerScreenController extends GetxController {
  Dbhandler? db;
  _createInstance() {
    Dbhandler.getInstance().then((value) => db = value);
  }

  var ihavegot = 0.obs;
  var ihavetogive = 0.obs;
  var lstc = List<OnlyCustomersinfo>.empty().obs;
  customers() async {
    await Duration(seconds: 2).delay();

    await db?.getCustomerInfo().then((value) => lstc.value = value);

    print(lstc);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _createInstance();
    customers();
  }
}
