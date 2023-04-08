import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/ABM/Models/tenant.dart';
import 'dart:ui' as ui;
import 'package:project/ABM/database/MyDatabase.dart';
import 'package:project/modalCustomer.dart';
import 'db_helper.dart';
import 'modalItem.dart';
import 'modalTransaction.dart';
import 'transaction details.dart';
import 'modalCompany.dart';
import 'DashBoard.dart';
import 'package:intl/intl.dart';

class InvoicePage extends StatefulWidget {
  final Customer? customers1;
  final Tenant? CUSTOMER;

  const InvoicePage({
    super.key,
    this.customers1,
    this.transactions,
    this.items,
    this.CUSTOMER,
  });

  final Transactions? transactions;
  final Item? items;

//

//

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final String companyName = '';

  final TextEditingController xyzController = TextEditingController();

  final TextEditingController ADDController = TextEditingController();

  final TextEditingController PhoneController = TextEditingController();

  final TextEditingController IDController = TextEditingController();

  final TextEditingController COPHONEController = TextEditingController();

  final TextEditingController EMAILController = TextEditingController();
  final TextEditingController itemName = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController BNAME = TextEditingController();
  final TextEditingController BADD = TextEditingController();
  final TextEditingController BACC = TextEditingController();
  final TextEditingController BIFSC = TextEditingController();

  String result = "";
  String _message = '';
//  final String companyName = '';
  String companyAddress = '';
  String companyPhone = '';
  String companyID = '';
  String contactphone = '';
  String email = '';

//
//==========================-------------
  List<BillReport> billReports = [];
  double GrandTotal = 0;
  final MyDataBase _myDataBase = MyDataBase();
  @override
  //totest

  getDataFromDb() async {
    await _myDataBase.initializedDatabase();
    List<Map<String, Object?>> map =
        await _myDataBase.getBillByFlat_nolist('${widget.CUSTOMER?.flat_no}');
    billReports = [];
    for (int i = 0; i < map.length; i++) {
      billReports.add(BillReport.fromMap(map[i]));
    }
  }

  void finalGrandTotal() {
    GrandTotal = 0;
    for (int i = 0; i < billReports.length; i++) {
      GrandTotal += billReports[i].totalBill!;
    }
    //GrandTotal = GrandTotal + (100 * 0.18);
  }

  // getDataFromDb() async {
  //   await _myDataBase.initializedDatabase();
  //   List<Map<String, Object?>> map = await _myDataBase.getBillreportlist();
  //   billReports = [];
  //   for (int i = 0; i < map.length; i++) {
  //     billReports.add(BillReport.fromMap(map[i]));
  //   }
  // }

  ///Refreshing list view
  Future<void> _refreshData() async {
    // Call a method to retrieve the updated data
    try {
      List<BillReport> updatedData = await getDataFromDb();

      // Call setState() to rebuild the widget with the updated data

      setState(() {
        billReports = updatedData;
      });
    } catch (e) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('Try Again: \n$e  :bug!!')));
    }
  }
//==========================-------------

  bool isLoading = false;
  String? formattedDate;
  //
  DateTime _selectedDate = DateTime.now();
  final GlobalKey globalKey = GlobalKey();
  //List<Items> _items = List.empty(growable: true);
  //List<Items> _items = [];

  final MyDataBase myDataBase = MyDataBase();
  @override
  int? InVoiceNO;
  void genarateInvoce_Number() {
    Random random = new Random();
    InVoiceNO = random.nextInt(900000) + 100000;
  }

  void initState() {
    super.initState();

    getDataFromDb();
  }

  @override
  Widget build(BuildContext context) {
    genarateInvoce_Number();
    finalGrandTotal();
    //current time
    formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    //var companyName;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Row(
        children: [
          Text('Invoice Form'),
        ],
      )),
      body: RepaintBoundary(
        key: globalKey,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/logo1.jpg',
                        width: 150,
                        height: 120,
                      ),
                      SizedBox(width: 50),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            print("tapped");

                            final query = 'SELECT * FROM users';
                            final result = await DatabaseHelper.rawQuery(query);

                            print(result);

                            final companyName = result[0]['coname'];
                            print(companyName);
                          },
                          child: ListTile(
                            title: Text(
                              'SM Softwares',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bunts Hostel',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                                Text(
                                  'Mangalore',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                                Text(
                                  '9880438931',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                                Text(
                                  'sm@gmail.com',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // Invoice header
                    Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    ListTile(
                      title: Text(
                        "INVOICE",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Invoice No: $InVoiceNO",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Invoice Date: $formattedDate",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Customer Info
                    Container(
                      child: ListTile(
                        title: Text(
                          'Customer Info:',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: ${widget.CUSTOMER?.name}",
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Address: ${widget.CUSTOMER?.email}",
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Contact No: ${widget.CUSTOMER?.mobileno}",
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      DataTable(
                        columns: [
                          DataColumn(
                            label: Text("Item Id",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          DataColumn(
                            label: Text("QTY",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          DataColumn(
                            label: Text("Price",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          DataColumn(
                            label: Text("Total",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          )
                        ],
                        rows: billReports
                            .map<DataRow>((e) => DataRow(
                                  cells: [
                                    DataCell(Text(e.id.toString())),
                                    DataCell(Text(e.rentalBill.toString())),
                                    DataCell(Text(e.otherBill.toString())),
                                    DataCell(Text(e.totalBill.toString())),
                                  ],
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "GRAND TOTAL:$GrandTotal",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 1, 66, 11)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "PAYMENT METHOD\n",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Bank Name: ${widget.CUSTOMER?.bankName} \n"
                        "Bank Address: ${widget.CUSTOMER?.BAddress} \n"
                        "A/c no: ${widget.CUSTOMER?.bAcountNo} \n"
                        "IFSc: ${widget.CUSTOMER?.IFSCODE} \n",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Text("TERMS & CONDITIONS\n"),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 218, 238, 255),
            child: Icon(Icons.picture_as_pdf),
            onPressed: () async {
              // Navigate to Add Page CustomerForm
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Download This!!?'),
                    content:
                        Text('Are you sure you want to Download this Pdf?'),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop(true);
                          RenderRepaintBoundary? boundary =
                              globalKey.currentContext?.findRenderObject()
                                  as RenderRepaintBoundary?;
                          if (boundary != null) {
                            ui.Image image =
                                await boundary.toImage(pixelRatio: 100.0);
                            ByteData? byteData = await image.toByteData(
                                format: ui.ImageByteFormat.png);
                            Uint8List pngBytes = byteData!.buffer.asUint8List();
                            final result =
                                await ImageGallerySaver.saveImage(pngBytes);
                            print(result);
                            var status = await Permission.storage.request();
                            if (status.isGranted) {
                              // Permission granted. Save the image.
                              // ...
                              final result =
                                  await ImageGallerySaver.saveImage(pngBytes);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Downloaded')));
                            } else {
                              // Permission denied. Handle the error.
                              // ...
                            }
                          }
                        },
                        child: Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Perform delete operation here
                          Navigator.of(context).pop(false);
                          ;
                        },
                        child: Text('No'),
                      ),
                    ],
                  );
                },
              ).then((value) {
                if (value == true) {
                  // Perform delete operation here
                }
              });

////////////////////////
            },
          ),
          FloatingActionButton(
              backgroundColor: Color.fromARGB(88, 218, 238, 255),
              child: Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: () async {
                // Navigate to Add Page CustomerForm
                setState(() {
                  _refreshData();
                });
////////////////////////
              }),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


/////////////////////////
///
