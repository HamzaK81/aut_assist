import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateParameter extends StatefulWidget {
  String patient;
  String updateParameterName;
  UpdateParameter(
      {Key? key, required this.patient, required this.updateParameterName})
      : super(key: key);

  @override
  State<UpdateParameter> createState() => _UpdateParameterState();
}

class _UpdateParameterState extends State<UpdateParameter> {
  final uid = FirebaseAuth.instance.currentUser!.email;
  TextEditingController _controller = TextEditingController();

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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 10, 16, 5),
              child: const Text("UPDATE VALUES",
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                letterSpacing: 1.0,
                fontFamily: "Text",

              ),
              ),
            ),
            const Padding(
              padding:
              EdgeInsets.fromLTRB(65.0, 5.0, 60.0, 15.0),
              child: Divider(
                color: Colors.black54,
                thickness: 1.0,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 45,),
            Flexible(
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('caregivers')
                      .doc(uid)
                      .collection('patients')
                      .doc(widget.patient)
                      .collection("progressParameters")
                      .doc(widget.updateParameterName)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      return
                        Flexible(
                        child: Container(
                          child: Column(
                            children: [
                              const Text(
                                  "CURRENT DATABASE:",
                                style: TextStyle(
                                  fontFamily: "Regular",
                                  fontSize: 15.0,
                                  letterSpacing: 1.0,
                                ),
                              ),

                              Flexible(
                                flex: 1,
                                child:
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  child: ListView(
                                  children: const [
                                    Text("Hi"),
                                  ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          width: 90,
                                          child: TextField(
                                            controller: _controller,
                                            decoration: const InputDecoration(
                                              labelText: "New Value Title:",
                                              labelStyle: TextStyle(
                                                fontSize: 12.0
                                              ),
                                            ),
                                          ),
                                        ),
                                      SizedBox(
                                        width: 90,
                                        child: TextField(
                                          controller: _controller,
                                          decoration: InputDecoration(
                                              labelText: "Value:",
                                              labelStyle: TextStyle(
                                              fontSize: 12.0,
                                          ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      );


                    }
                    return Text("Loading");
                  }),
            )
          ],
        ),
      ),
    );
  }
}
