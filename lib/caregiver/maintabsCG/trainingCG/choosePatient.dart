import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChoosePatient extends StatefulWidget {
  const ChoosePatient({Key? key}) : super(key: key);

  @override
  State<ChoosePatient> createState() => _ChoosePatientState();
}

class _ChoosePatientState extends State<ChoosePatient> {

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.email;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF36474F),
        toolbarHeight: 45.0,
      ),
      backgroundColor: const Color(0xFFB6B3B3),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('caregivers').doc('$uid').collection('patients').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                child: const Text(
                  "CHOOSE PATIENT",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Color(0xFF11245A),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(30.0, 3.0, 30.0, 3.0),
                child: const Divider(
                  color: Colors.black,
                  thickness: 2,
                  height: 1.0,
                ),
              ),
              Flexible(
                child: ListView(
                  children: snapshot.data!.docs.map((val) {
                    return Center(
                        child: TextButton.icon(
                            onPressed: (){
                              FirebaseFirestore.instance.collection("caregivers")
                                  .doc('$uid').update({"activePatient": val.id});
                              Navigator.pop(context);

                            },
                            icon: const Icon(Icons.person, color: Colors.indigo,),
                            label: Text(
                              "${val["name"]}",
                              style: const TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.black,
                              ),
                            )
                        )
                    );
                  }).toList(),
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}
