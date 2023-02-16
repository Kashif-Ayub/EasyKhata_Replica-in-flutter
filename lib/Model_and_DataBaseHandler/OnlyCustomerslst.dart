class OnlyCustomersinfo {
  var cname;
  var cnum;
  var Rs;
  OnlyCustomersinfo(
      {required this.cname, required this.cnum, required this.Rs});
  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = Map();
    mp["cname"] = cname;
    mp["cnum"] = cnum;
    mp["Rs"] = Rs;
    return mp;
  }

  OnlyCustomersinfo.fromMap(Map<String, dynamic> mp) {
    cname = mp["cname"];
    cnum = mp["cnum"];
    Rs = mp["Rs"];
  }
}
