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


class PersonalCG extends StatefulWidget {
  const PersonalCG({Key? key}) : super(key: key);

  @override
  State<PersonalCG> createState() => _PersonalCGPageState();
}

final auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final uid = user?.email;
var _activePatient = "";

class _PersonalCGPageState extends State<PersonalCG> {
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
                          "PERSONAL FILES",
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
        ]
        )
    );
  }
}
