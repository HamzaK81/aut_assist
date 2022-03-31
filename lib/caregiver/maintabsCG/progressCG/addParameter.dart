import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddParameter extends StatefulWidget {
  String patient;
  AddParameter({Key? key, required this.patient}) : super(key: key);

  @override
  State<AddParameter> createState() => _AddParameterState();
}

class _AddParameterState extends State<AddParameter> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _initValController = TextEditingController();

  final _items = ["Daily", "Weekly", "Monthly", "Yearly"];
  var _typeVal = "Daily";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45.0,
        title: const Text(
          'AutAssist',
          style: TextStyle(
            fontFamily: "AutAssist",
            fontSize: 30.0,
            letterSpacing: 2.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF36474F),
      ),
      backgroundColor: const Color(0xFFB6B3B3),
      body: Container(
        margin: const EdgeInsets.all(32.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("ADD PARAMETER",
                          style: TextStyle(
                            fontSize: 20.0,
                            letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent)),
                          labelText: "Parameter Name",
                          labelStyle: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 50.0),
                      Row(
                        children: [
                          const Text("Update Type:  "),
                          DropdownButton(
                              value: _typeVal,
                              items: _items.map((String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (String? newVal) {
                                setState(() {
                                  _typeVal = newVal!;
                                });
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            child: TextField(
                              controller: _initValController,
                              decoration: const InputDecoration(
                                labelText: "Initial Value (e.g. No./day)",
                                labelStyle: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 75,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        onPressed: () async {
                          final uid = FirebaseAuth.instance.currentUser!.email;

                            final data = {
                              "updateType": _typeVal,
                              "initVal": int.parse(_initValController.text)
                            };

                          await FirebaseFirestore.instance
                              .collection("caregivers")
                              .doc(uid)
                              .collection("patients")
                              .doc(widget.patient)
                              .collection("progressParameters")
                              .doc(_nameController.text)
                              .set(data);

                          Navigator.pop(context);
                        },
                        child: Text("Confirm"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
