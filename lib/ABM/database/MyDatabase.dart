import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:project/ABM/Models/tenant.dart';
import 'package:sqflite/sqflite.dart';

class MyDataBase {
  static final MyDataBase _myDataBase = MyDataBase._privateConstructor();
  MyDataBase._privateConstructor();

  static late Database _database;
  factory MyDataBase() => _myDataBase;

  static String tableName = 'flat_owner_info';

  static const String columnId = 'flat_id';
  final String columnName = 'name';
  final String columnDoorNo = 'door_no';
  final String columnMobileNo = 'mobileno';
  final String columnEmailId = 'email';
  final String columnBillReports = 'billReports';
//////////////////////////////////
  final String columnbankName = 'bankName';
  final String columnBAddress = 'BAddress';
  final String columnbAcountNo = 'bAcountNo';
  final String columnIFSCODE = 'IFSCODE';

///////////////////
  final String billReportTable = 'bill_report';
  final String billReportColumnId = 'id';
  final String billReportColumnDate = 'date';
  final String billReportColumnRentalBill = 'rentalBill';
  final String billReportColumnOtherBill = 'otherBill';
  final String billReportColumnTotalBill = 'totalBill';
  static final String billReportColumnFlatId = 'flat_id';
  final String billReportForeignKey =
      'FOREIGN KEY ($billReportColumnFlatId) REFERENCES $tableName ($columnId) ON DELETE CASCADE';

  Future<void> initializedDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/flat_owner_info.db';
    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY,'
          '$columnName TEXT, $columnDoorNo INTEGER, $columnMobileNo TEXT,'
          '$columnEmailId TEXT, $columnBillReports TEXT, $columnbankName TEXT,$columnBAddress TEXT,$columnbAcountNo TEXT,$columnIFSCODE TEXT)');

      db.execute('CREATE TABLE $billReportTable ('
          /* '$billReportColumnId INTEGER PRIMARY KEY,'*/
          '$billReportColumnId INTEGER PRIMARY KEY AUTOINCREMENT,'
          '$billReportColumnDate REAL,'
          '$billReportColumnRentalBill REAL,'
          '$billReportColumnOtherBill REAL,'
          '$billReportColumnTotalBill REAL,'
          '$billReportColumnFlatId INTEGER,'
          '$billReportForeignKey'
          ')');
    });
  }

/*Future<void> initializedDatabase() async {
  Directory directory = await getApplicationDocumentsDirectory();
  String path = '${directory.path}/flat_owner_info.db';
  _database = await openDatabase(path, version: 1, onCreate: (db, version) {
    db.execute('CREATE TABLE $tableName ($coloumId INTEGER PRIMARY KEY,'
        '$coloumName TEXT, $coloumDoorNo INTEGER, $coloumMobileNo TEXT,'
        '$coloumEmailId TEXT)');
    db.execute('CREATE TABLE bill_report ('
        'id INTEGER PRIMARY KEY,'
        'rentalBill REAL,'
        'otherBill REAL,'
        'totalBill REAL,'
        'flat_id INTEGER,'
        'FOREIGN KEY (flat_id) REFERENCES $tableName ($coloumId)'
        ' ON DELETE CASCADE'
        ')');
  });
}
*/

  Future<List<Map<String, Object?>>> getFlatOwnerlist() async {
    List<Map<String, Object?>> result =
        await _database.query(tableName, orderBy: columnName);
    return result;
  }

  Future<int> insertFlatOwnerlist(Tenant tenant) async {
    int rowsInserted = await _database.insert(tableName, tenant.toMap());
    return rowsInserted;
  }

  // Future<int> updateFlatOwnerlist(Tenant tenant) async {
  //   int rowsUpdate = await _database.update(tableName, tenant.toMap(),
  //       where: '$columnId=?', whereArgs: [tenant.flat_no]);
  //   return rowsUpdate;
  // }
  Future<int> updateFlatOwnerlist(Tenant tenant) async {
    // Call the 'update' function of the '_database' object to update the row
    // in the SQLite database.
    // The 'tableName' parameter specifies the name of the table to update.
    // The 'tenant.toMap()' parameter specifies the new column values to update the row with.
    // The 'where' parameter specifies the 'WHERE' clause of the SQL statement.
    // The '$columnId=?' parameter specifies that the value of the 'columnId' column should
    // be equal to the value of the 'flat_no' property of the 'tenant' object.
    // The 'whereArgs' parameter provides the value for the '?' placeholder in the 'where' parameter.
    int rowsUpdate = await _database.update(tableName, tenant.toMap(),
        where: '$columnId=?', whereArgs: [tenant.flat_no]);
    // Return the number of rows that were updated.
    return rowsUpdate;
  }

  Future<int> deleteFlatOwnerlist(Tenant tenant) async {
    int rowsdeleted = await _database
        .delete(tableName, where: '$columnId=?', whereArgs: [tenant.flat_no]);
    return rowsdeleted;
  }

  Future<int> countFlatOwnerlist() async {
    List<Map<String, Object?>> result =
        await _database.rawQuery('SELECT COUNT(*) FROM $tableName');
    int count = Sqflite.firstIntValue(result) ?? 0;
    return count;
  }

  Future<List<Map<String, Object?>>> searchFlatOwnerlist(String flatNo) async {
    List<Map<String, Object?>> result = await _database
        .query(tableName, where: '$columnId LIKE ?', whereArgs: ['%$flatNo%']);
    return result;
  }

