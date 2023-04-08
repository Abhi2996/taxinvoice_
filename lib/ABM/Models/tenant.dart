/////customer
class Tenant {
  final int flat_no; //customer id
  final String name; //customer name
  final String door_no;
  final String mobileno;
  final String email;
  List<BillReport>? billReports;
  final String? bankName;
  final String? BAddress;
  final String? bAcountNo;
  final String? IFSCODE;

  Tenant({
    required this.flat_no,
    required this.name,
    required this.door_no,
    required this.mobileno,
    required this.email,
    this.billReports,
    this.bankName,
    this.BAddress,
    this.bAcountNo,
    this.IFSCODE,
  });

  //convert to map
  Map<String, dynamic> toMap() => {
        'flat_id': flat_no,
        'name': name,
        'door_no': door_no,
        'mobileno': mobileno,
        'email': email,
        /////////BANK//////
        'bankName': bankName,
        'BAddress': BAddress,
        'bAcountNo': bAcountNo,
        'IFSCODE': IFSCODE,
      };

  //convert Map to Tenant
  factory Tenant.fromMap(Map<String, dynamic> map) => Tenant(
        flat_no: map["flat_id"],
        name: map["name"],
        door_no: map["door_no"],
        mobileno: map["mobileno"],
        email: map["email"],
        /////////BANK//////
        bankName: map['bankName'],
        BAddress: map['BAddress'],
        bAcountNo: map['bAcountNo'],
        IFSCODE: map['IFSCODE'],
      );
}

class BillReport {
  final int? id; //item id
  final String? date;
  final double? rentalBill; //item QTY
  final double? otherBill; //Price
  final double? totalBill; // Qty*price
  final double? tax;
  final int? flatId; //customer Id

  BillReport({
    this.id,
    this.date,
    this.rentalBill,
    this.otherBill,
    this.totalBill,
    this.tax,
    this.flatId,
  });

  //convert to map
  Map<String, dynamic> RtoMap() => {
        'id': id,
        'date': date,
        'rentalBill': rentalBill,
        'otherBill': otherBill,
        'totalBill': totalBill,
        'tax': tax,
        'flat_id': flatId,
      };

  //convert Map to BillReport
  factory BillReport.fromMap(Map<String, dynamic> map) => BillReport(
        id: map["id"],
        date: map["date"],
        rentalBill: map["rentalBill"],
        otherBill: map["otherBill"],
        totalBill: map["totalBill"],
        tax: map['tax'],
        flatId: map["flat_id"],
      );
}


/*
class Tenant {
  final int flat_no; //customer id
  final String name; //customer name
  final String door_no;
  final String mobileno;
  final String email;
  List<BillReport>? billReports;

  Tenant({
    required this.flat_no,
    required this.name,
    required this.door_no,
    required this.mobileno,
    required this.email,
    this.billReports,
  });

  //convert to map
  Map<String, dynamic> toMap() => {
        'flat_id': flat_no,
        'name': name,
        'door_no': door_no,
        'mobileno': mobileno,
        'email': email,
      };

  //convert Map to Tenant
  factory Tenant.fromMap(Map<String, dynamic> map) => Tenant(
        flat_no: map["flat_id"],
        name: map["name"],
        door_no: map["door_no"],
        mobileno: map["mobileno"],
        email: map["email"],
      );
}

class BillReport {
  final int? id; //item id
  final String? date;
  final double? rentalBill; //item QTY
  final double? otherBill; //Price
  final double? totalBill; // Qty*price
  final int? flatId; //customer Id

  BillReport({
    this.id,
    this.date,
    this.rentalBill,
    this.otherBill,
    this.totalBill,
    this.flatId,
  });

  //convert to map
  Map<String, dynamic> RtoMap() => {
        'id': id,
        'date': date,
        'rentalBill': rentalBill,
        'otherBill': otherBill,
        'totalBill': totalBill,
        'flat_id': flatId,
      };

  //convert Map to BillReport
  factory BillReport.fromMap(Map<String, dynamic> map) => BillReport(
        id: map["id"],
        date: map["date"],
        rentalBill: map["rentalBill"],
        otherBill: map["otherBill"],
        totalBill: map["totalBill"],
        flatId: map["flat_id"],
      );
}

*/