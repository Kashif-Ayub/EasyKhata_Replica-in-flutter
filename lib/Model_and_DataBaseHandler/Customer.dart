class CustomersData {
  var custno;
  var custname;
  var datetime;
  var igave;
  var igot;
  var shopno;
  var balrs; //its the balance that is pending on us to handover to the customer...f
  CustomersData(
      {required this.custno,
      required this.custname,
      required this.datetime,
      required this.igave,
      required this.igot,
      required this.shopno,
      required this.balrs});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = Map();
    mp["cust_no"] = custno;
    mp["cust_name"] = custname;
    mp["datetime"] = datetime;
    mp["i_gave"] = igave;
    mp["i_got"] = igot;
    mp["shop_no"] = shopno;
    mp["balrs"] = balrs;
    return mp;
  }

  CustomersData.fromMap(Map<String, dynamic> mp) {
    custno = mp["cust_no"];
    custname = mp["cust_name"];
    datetime = mp["datetime"];
    igave = mp["i_gave"];
    igot = mp["i_got"];
    shopno = mp["shop_no"];
    balrs = mp["balrs"];
  }
}
