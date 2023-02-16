import 'package:easykhataasg/ContactPickerClass/addcustomerscontactlist.dart';
import 'package:easykhataasg/Model_and_DataBaseHandler/CashinCashOut.dart';
import 'package:easykhataasg/Model_and_DataBaseHandler/Customer.dart';
import 'package:easykhataasg/Model_and_DataBaseHandler/OnlyCustomerslst.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:get/get.dart';

class Dbhandler {
  Database? _db;
  static Dbhandler? _obj = null;
  int _dbversion = 2;

  Dbhandler._Init() {
    _createDb();
  }

  static Future<Dbhandler> getInstance() async {
    if (_obj == null) {
      _obj = Dbhandler._Init();
    }
    return _obj!;
  }

  Future<void> _createDb() async {
    print("called createdb");
    if (_db == null) {
      String dbpath = await getDatabasesPath();
      dbpath += "EasyKhata.db";
      _db = await openDatabase(dbpath, version: _dbversion,
          onCreate: (Database db, int version) async {
        String query1 = ''' 
    
    
        create table Customer(cust_no text,cust_name text,datetime text,i_gave integer ,i_got integer ,shop_no text,balrs integer)''';

        String query2 = '''
create table Customerinfo(cname text,cnum text primary key,Rs integer)
''';

        String query3 =
            ''' create table CashInCashOut(time text ,date text,cashin integer,cashout integer)
''';
        await db.execute(query1);
        await db.execute(query2);
        await db.execute(query3);
      });
    }
  }

  Future<void> InsertCustomer(CustomersData cust) async {
    try {
      print(cust.custname);
      print(cust.custno);
      print(cust.igave);
      print(cust.igot);
      await _db!.insert("Customer", cust.toMap());
    } catch (e) {
      print("Already Inserted" + e.toString());
      debugPrintStack();
    }
  }

  Future<void> InsertCashinCashOut(CashInCashOut c) async {
    try {
      print(c.cashout);
      print(c.cashin);
      print(c.time);
      print(c.date);
      await _db!.insert("CashInCashOut", c.toMap());
    } catch (e) {
      print("Already Inserted" + e.toString());
      debugPrintStack();
    }
  }

  Future<void> InsertCustomerInfo(Rx<OnlyCustomersinfo> oci) async {
    try {
      await _db!.insert("Customerinfo", oci.value.toMap());
    } catch (e) {
      print("Already Inserted");
    }
  }

  Future<void> DelCustomerinfo(OnlyCustomersinfo cust) async {
    try {
      await _db!.rawDelete(
          "delete from Customerinfo where cnum='" + cust.cnum + "' ");
      print(cust.cname + "is deleted ");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<CustomersData>> getCustomers(String cno) async {
    List<CustomersData> c = [];

    var clist = await _db!
        .rawQuery("select * from Customer where cust_no=+'" + cno + "'");
    clist.forEach((element) {
      c.add(CustomersData.fromMap(element));
    });
    return c;
  }

  Future<List<CashInCashOut>> getCashinOut(String date) async {
    List<CashInCashOut> c = [];
    var clist = await _db!
        .rawQuery("select * from CashInCashOut where date='" + date + "'");
    clist.forEach((element) {
      c.add(CashInCashOut.fromMap(element));
    });

    return c;
  }

  Future<List<OnlyCustomersinfo>> getCustomerInfo() async {
    var oci = List<OnlyCustomersinfo>.empty().obs;

    var oclist = await _db!.rawQuery("Select * from Customerinfo");
    oclist.forEach((element) {
      oci.value.add(OnlyCustomersinfo.fromMap(element));
    });

    return oci;
  }
}
