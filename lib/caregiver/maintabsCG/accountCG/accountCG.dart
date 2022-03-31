import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'addPatient.dart';

class AccountCG extends StatefulWidget {
  const AccountCG({Key? key}) : super(key: key);

  @override
  State<AccountCG> createState() => _AccountCGPageState();
}

class _AccountCGPageState extends State<AccountCG> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.email;
    CollectionReference caregivers =
        FirebaseFirestore.instance.collection('caregivers');
    return Scaffold(
        backgroundColor: const Color(0xFFB6B3B3),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<DocumentSnapshot>(
                future: caregivers.doc("$uid").get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Flexible(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 5.0),
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  27.5, 8.0, 15.0, 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Name and Data
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${data['name']}",
                                              style: const TextStyle(
                                                color: Color(0xFF11245A),
                                                fontSize: 25.0,
                                                letterSpacing: 1.2,
                                                fontFamily: "Regulars",
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 35,
                                              width: 20,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.logout,
                                                  size: 20.0,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  FirebaseAuth.instance
                                                      .signOut();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Text(
                                          "Therapist Profile",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15.0,
                                            letterSpacing: 1.1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //Display Picture
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(500),
                                      child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Image.asset("assets/icon.png"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.fromLTRB(40.0, 35.0, 40.0, 15.0),
                              child: Divider(
                                color: Colors.blueGrey,
                                thickness: 1.5,
                                height: 1.0,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                              child: Text(
                                "PATIENTS",
                                style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1.3,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                children: [
                                  ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddPatient()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blueGrey[700],
                                        // Colors.red,
                                      ),
                                      icon: const Icon(
                                        Icons.person_add,
                                        size: 15.0,
                                      ),
                                      label: const Text(
                                        "ADD PATIENT",
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Regular",
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Flexible(
                                child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 0.0),
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('caregivers')
                                    .doc(uid)
                                    .collection('patients')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  return ListView(
                                    children: snapshot.data!.docs.map((val) {
                                      return createUserCard(val);
                                    }).toList(),
                                  );
                                },
                              ),
                            )),
                          ],
                        ),
                        //     ),
                      ),
                    );
                  }
                  return const Center(child: Text("LOADING..."));
                }),
          ],
        ));
  }
}

Widget createUserCard(module) {
  return Card(
      margin: const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
      color: Colors.grey[500],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  children: [
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2.0, 2.0, 10.0, 2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.network(
                              module["displayPicture"],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${module['name']}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  // Color(0xFF11245A),
                                  fontFamily: "Regulars",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 1.0
                                  // fontWeight: FontWeight.bold
                                  ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Age: ${module['age']}',
                              style: const TextStyle(
                                color: Colors.black,
                                // Color(0xFF11245A),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
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
                    child: const Text("PROFILE",
                        style: TextStyle(
                          fontFamily: "Regular",
                          fontSize: 12,
                          // letterSpacing:
                        )),
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
