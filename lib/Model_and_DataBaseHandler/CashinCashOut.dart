class CashInCashOut {
  var time;
  var date;
  var cashin;
  var cashout;

  CashInCashOut(
      {required this.time,
      required this.date,
      required this.cashin,
      required this.cashout});
  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = Map();
    mp["time"] = time;
    mp["date"] = date;
    mp["cashin"] = cashin;
    mp["cashout"] = cashout;

    return mp;
  }

  CashInCashOut.fromMap(Map<String, dynamic> mp) {
    time = mp["time"];
    date = mp["date"];
    cashin = mp["cashin"];
    cashout = mp["cashout"];
  }
}
