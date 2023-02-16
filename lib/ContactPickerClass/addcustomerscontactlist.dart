import 'dart:ui';
import 'package:easykhataasg/AddCustomerScreen.dart';
import 'package:easykhataasg/GetxControllers/AddCustomerScreenController,.dart';
import 'package:easykhataasg/HomeScreen.dart';
import 'package:easykhataasg/Model_and_DataBaseHandler/OnlyCustomerslst.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easykhataasg/Model_and_DataBaseHandler/DBHandler.dart';
import 'package:easykhataasg/GetxControllers/AddCustomerScreenController,.dart';

class AddCustomerfromContacts extends StatefulWidget {
  const AddCustomerfromContacts({Key? key}) : super(key: key);

  @override
  State<AddCustomerfromContacts> createState() =>
      _AddCustomerfromContactsState();
}

class _AddCustomerfromContactsState extends State<AddCustomerfromContacts> {
  TextEditingController searchController = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController contactcontroller = TextEditingController();
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AskforPermissions();

    searchController.addListener(() {
      filterContacts();
    });
    _CreateInstance();
  }

  late Dbhandler db;
  _CreateInstance() {
    Dbhandler.getInstance().then((value) {
      db = value;
    });
  }

  void AskforPermissions() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      getAllContacts();
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Kindly Allow the Permission to Load Contacts",
        ),
        duration: Duration(seconds: 5),
      ));
      if (await Permission.contacts.request().isGranted) {
        getAllContacts();
      } else if (await Permission.contacts.isPermanentlyDenied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("as you denied so add customers manually"),
          duration: Duration(seconds: 5),
        ));
      }
    }
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String contactName = contact.displayName!.toLowerCase();
        return contactName.contains(searchTerm);
      });
      setState(() {
        contactsFiltered = _contacts;
      });
    }
  }

  getAllContacts() async {
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();

    setState(() {
      contacts = _contacts;
    });
  }

  bool _addnew = false;
  final controller = Get.put(AddCustomerScreenController());
  @override
  Widget build(BuildContext context) {
    // AskforPermissions();

    bool isSearching = searchController.text.isNotEmpty;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => HomeScreen())));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          "AddCustomer",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: _addnew == false
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: 3,
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: "Search",
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black)),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),

                  width: double.infinity,
                  // decoration: BoxDecoration(
                  //     color: Colors.black, borderRadius: BorderRadius.circular(30)),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _addnew = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                style: BorderStyle.solid, color: Colors.blue),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.add_rounded,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "ADD A NEW CUSTOMER",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, int i) {
                      Contact contact = isSearching == true
                          ? contactsFiltered[i]
                          : contacts[i];
                      return ListTile(
                          title: Text(contact.displayName.toString()),
                          subtitle: Text(
                              (contact.phones?.elementAt(0).value).toString()),
                          trailing: Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                elevation: 0,
                              ),
                              onPressed: () async {
                                var cust = OnlyCustomersinfo(
                                        cname: contact.displayName.toString(),
                                        cnum:
                                            (contact.phones?.elementAt(0).value)
                                                .toString(),
                                        Rs: 0)
                                    .obs;
                                await db.InsertCustomerInfo(cust);
                                controller.customers();

                                var phn = (contact.phones?.elementAt(0).value)
                                    .toString();

                                print(contact.displayName.toString());
                                print(phn);
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String shopphone =
                                    prefs.getString("number").toString();
                                print("$shopphone");
                              },
                              child: Text(
                                "ADD",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          leading: (contact.avatar != null &&
                                  contact.avatar!.length > 0)
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(
                                      contact.avatar!.buffer.asUint8List()),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                  child: Text(
                                    contact.initials(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ));
                    },
                    itemCount: isSearching == true
                        ? contactsFiltered.length
                        : contacts.length,
                  ),
                )
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: TextField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black)),
                        prefixIcon: Icon(
                          Icons.perm_identity,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: TextField(
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: false, signed: false),
                      controller: contactcontroller,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black)),
                        prefixIcon: Icon(
                          Icons.add_call,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 410),
                    width: 250,
                    // decoration: BoxDecoration(
                    //     color: Colors.black, borderRadius: BorderRadius.circular(30)),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
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
            ),
    );
  }
}
