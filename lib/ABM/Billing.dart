import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project/ABM/database/MyDatabase.dart';

import 'Models/tenant.dart';
import 'package:intl/intl.dart';

class Billing extends StatefulWidget {
  final MyDataBase myDataBase;

  // final ReportData _reportData;
  const Billing({super.key, required this.tenant, required this.myDataBase});
  final Tenant tenant;

  @override
  State<Billing> createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  var formkey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _flat_NumberController = TextEditingController();
  var _houseDoorController = TextEditingController();
  var _mobile_NOController = TextEditingController();
  var emailController = TextEditingController();

  ///
  var QtyController = TextEditingController();
  var PriceController = TextEditingController();
  var powerBillController = TextEditingController();
  var other_BillController = TextEditingController();
  double? totalAmount_Bill;
  String? formattedDate;
  //
  DateTime _selectedDate = DateTime.now();

  ///

  @override
  void calculateTotalBill() {
    final rentalBill = double.tryParse(QtyController.text) ?? 0.0;
    final waterBill = double.tryParse(PriceController.text) ?? 0.0;
    final powerBill = double.tryParse(powerBillController.text) ?? 0.0;
    final otherBill = double.tryParse(other_BillController.text) ?? 0.0;

    setState(() {
      totalAmount_Bill = rentalBill + waterBill + powerBill + otherBill;
    });
  }

  void initState() {
    calculateTotalBill();
    super.initState();
  }

  Widget build(BuildContext context) {
    //
    formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);

    //
    _nameController.text = "${widget.tenant.name}";
    _flat_NumberController.text = "${widget.tenant.flat_no}";
    _houseDoorController.text = "${widget.tenant.door_no}";
    _mobile_NOController.text = "${widget.tenant.mobileno}";
    emailController.text = "${widget.tenant.email}";
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Billing"),
      //   centerTitle: true,
      //   backgroundColor: Colors.black,
      // ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 18, right: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    //title and invoice no and date
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // decoration: BoxDecoration(
                              //   color: Color.fromARGB(255, 252, 251, 251),
                              //   border: Border.all(
                              //     color: Colors.black,
                              //     width: 2,
                              //   ),
                              //   borderRadius: BorderRadius.circular(5),
                              // ),
                              color: Color.fromARGB(255, 239, 239, 239),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  "Rent Invoice",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            //
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Container(
                                width: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Invoice  no:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 16, 0, 0),
                                      ),
                                    ),
                                    Text(
                                      "Date:$formattedDate",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 16, 0, 0),
                                      ),
                                    ),
                                    Text(
                                      "Due date    :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 16, 0, 0),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 50,
                    ),
                    ///////////////////////
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //tenant addressS
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   border: Border.all(
                              //     color: Colors.black,
                              //     width: 2,
                              //   ),
                              //   borderRadius: BorderRadius.circular(5),
                              // ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tenant",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Name : ${widget.tenant.name}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Color.fromARGB(255, 16, 0, 0),
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Flat no :${widget.tenant.flat_no}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Color.fromARGB(255, 16, 0, 0),
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Door no :${widget.tenant.door_no}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Color.fromARGB(255, 16, 0, 0),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Address :',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Color.fromARGB(255, 16, 0, 0),
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Contact no : ${widget.tenant.mobileno}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Color.fromARGB(255, 16, 0, 0),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          // owner/use  detailes
                          Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   border: Border.all(
                              //     color: Colors.black,
                              //     width: 2,
                              //   ),
                              //   borderRadius: BorderRadius.circular(5),
                              // ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Owner",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Name :[owner name]',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Color.fromARGB(255, 16, 0, 0),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Address:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Color.fromARGB(255, 16, 0, 0),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Contact no: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Color.fromARGB(255, 16, 0, 0),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    //bill descriptions
                    PopupMenuDivider(),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FixedColumnWidth(150),
                          1: FlexColumnWidth(),
                        },
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                  child: Text(
                                'Item Name',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                              TableCell(
                                  child: Text('Qty',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))),
                              TableCell(
                                  child: Text('Price',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Text('Rental amount')),
                              TableCell(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: QtyController,
                                  validator: (Value) =>
                                      Value == "" ? "Rental amount" : null,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.currency_rupee,
                                      color: Colors.black,
                                    ),
                                    hintText: "Rental amount.....",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                            color: Colors.white60)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                            color: Colors.white60)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white60)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                            color: Colors.white60)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 6),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ), /*Text('\₹$renatlAmout')*/
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Text('Power Bill')),
                              TableCell(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: powerBillController,
                                  validator: (Value) => Value == ""
                                      ? "Please enter Power Bill"
                                      : null,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.currency_rupee,
                                      color: Colors.black,
                                    ),
                                    hintText: "Power Bill",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                            color: Colors.white60)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                            color: Colors.white60)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white60)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                            color: Colors.white60)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 6),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Text('Water Bill')),
                              TableCell(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: PriceController,
                                  validator: (Value) => Value == ""
                                      ? "Please eneter Water bill "
                                      : null,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.currency_rupee,
                                      color: Colors.black,
                                    ),
                                    hintText: "Water Bills.....",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                            color: Colors.white60)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                            color: Colors.white60)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white60)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                            color: Colors.white60)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 6),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Text('Other Bills')),
                              TableCell(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: other_BillController,
                                  validator: (Value) =>
                                      Value == "" ? "Other Bills" : null,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.currency_rupee,
                                      color: Colors.black,
                                    ),
                                    hintText: "Other Bills.....",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                            color: Colors.white60)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                            color: Colors.white60)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white60)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: const BorderSide(
                                            color: Colors.white60)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 6),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                  child: Text('Total',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))),
                              TableCell(
                                child: Text(
                                  "\₹$totalAmount_Bill",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          PopupMenuDivider(),
                          Text("Signnature of Approval")
                        ],
                      ),
                    ),
                    Container(
                      child: InkWell(
                        onTap: () async {
                          try {
                            calculateTotalBill();
                            final billReport = BillReport(
                                date: formattedDate,
                                rentalBill: double.tryParse(QtyController.text),
                                otherBill:
                                    double.tryParse(other_BillController.text),
                                totalBill: totalAmount_Bill,
                                flatId: int.parse(_flat_NumberController.text));
                            await widget.myDataBase
                                .insertReportlist(billReport);

                            ///////////////
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    '${billReport.flatId}  :Added to DataBase')));
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text("$e")));
                          }

                          if (formkey.currentState!.validate()) {
                            //validate the

                            if (mounted) {}
                          }
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 28,
                          ),
                          child: Text(
                            "Save Report",
                            style: TextStyle(
                                color: Color.fromARGB(255, 3, 12, 180),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