///////BILL REPORTS------------------

  Future<List<Map<String, Object?>>> getBillByFlat_nolist(String flatId) async {
    List<Map<String, Object?>> result = await _database.query(billReportTable,
        where: '$billReportColumnFlatId LIKE ?', whereArgs: ['%$flatId%']);
    return result;
  }

  Future<List<Map<String, Object?>>> getBillreportlist() async {
    List<Map<String, Object?>> result =
        await _database.query(billReportTable, orderBy: billReportColumnId);
    return result;
  }

  Future<List<Map<String, dynamic>>> query(String table,
      {required String where, required List<int> whereArgs}) async {
    final Database db = await _database;
    return await db.query(table);
  }

//
  Future<int> insertReportlist(BillReport BillReport) async {
    int rowsInserted =
        await _database.insert(billReportTable, BillReport.RtoMap());
    return rowsInserted;
  }

  Future<void> insertBillReport(double rentalBill, double otherBill,
      double totalBill, int flatId, Set<int> set) async {
    final db = await _database;
    await db.insert('bill_report', {
      'rentalBill': rentalBill,
      'otherBill': otherBill,
      'totalBill': totalBill,
      'flat_id': flatId
    });
  }

  Future<void> updateBillReport(int id, double rentalBill, double otherBill,
      double totalBill, int flatId) async {
    final db = await _database;
    await db.update(
        'bill_report',
        {
          'rentalBill': rentalBill,
          'otherBill': otherBill,
          'totalBill': totalBill,
          'flat_id': flatId
        },
        where: 'id = ?',
        whereArgs: [id]);
  }
}


/*

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:project/ABM/Models/tenant.dart';
import 'package:sqflite/sqflite.dart';

class MyDataBase {
  static final MyDataBase _myDataBase = MyDataBase._privateConstructor();
  MyDataBase._privateConstructor();

  static late Database _database;
  factory MyDataBase() => _myDataBase;

  static String tableName = 'flat_owner_info';

  static final String columnId = 'flat_id';
  final String columnName = 'name';
  final String columnDoorNo = 'door_no';
  final String columnMobileNo = 'mobileno';
  final String columnEmailId = 'email';
  final String columnBillReports = 'billReports';
//////////////////////////////////
  final String columnbankName = 'bankName';
  final String columnBAddress = 'BAddress';
  final String columnbAcountNo = 'bAcountNo';
  final String columnIFSCOD = 'IFSCOD';

///////////////////
  final String billReportTable = 'bill_report';
  final String billReportColumnId = 'id';
  final String billReportColumnDate = 'date';
  final String billReportColumnRentalBill = 'rentalBill';
  final String billReportColumnOtherBill = 'otherBill';
  final String billReportColumnTotalBill = 'totalBill';
  static final String billReportColumnFlatId = 'flat_id';
  final String billReportForeignKey =
      'FOREIGN KEY ($billReportColumnFlatId) REFERENCES $tableName ($columnId) ON DELETE CASCADE';

  Future<void> initializedDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/flat_owner_info.db';
    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY,'
          '$columnName TEXT, $columnDoorNo INTEGER, $columnMobileNo TEXT,'
          '$columnEmailId TEXT, $columnBillReports TEXT)');

      db.execute('CREATE TABLE $billReportTable ('
          /* '$billReportColumnId INTEGER PRIMARY KEY,'*/
          '$billReportColumnId INTEGER PRIMARY KEY AUTOINCREMENT,'
          '$billReportColumnDate REAL,'
          '$billReportColumnRentalBill REAL,'
          '$billReportColumnOtherBill REAL,'
          '$billReportColumnTotalBill REAL,'
          '$billReportColumnFlatId INTEGER,'
          '$billReportForeignKey'
          ')');
    });
  }

