import 'package:flutter/material.dart';
import 'package:project/ABM/HomePage.dart';
import 'package:project/ABM/Models/tenant.dart';

import 'database/MyDatabase.dart';

class Add_tenant extends StatefulWidget {
  final MyDataBase myDataBase;
  const Add_tenant({super.key, required this.myDataBase});

  @override
  State<Add_tenant> createState() => _Add_tenantState();
}

class _Add_tenantState extends State<Add_tenant> {
  var formkey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _flat_NumberController = TextEditingController();
  var _houseDoorController = TextEditingController();
  var _mobile_NOController = TextEditingController();
  var emailController = TextEditingController();
  bool isTrue = false;

  void addFunctions() async {
    if (formkey.currentState!.validate()) {
      //validate the
      try {
        Tenant tenant = Tenant(
          flat_no: int.parse(_flat_NumberController.text),
          name: _nameController.text,
          door_no: _houseDoorController.text,
          mobileno: _mobile_NOController.text,
          email: emailController.text,
        );
        // Tenant tenant = Tenant(
        //     flat_no: int.parse(_flat_NumberController.text),
        //     name: _nameController.text,
        //     door_no: _houseDoorController.text,
        //     mobileno: _mobile_NOController.text,
        //     email: emailController.text,
        //     bankName: _nameController.text,
        //     BAddress: _nameController.text,
        //     bAcountNo: _nameController.text,
        //     IFSCODE: _nameController.text);
        await widget.myDataBase.insertFlatOwnerlist(tenant);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text('${tenant.name.toUpperCase()}  :Added to DataBase')));
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$e :Added error')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Add Flat Member"),
        //   backgroundColor: Colors.black,
        //   centerTitle: true,
        // ),
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 11, right: 11, top: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Material(
                color: Color.fromARGB(255, 224, 224, 253),
                borderRadius: BorderRadius.circular(11),
                child: InkWell(
                  onTap: () async {},
                  borderRadius: BorderRadius.circular(11),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 28,
                    ),
                    child: Text(
                      "ADD Costomer info",
                      style: TextStyle(
                          color: Color.fromARGB(255, 57, 0, 62),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                color: Color.fromARGB(113, 255, 255, 255),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          validator: (Value) =>
                              Value == "" ? "Please write costomer name" : null,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            hintText: "name.....",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _flat_NumberController,
                          validator: (Value) =>
                              Value == "" ? "Please write id number" : null,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.house,
                              color: Colors.black,
                            ),
                            hintText: "id nunmber.....",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        TextFormField(
                          controller: _houseDoorController,
                          validator: (Value) =>
                              Value == "" ? "Please write adress" : null,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.door_front_door,
                              color: Colors.black,
                            ),
                            hintText: "adress.....",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        //mobile no
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _mobile_NOController,
                          validator: (Value) =>
                              Value == "" ? "Please write Mobile no" : null,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.phone_android,
                              color: Colors.black,
                            ),
                            hintText: "mobile no.....",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        //email
                        TextFormField(
                          controller: emailController,
                          validator: (Value) =>
                              Value == "" ? "Please write email" : null,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            hintText: "email.....",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.white60)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        //optional
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Optional",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.offline_bolt,
                                  color: isTrue ? Colors.green : Colors.red,
                                )
                              ],
                            ),
                            Switch(
                                value: isTrue,
                                onChanged: (newVlaue) {
                                  setState(() {
                                    isTrue = newVlaue;
                                  });
                                }),
                            /*
                                Row(
                                  children: [
                                    Text(
                                      "True",
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.offline_bolt,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                                */
                          ],
                        ),

                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                onTap: () async {
                                  addFunctions();
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 28,
                                  ),
                                  child: Text(
                                    "ADD",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Material(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                onTap: () {
                                  _nameController.text = "";
                                  _flat_NumberController.text = "";
                                  _houseDoorController.text = "";
                                  _mobile_NOController.text = "";
                                  emailController.text = "";
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 28,
                                  ),
                                  child: Text(
                                    "RESET",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /*
                  //Name
                  const TextField(
                    controller: ,
                    decoration: InputDecoration(
                      hintText: "Member name",
                      border: OutlineInputBorder(),
                    ),
                  )
                  //Flat number
                  //Door number
                  //mobile no
                  //Address
                  */
            ],
          ),
        ),
      ),
    ));
  }
}
