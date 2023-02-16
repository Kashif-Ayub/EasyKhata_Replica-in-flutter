import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String number = "03113477394";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 340,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your Name",
                      style: TextStyle(
                          color: Colors.grey[500], fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "$number",
                      style: TextStyle(
                          color: Colors.grey[500], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white),
                margin: EdgeInsets.only(left: 120),
                child: IconButton(
                  icon: Icon(
                    Icons.mode_edit_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
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
                  tooltip: "Visiting Cards",
                  onPressed: () {},
                  icon: Icon(
                    Icons.card_membership,
                    color: Colors.amber,
                    size: 30,
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[100]),
              margin: EdgeInsets.only(top: 10, left: 40, right: 20),
              child: IconButton(
                  tooltip: "Visiting Cards",
                  onPressed: () {},
                  icon: Icon(
                    Icons.payment_sharp,
                    color: Colors.blue,
                    size: 30,
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[100]),
              margin: EdgeInsets.only(top: 10, left: 40),
              child: IconButton(
                  tooltip: "Visiting Cards",
                  onPressed: () {},
                  icon: Icon(
                    Icons.change_circle,
                    color: Colors.amber,
                    size: 30,
                  )),
            )
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, left: 30),
              child: Text(
                "Visting cards",
                style: TextStyle(fontSize: 14),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 45),
              child: Text("Collect"),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 40),
              child: Text("App Language"),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          height: 380,
          width: 380,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return EntryItem(data[index]);
            },
            itemCount: data.length,
          ),
        )
      ],
    );
  }
}

class Entry {
  final String title;
  final List<Entry> children;
  Entry(this.title, [this.children = const <Entry>[]]);
}

final List<Entry> data = <Entry>[
  Entry("Business details", <Entry>[
    Entry(
      "Business name",
    ),
    Entry("Business type"),
  ]),
  Entry("App Settings", <Entry>[
    Entry("Backup Information"),
    Entry("App lock"),
    Entry("Privacy Policy")
  ]),
  Entry("Deleted Items"),
  Entry("Share"),
  Entry("Rate Easy Khata"),
];

class EntryItem extends StatelessWidget {
  final entry;
  const EntryItem(this.entry);
  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        title: Text(
          root.title,
          style: TextStyle(color: Colors.black),
        ),
        leading: root.title == "Business name"
            ? Icon(Icons.business)
            : root.title == "Business type"
                ? Icon(Icons.add_business_rounded)
                : root.title == "Deleted Items"
                    ? Icon(Icons.delete)
                    : root.title == "Share"
                        ? Icon(Icons.share)
                        : root.title == "Backup Information"
                            ? Icon(Icons.backup)
                            : root.title == "App lock"
                                ? Icon(Icons.lock)
                                : root.title == "Privacy Policy"
                                    ? Icon(Icons.privacy_tip)
                                    : Icon(Icons.star_border),
      );
    }
    return ExpansionTile(
        leading: root.title == "Business details"
            ? Icon(Icons.business_center)
            : Icon(Icons.settings),
        title: Text(root.title),
        key: PageStorageKey<Entry>(root),
        children: root.children.map<Widget>(_buildTiles).toList());
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
