import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project/ABM/Models/tenant.dart';

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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Try Again: \n$e  :bug!!')));
    }
  }
//==========================-------------

  bool isLoading = false;
  String? formattedDate;
  //
  DateTime _selectedDate = DateTime.now();

  //List<Items> _items = List.empty(growable: true);
  //List<Items> _items = [];

  final MyDataBase myDataBase = MyDataBase();
  @override
  //totest

  // getDataFromDb() async {
  //   await _myDataBase.initializedDatabase();
  //   List<Map<String, Object?>> map = await _myDataBase
  //       .getBillByFlat_nolist('${widget.cOSTOMER?.costomer_id}');
  //   _items = [];
  //   for (int i = 0; i < map.length; i++) {
  //     _items.add(Items.fromMap(map[i]));
  //   }
  // }

  //
  //
  // getDataFromDb() async {
  //   await _myDataBase.initializedDatabase();
  //   List<Map<String, Object?>> map = await _myDataBase.getBillreportlist();
  //   billReports = [];
  //   for (int i = 0; i < map.length; i++) {
  //     billReports.add(BillReport.fromMap(map[i]));
  //   }
  // }

//
  int? InVoiceNO;
  void genarateInvoce_Number() {
    Random random = new Random();
    InVoiceNO = random.nextInt(900000) + 100000;
  }

  void initState() {
    setState(() {
      getDataFromDb();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    genarateInvoce_Number();
    //current time
    formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    //var companyName;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Row(
        children: [
          Text('Invoice Form'),
          IconButton(
              onPressed: () {
                setState(() {
                  _refreshData();
                });
              },
              icon: Icon(Icons.refresh))
        ],
      )),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Row(children: [
                  Image.asset(
                    'assets/logo1.jpg',
                    width: 150,
                    height: 120,
                  ),
                  SizedBox(width: 50),
                  SizedBox(
                    width: 150,
                    height: 120,
                    child: InkWell(
                      // onTap: () async {
                      //   print("tapped");
                      //   final query = 'SELECT * FROM users';
                      //   final result = await DatabaseHelper.rawQuery(query);
                      //   print(result);

                      //   final companyName = result[0]['coname'];
                      //   print(companyName);

                      // },
                      child: ListTile(
                        onTap: () async {
                          print("tapped");
                          final query = 'SELECT * FROM users';
                          final result = await DatabaseHelper.rawQuery(query);
                          print(result);

                          final companyName = result[0]['coname'];
                          print(companyName);
                        },

                        // },
                        //change...................................................
                        // title: Text('${widget.customers1?.amt}',
                        title: Text('SM Softwares',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                fontFamily: 'OpenSans'),
                            textAlign: TextAlign.start),
                        subtitle: Text(
                            '\nBunts Hostel\nMangalore\n9880438931\nsm@gmail.com',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                fontFamily: 'OpenSans')),

                        //       onTap: () async {
                        //   print("tapped");
                        //   final query = 'SELECT * FROM users';
                        //   final result = await DatabaseHelper.rawQuery(query);
                        //   print(result);

                        //   final companyName = result[0]['coname'];
                        //   //xyzController.text = companyName;

                        //   print(companyName);

                        // },
                        //controller: xyzController,
                      ),

                      //     child: TextFormField(
                      //       minLines: 1,
                      //       maxLines: 4,
                      //       // "${companyName},\n$companyAddress\n$companyPhone\n$companyID\n$contactphone",
                      //       //companyName,
                      //       onTap: () async {
                      //   print("tapped");
                      //   final query = 'SELECT * FROM users';
                      //   final result = await DatabaseHelper.rawQuery(query);
                      //   print(result);

                      //   // final companyADD = result[1]['coadd'];
                      //   // final companyPhone=result[3]['cophone'];
                      //   // final company_ID =result[3]['companyID'];
                      //   // final contactPHONE = result[4]['contactphone'];
                      //   // final email_id =result[5]['email'];

                      //   // ADDController.text = companyName;
                      //   // PhoneController.text = companyPhone;
                      //   // IDController.text =company_ID;
                      //   // COPHONEController.text = contactPHONE;
                      //   // EMAILController.text = email_id;

                      //   // print(companyADD);
                      //   // print(companyPhone);
                      //   // print(company_ID);
                      //   // print(contactPHONE);
                      //   // print(email_id);

                      // },
                      //       style: TextStyle(
                      //         fontStyle: FontStyle.normal,
                      //         fontWeight: FontWeight.normal,
                      //         fontFamily: 'OpenSans',
                      //         fontSize: 15,
                      //       ),
                      //       textAlign: TextAlign.start,
                      //     ),
                    ),
                  ),
                ]),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ///////////////////////////////////////////////////==
                  //////////////////==
                  Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  ListTile(
                    title: Text(
                      "INVOICE\n",
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold),
                          "Invoice No:$InVoiceNO",
                        ),
                        Text(
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold),
                          "Invoice Date:$formattedDate",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: ListTile(
                      title: Text(
                        'Customer Info:\n',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name:${widget.CUSTOMER?.name}",
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Address:${widget.CUSTOMER?.email}",
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Contact No:${widget.CUSTOMER?.mobileno}",
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                          /*
                            Text(cOSTOMER
                              'Address: ${widget.customers1?.cuadd.toString()}\nPhone: ${widget.cOSTOMER?..mobileno.toString()}\nEmail: ${widget.customers1?.cuemail.toString()}\nAmount Paid: ${widget.customers1?.amt}',
                              style:
                                  TextStyle(fontFamily: 'OpenSans', fontSize: 15),
                            ),
                            */
                        ],
                      ),
                    ),
                  )
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
                      // DataTable(
                      //   columns: const <DataColumn>[

                      //     DataColumn(
                      //       label: Text(
                      //         'Item',
                      //         style: TextStyle(
                      //             fontFamily: 'OpenSans',
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //     ),
                      //     DataColumn(
                      //       label: Text(
                      //         'Item Name',
                      //         style: TextStyle(
                      //             fontFamily: 'OpenSans',
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //     ),
                      //     DataColumn(
                      //       label: Text(
                      //         'Price',
                      //         style: TextStyle(
                      //             fontFamily: 'OpenSans',
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //     ),
                      //   ],
                      //   rows: const <DataRow>[
                      //     DataRow(
                      //       cells: <DataCell>[
                      //         DataCell(Text('',
                      //             style: TextStyle(
                      //                 fontFamily: 'OpenSans',
                      //                 fontWeight: FontWeight.normal))),
                      //         DataCell(Text('Rs.200',
                      //             style: TextStyle(
                      //                 fontFamily: 'OpenSans',
                      //                 fontWeight: FontWeight.normal))),
                      //         DataCell(Text("2",
                      //             style: TextStyle(
                      //                 fontFamily: 'OpenSans',
                      //                 fontWeight: FontWeight.normal))),
                      //         DataCell(Text("Rs.400",
                      //             style: TextStyle(
                      //                 fontFamily: 'OpenSans',
                      //                 fontWeight: FontWeight.normal))),
                      //       ],
                      //     ),
                      //     DataRow(
                      //       cells: <DataCell>[
                      //         DataCell(Text('Monitor',
                      //             style: TextStyle(
                      //                 fontFamily: 'OpenSans',
                      //                 fontWeight: FontWeight.normal))),
                      //         DataCell(Text('Rs.10,000',
                      //             style: TextStyle(
                      //                 fontFamily: 'OpenSans',
                      //                 fontWeight: FontWeight.normal))),
                      //         DataCell(Text('1',
                      //             style: TextStyle(
                      //                 fontFamily: 'OpenSans',
                      //                 fontWeight: FontWeight.normal))),
                      //         DataCell(Text("Rs,10,000",
                      //             style: TextStyle(
                      //                 fontFamily: 'OpenSans',
                      //                 fontWeight: FontWeight.normal)))
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      /*
                      DataTable(
                          // Datatable widget that have the property columns and rows.
                          columns: [
                            // Set the name of the column
                            DataColumn(
                              label: Text('ID'),
                            ),
                            DataColumn(
                              label: Text('Name'),
                            ),
                            DataColumn(
                              label: Text('LastName'),
                            ),
                            DataColumn(
                              label: Text('Age'),
                            ),
                          ],
                          rows: [
                            // Set the values to the columns
                            DataRow(cells: [
                              DataCell(Text("${widget.items?.itemid}")),
                              DataCell(Text("Alex")),
                              DataCell(Text("Anderson")),
                              DataCell(Text("18")),
                            ]),
                            DataRow(cells: [
                              DataCell(Text("2")),
                              DataCell(Text("John")),
                              DataCell(Text("Anderson")),
                              DataCell(Text("24")),
                            ]),
                          ]),
                          */

                      DataTable(
                        columns: [
                          DataColumn(
                            label: Text(
                              "Item Id",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "QTY ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              " Price",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              " Total",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                        rows: billReports
                            .map<DataRow>((e) => DataRow(
                                  cells: [
                                    DataCell(Text(
                                      e.id.toString(),
                                      style: TextStyle(),
                                    )),
                                    DataCell(
                                        Text(e.rentalBill.toString())), //QTY
                                    DataCell(
                                        Text(e.otherBill.toString())), //price
                                    DataCell(Text(e.totalBill.toString())),
                                  ],
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "GRAND TOTAL:",
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
                      "Bank Name:${widget.CUSTOMER?.bankName} \nBank Address:${widget.CUSTOMER?.BAddress} \nA/c no:${widget.CUSTOMER?.bAcountNo} \nIFSc:${widget.transactions?.bifsc} \n",
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
                  ListTile(title: Text("TERMS & CONDITIONS\n")),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}


/////////////////////////
///
