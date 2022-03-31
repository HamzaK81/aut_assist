import 'package:aut_assist/caregiver/maintabsCG/trainingCG/choosePatient.dart';
import 'package:aut_assist/info.dart';
import 'package:aut_assist/training_modules/create_module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

List<dynamic> modules = [];

class TrainingControl extends StatefulWidget {
  const TrainingControl({Key? key}) : super(key: key);

  @override
  State<TrainingControl> createState() => _TrainingControlPageState();
}

class _TrainingControlPageState extends State<TrainingControl> {
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    modules = [];
  }

  @override
  Widget build(BuildContext context) {
    modules = [];
    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.email;
    var _activePatient = "";

    return Scaffold(
      backgroundColor: const Color(0xFFB6B3B3),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('caregivers')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      List<dynamic> data = [];
                      snapshot.data?.docs.map((val) {
                        if (val.id == uid) {
                          data.add(val);
                        }
                      }).toList();
                      try {
                        _activePatient = data[0]["activePatient"];
                      } catch (e) {
                        return const Center(child: Text("Loading"));
                      }
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(
                                  10.0, 10.0, 10.0, 0.0),
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 10.0, 10.0, 0.0),
                              child: Text(
                                "Patient: ${_activePatient}",
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xFF11245A),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.9,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                              width: 150.0,
                              child: TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChoosePatient()));
                                },
                                icon: const Icon(
                                  Icons.person,
                                  size: 14.0,
                                  color: Color(0xFF280593),
                                ),
                                label: const Text(
                                  "Change Patient",
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: Color(0xFF280593),
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(
                                  30.0, 3.0, 30.0, 10.0),
                              child: const Divider(
                                color: Colors.blueGrey,
                                thickness: 2,
                                height: 1.0,
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.fromLTRB(30.0, 10.0, 15.0, 0.0),
                              child: Column(
                                children: [
                                  const Text(
                                    "MODULES",
                                    style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 1.3,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  SizedBox(height:20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 30.0,
                                        child: ElevatedButton.icon(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CreateModule(
                                                            activePatient:
                                                                _activePatient,
                                                          )));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.blueGrey[700],
                                              // Colors.red,
                                            ),
                                            icon: const Icon(
                                              Icons.add,
                                              size: 15.0,
                                            ),
                                            label: const Text(
                                              "ADD MODULE",
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                fontFamily: "Regulars",
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]);
                    }),
              ],
            ),
          ),
          Flexible(
              child: Container(
            margin: const EdgeInsets.fromLTRB(32, 5, 32, 32),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc("hk07508")
                    .collection("modules")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return ListView(
                    children: snapshot.data!.docs.map((val) {
                      return createModuleCard(val);
                    }).toList(),
                  );
                }),
          ))
        ],
      ),
    );
  }
}

Widget createModuleCard(module) {
  return Card(
      margin: const EdgeInsets.fromLTRB(0.0, 12.0, 5.0, 5.0),
      color: Colors.grey[500],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 12.0),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  children: [
                    Row(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.asset(
                            "assets/brain.png",
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "${module.id}",
                            style: TextStyle(
                              letterSpacing: 1.1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Type: ${module["type"]}',
                            style: TextStyle(letterSpacing: 1.1, fontSize: 12),
                          ),
                        ],
                      ),
                    ]),
                  ],
                ),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(
                  flex: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey[900],
                      // Colors.red[600],
                    ),
                    child: const Text("VIEW"),
                    onPressed: () {
                      // TODO: route to the module's page
                    },
                  ),
                ),
              ])
            ],
          ),
        ),
      ));
}
