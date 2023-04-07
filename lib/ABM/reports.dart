import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/ABM/HomePage.dart';
import 'package:project/ABM/Models/tenant.dart';
import 'package:project/ABM/database/MyDatabase.dart';

class BillReportList extends StatefulWidget {
  // final int flatId;
  final Tenant tenant;
  const BillReportList({Key? key, required this.tenant}) : super(key: key);

  @override
  _BillReportListState createState() => _BillReportListState();
}

class _BillReportListState extends State<BillReportList> {
  late final PageController pageController;
  ScrollController _scrollController = ScrollController();
  int pageNo = 0;

  Timer? carasouelTmer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 0), (timer) {
      if (pageNo == 4) {
        pageNo = 0;
      }
      pageController.animateToPage(
        pageNo,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCirc,
      );
      pageNo++;
    });
  }

  bool isLoading = false;
  //List<BillReport> billReports = List.empty(growable: true);
  List<BillReport> billReports = [];

  final MyDataBase _myDataBase = MyDataBase();
  @override
  //totest

//////////////
  getDataFromDb() async {
    await _myDataBase.initializedDatabase();
    List<Map<String, Object?>> map =
        await _myDataBase.getBillByFlat_nolist('${widget.tenant.flat_no}');
    billReports = [];
    for (int i = 0; i < map.length; i++) {
      billReports.add(BillReport.fromMap(map[i]));
    }
  }

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

  @override
  void initState() {
    // getDataFromDb();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Handle refresh action
          _refreshData();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(
                  height: 36.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ListTile(
                    onTap: () {},
                    selected: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                    selectedTileColor: Color.fromARGB(255, 255, 146, 140),
                    title: Text(
                      "Bill Report List",
                      style: Theme.of(context).textTheme.subtitle1!.merge(
                            const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                            ),
                          ),
                    ),
                    subtitle: Text(
                      "----------------",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    trailing: PopUpMen(
                      menuList: const [
                        PopupMenuItem(
                          child: ListTile(
                            leading: Icon(
                              CupertinoIcons.person,
                            ),
                            title: Text("My Profile"),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            leading: Icon(
                              CupertinoIcons.option,
                            ),
                            title: Text("Optional"),
                          ),
                        ),
                        PopupMenuDivider(),
                        PopupMenuItem(
                          child: Text("Settings"),
                        ),
                        PopupMenuItem(
                          child: Text("About Us"),
                        ),
                        PopupMenuDivider(),
                        PopupMenuItem(
                          child: ListTile(
                            leading: Icon(
                              Icons.logout,
                            ),
                            title: Text("Log Out"),
                          ),
                        ),
                      ],
                      icon: CircleAvatar(
                        backgroundImage: const NetworkImage(
                          'https://images.unsplash.com/photo-1644982647869-e1337f992828?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80',
                        ),
                        child: Container(),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: kToolbarHeight -
                          8, // adjust the padding value as needed
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: 200,
                        child: TextFormField(
                          // controller: _searcher,
                          validator: (Value) =>
                              Value == "" ? "Please write Flat no" : null,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.black),
                            hintText: "Search Month ex:9.....",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide:
                                  const BorderSide(color: Colors.white60),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide:
                                  const BorderSide(color: Colors.white60),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide:
                                  const BorderSide(color: Colors.white60),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide:
                                  const BorderSide(color: Colors.white60),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 5),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          onChanged: (text) {
                            setState(() {
                              isLoading = true;
                            });
                            getDataFromDb();
                          },
                        ),
                      ),
                    ),
                    Text("Bills :${billReports.length}"),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _refreshData();
                          });
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: billReports.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onLongPress: () {
                        // Function to execute on long press
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Item?'),
                              content: Text(
                                  'Are you sure you want to delete this item?'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    // Navigator.of(context).pop(true);
                                    // String flatOwnerName =
                                    //     await billReports[index].id.toString();
                                    // await _myDataBase
                                    //     .deleteFlatOwnerlist(billReports[index].i);
                                    // if (mounted) {
                                    //   ScaffoldMessenger.of(context)
                                    //       .showSnackBar(SnackBar(
                                    //           content: Text(
                                    //               '${flatOwnerName.toUpperCase()}Deleted')));
                                    // }
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
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${billReports[index].date}',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            //table
                            Table(
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
                                      'Bill Type',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    TableCell(
                                        child: Text('Amount',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(child: Text('Rental amount')),
                                    TableCell(
                                        child: Text(
                                            '\₹${billReports[index].rentalBill}')),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    TableCell(child: Text('Power Bill')),
                                    TableCell(
                                        child: Text(
                                            '\₹${billReports[index].otherBill}')),
                                  ],
                                ),
                                // TableRow(
                                //   children: [
                                //     TableCell(child: Text('Water Bill')),
                                //     TableCell(child: Text('\$$waterBill')),
                                //   ],
                                // ),
                                // TableRow(
                                //   children: [
                                //     TableCell(child: Text('Other Bills')),
                                //     TableCell(child: Text('\₹$other_Bill')),
                                //   ],
                                // ),
                                TableRow(
                                  children: [
                                    TableCell(
                                        child: Text('Total',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                    TableCell(
                                        child: Text(
                                            '\₹${billReports[index].totalBill}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                  ],
                                ),
                              ],
                            ),
                            /*
                            //Name
                            Text(
                              billReports[index].flatId.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Flat No: ${billReports[index].id}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color.fromARGB(255, 16, 0, 0),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'rentalBill: ${billReports[index].rentalBill}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 2, 48, 255),
                              ),
                            ),
                            
                            SizedBox(height: 12),
                            Row(r
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Material(
                                  color: Color.fromARGB(255, 255, 3, 3),
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           BillReportList(flatId: flatId)),
                                      // );
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 6,
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        "Reports",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Color.fromARGB(255, 3, 45, 255),
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(20),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 6,
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        "Update",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            */
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
