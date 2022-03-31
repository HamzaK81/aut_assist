import 'package:aut_assist/caregiver/maintabsCG/progressCG/addParameter.dart';
import 'package:aut_assist/caregiver/maintabsCG/progressCG/updateParameter.dart';
import 'package:aut_assist/caregiver/maintabsCG/trainingCG/choosePatient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';


class ProgressCG extends StatefulWidget {
  const ProgressCG({Key? key}) : super(key: key);

  @override
  State<ProgressCG> createState() => _ProgressCGPageState();
}

final auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final uid = user?.email;
var _activePatient = "";

class _ProgressCGPageState extends State<ProgressCG> {
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFB6B3B3),
        body: Column(children: [
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
                return Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
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
                                    builder: (context) => ChoosePatient()));
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
                        margin:
                            const EdgeInsets.fromLTRB(30.0, 3.0, 30.0, 10.0),
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: SizedBox(
                                height: 35.0,
                                width: 120.0,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddParameter(
                                                  patient: _activePatient,
                                                )));
                                  },
                                  icon: const Icon(Icons.add),
                                  label: const Text(
                                    "Add Parameter",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[500],
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                            child: SizedBox(
                              height: 35.0,
                              width: 120.0,
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.book),
                                label: const Text(
                                  "Notes",
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey[500],
                                ),
                              ),
                            )
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.fromLTRB(70.0, 3.0, 70.0, 10.0),
                        child: const Divider(
                          color: Colors.blueGrey,
                          thickness: 1.5,
                          height: 1.0,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 1.0),
                        child: Text(
                          "PARAMETERS",
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1.3,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 5.0, vertical: 0.0),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('caregivers')
                        .doc(uid)
                        .collection('patients')
                        .doc(_activePatient)
                        .collection('progressParameters')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.active) {
                        return ListView(
                            children: snapshot.data!.docs.map((val) {
                              return ProgressParameter(
                                  parameterName: '${val.id}',
                                  parameterValues: {"handShake": 0});
                            }).toList());
                      } else {
                        return const Text("Loading");
                      }
                    }),
              ),
            ),
        ]
        )
    );
  }
}

class ProgressParameter extends StatefulWidget {
  String parameterName;
  dynamic parameterValues;
  ProgressParameter(
      {Key? key, required this.parameterName, required this.parameterValues})
      : super(key: key);

  @override
  State<ProgressParameter> createState() => _ProgressParameterState();
}

class _ProgressParameterState extends State<ProgressParameter> {
  @override
  Widget build(BuildContext context) {
    return
      // Flexible(
      // child:
      Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(30.0, 3.0, 30.0, 30.0),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ""
                    "${widget.parameterName}",
                    style: const TextStyle(
                      letterSpacing: 1.0,
                      fontSize: 15.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey[600],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateParameter(
                                      patient: _activePatient,
                                        updateParameterName:
                                            widget.parameterName)));
                          },
                          child: const Text(
                            "UPDATE",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              returnGraph(widget.parameterName),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 30.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[600],
                  ),
                  onPressed: () {},
                  child: const Text(
                    "INSPECT",
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("caregivers")
                          .doc(uid)
                          .collection("patients")
                          .doc(_activePatient)
                          .collection("progressParameters")
                          .doc(widget.parameterName)
                          .delete();
                    },
                    icon: Icon(Icons.delete),
                    iconSize: 25.0,
                  ),
                ],
              )
            ],
          ),
        ));
    //   ),
    // );
  }
}


Widget returnGraph(String progressParameter) {

  return LineGraph(
      features: [
        Feature(
          title: "$progressParameter",
          color: Colors.blue,
          data: [0.2, 0.4, 0.7, 0.4, 0.65, 0.6]
        )
      ],
      labelX: ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5"],
      labelY: ["x1.25", "x1.50", "x1.75", "x2"],
      showDescription: true,
      graphColor: Colors.black87,
      size: Size(300, 250),
  );
}