/*Future<void> initializedDatabase() async {
  Directory directory = await getApplicationDocumentsDirectory();
  String path = '${directory.path}/flat_owner_info.db';
  _database = await openDatabase(path, version: 1, onCreate: (db, version) {
    db.execute('CREATE TABLE $tableName ($coloumId INTEGER PRIMARY KEY,'
        '$coloumName TEXT, $coloumDoorNo INTEGER, $coloumMobileNo TEXT,'
        '$coloumEmailId TEXT)');
    db.execute('CREATE TABLE bill_report ('
        'id INTEGER PRIMARY KEY,'
        'rentalBill REAL,'
        'otherBill REAL,'
        'totalBill REAL,'
        'flat_id INTEGER,'
        'FOREIGN KEY (flat_id) REFERENCES $tableName ($coloumId)'
        ' ON DELETE CASCADE'
        ')');
  });
}
*/

  Future<List<Map<String, Object?>>> getFlatOwnerlist() async {
    List<Map<String, Object?>> result =
        await _database.query(tableName, orderBy: columnName);
    return result;
  }

  Future<int> insertFlatOwnerlist(Tenant tenant) async {
    int rowsInserted = await _database.insert(tableName, tenant.toMap());
    return rowsInserted;
  }

  Future<int> updateFlatOwnerlist(Tenant tenant) async {
    int rowsUpdate = await _database.update(tableName, tenant.toMap(),
        where: '$columnId=?', whereArgs: [tenant.flat_no]);
    return rowsUpdate;
  }

  Future<int> deleteFlatOwnerlist(Tenant tenant) async {
    int rowsdeleted = await _database
        .delete(tableName, where: '$columnId=?', whereArgs: [tenant.flat_no]);
    return rowsdeleted;
  }

  Future<int> countFlatOwnerlist() async {
    List<Map<String, Object?>> result =
        await _database.rawQuery('SELECT COUNT(*) FROM $tableName');
    int count = Sqflite.firstIntValue(result) ?? 0;
    return count;
  }

  Future<List<Map<String, Object?>>> searchFlatOwnerlist(String flatNo) async {
    List<Map<String, Object?>> result = await _database
        .query(tableName, where: '$columnId LIKE ?', whereArgs: ['%$flatNo%']);
    return result;
  }

///////BILL REPORTS------------------

  Future<List<Map<String, Object?>>> getBillByFlat_nolist(String flatId) async {
    List<Map<String, Object?>> result = await _database.query(billReportTable,
        where: '$billReportColumnFlatId LIKE ?', whereArgs: ['%$flatId%']);
    return result;
  }

  Future<List<Map<String, Object?>>> getBillreportlist() async {
    List<Map<String, Object?>> result =
        await _database.query(billReportTable, orderBy: billReportColumnId);
    return result;
  }

  Future<List<Map<String, dynamic>>> query(String table,
      {required String where, required List<int> whereArgs}) async {
    final Database db = await _database;
    return await db.query(table);
  }

//
  Future<int> insertReportlist(BillReport BillReport) async {
    int rowsInserted =
        await _database.insert(billReportTable, BillReport.RtoMap());
    return rowsInserted;
  }

  Future<void> insertBillReport(double rentalBill, double otherBill,
      double totalBill, int flatId, Set<int> set) async {
    final db = await _database;
    await db.insert('bill_report', {
      'rentalBill': rentalBill,
      'otherBill': otherBill,
      'totalBill': totalBill,
      'flat_id': flatId
    });
  }

  Future<void> updateBillReport(int id, double rentalBill, double otherBill,
      double totalBill, int flatId) async {
    final db = await _database;
    await db.update(
        'bill_report',
        {
          'rentalBill': rentalBill,
          'otherBill': otherBill,
          'totalBill': totalBill,
          'flat_id': flatId
        },
        where: 'id = ?',
        whereArgs: [id]);
  }
}
*/