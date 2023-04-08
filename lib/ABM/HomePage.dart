import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/ABM/Billing.dart';
import 'package:project/ABM/Models/tenant.dart';
import 'package:project/ABM/add_tenant.dart';
import 'package:project/ABM/database/MyDatabase.dart';
import 'package:project/ABM/reports.dart';
import 'package:project/customer.dart';
import 'package:project/invoice_page.dart';
import 'package:project/item.dart';
import 'package:project/transaction%20details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  List<Tenant> tenant = List.empty(growable: true);
  final MyDataBase _myDataBase = MyDataBase();

  int count = 0;
  final TextEditingController _searcher = TextEditingController();

  getDataFromDb(String searchText) async {
    await _myDataBase.initializedDatabase();
    List<Map<String, Object?>> map =
        await _myDataBase.searchFlatOwnerlist(searchText);
    tenant = [];
    for (int i = 0; i < map.length; i++) {
      tenant.add(Tenant.fromMap(map[i]));
    }
    if (searchText.isNotEmpty) {
      tenant = tenant
          .where(
              (fm) => fm.flat_no.toString().contains(searchText.toLowerCase()))
          .toList();
    }
    count = await _myDataBase.countFlatOwnerlist();
    setState(() {
      isLoading = false;
    });
  }

/*
  getDataFromDb(String searchText) async {
    await _myDataBase.initializedDatabase();
    List<Map<String, Object?>> map = await _myDataBase.getFlatOwnerlist();
    tenant = [];
    for (int i = 0; i < map.length; i++) {
      tenant.add(Tenant.fromMap(map[i]));
    }
    if (searchText.isNotEmpty) {
      tenant = tenant
          .where(
              (fm) => fm.flat_no.toString().contains(searchText.toLowerCase()))
          .toList();
    }
    count = await _myDataBase.countFlatOwnerlist();
    setState(() {
      isLoading = false;
    });
  }
*/
  ///////////
  ///Refreshing list view
  Future<void> _refreshData() async {
    // Call a method to retrieve the updated data

    List<Tenant> updatedData = await getDataFromDb(_searcher.text);

    // Call setState() to rebuild the widget with the updated data
    setState(() {
      tenant = updatedData;
    });
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carasouelTmer = getTimer();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showBtmAppBr = false;
        setState(() {});
      } else {
        showBtmAppBr = true;
        setState(() {});
      }
    });
    _refreshData();

    setState(() {
      getDataFromDb(_searcher.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  bool showBtmAppBr = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Handle refresh action
          setState(() {
            _refreshData();
          });
        },
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 236, 233, 251),
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                        spreadRadius: 0.1,
                        blurRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: EdgeInsets.all(16),
                  child: ListTile(
                    title: SizedBox(
                      height: kToolbarHeight +
                          10, // adjust the padding value as needed
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: 200,
                        child: TextFormField(
                          controller: _searcher,
                          validator: (Value) =>
                              Value == "" ? "Customer ID" : null,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.black),
                            hintText: "Search Customer ID.....",
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
                            getDataFromDb(text);
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                // Refresh----
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Total Costamers :${tenant.length}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
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
                  itemCount: tenant.length,
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
                                    Navigator.of(context).pop(true);
                                    String flatOwnerName =
                                        await tenant[index].name;
                                    await _myDataBase
                                        .deleteFlatOwnerlist(tenant[index]);
                                    if (mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  '${flatOwnerName.toUpperCase()}Deleted')));
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
                            //Name
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tenant[index].name.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         Update_Tenant_Info(
                                      //       tenant: tenant[index],
                                      //       myDataBase: _myDataBase,
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                    icon: Icon(Icons.read_more)),
                              ],
                            ),
                            // SizedBox(height: 12),
                            //
                            Text(
                              'Customer Id: ${tenant[index].flat_no}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color.fromARGB(255, 16, 0, 0),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Mobile No: ${tenant[index].mobileno}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 2, 48, 255),
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Material(
                                  color: Color.fromARGB(255, 10, 132, 26),
                                  borderRadius: BorderRadius.circular(30),
                                  child: InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => Billing(
                                      //       tenant: tenant[index],
                                      //       myDataBase: _myDataBase,
                                      //     ),
                                      //   ),
                                      // );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ItemTable(
                                                  customer: tenant[index],
                                                  myDataBase: _myDataBase,
                                                )),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 6,
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        "CUSTOMER Items",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 11,
                                ),
                                Material(
                                  color: Color.fromARGB(255, 255, 3, 3),
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           BillReportList(
                                      //             tenant: tenant[index],
                                      //           )),
                                      // );

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => InvoicePage(
                                                  CUSTOMER: tenant[index],
                                                )),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 6,
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        "Invoice",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Material(
                                //   color: Color.fromARGB(255, 2, 161, 247),
                                //   borderRadius: BorderRadius.circular(20),
                                //   child: InkWell(
                                //     onTap: () {
                                //       // Navigator.push(
                                //       //   context,
                                //       //   MaterialPageRoute(
                                //       //       builder: (context) =>
                                //       //           BillReportList(
                                //       //             tenant: tenant[index],
                                //       //           )),
                                //       // );

                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) =>
                                //                 TransactionDetailForm(
                                //                   myDataBase: _myDataBase,
                                //                   CUSTOMER: tenant[index],
                                //                 )),
                                //       );
                                //     },
                                //     borderRadius: BorderRadius.circular(20),
                                //     child: const Padding(
                                //       padding: EdgeInsets.symmetric(
                                //         vertical: 6,
                                //         horizontal: 10,
                                //       ),
                                //       child: Text(
                                //         "Bank",
                                //         style: TextStyle(
                                //           color: Colors.white,
                                //           fontSize: 11,
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // Material(
                                //   color: Color.fromARGB(255, 3, 45, 255),
                                //   borderRadius: BorderRadius.circular(20),
                                //   child: InkWell(
                                //     onTap: () {
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) =>
                                //               Update_Tenant_Info(
                                //             tenant: tenant[index],
                                //             myDataBase: _myDataBase,
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //     borderRadius: BorderRadius.circular(20),
                                //     child: const Padding(
                                //       padding: EdgeInsets.symmetric(
                                //         vertical: 6,
                                //         horizontal: 10,
                                //       ),
                                //       child: Text(
                                //         "Update",
                                //         style: TextStyle(
                                //           color: Colors.white,
                                //           fontSize: 14,
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                        //////////////////////////
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navigate to Add Page CustomerForm
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Add_tenant(
                      myDataBase: _myDataBase,
                    )),
          );
        },
      ),
    );
  }
}

class PopUpMen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopUpMen({Key? key, required this.menuList, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}

class FabExt extends StatelessWidget {
  const FabExt({
    Key? key,
    required this.showFabTitle,
  }) : super(key: key);

  final bool showFabTitle;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      label: AnimatedContainer(
        duration: const Duration(seconds: 2),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(CupertinoIcons.cart),
            SizedBox(width: showFabTitle ? 12.0 : 0),
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              child: showFabTitle ? const Text("Go to cart") : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
