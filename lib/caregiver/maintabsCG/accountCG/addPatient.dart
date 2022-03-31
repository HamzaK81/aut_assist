import 'dart:io';

import 'package:aut_assist/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPatient extends StatefulWidget {
  const AddPatient({Key? key}) : super(key: key);

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  TextEditingController patientNameController = TextEditingController();
  TextEditingController patientAgeController = TextEditingController();
  TextEditingController patientIDController = TextEditingController();
  TextEditingController patientPasswordController = TextEditingController();

  dynamic displayImage = 'assets/icon.png';
  bool defaultImage = true;

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
      body: Center(
        child: ListView(
          shrinkWrap: true,
          reverse: false,
          padding: const EdgeInsets.all(25),
          children: [
            const Center(
              child: Text(
                "REGISTER PATIENT",
                style: TextStyle(
                  color: Color(0xFF11245A),
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: defaultImage
                        ? Image.asset(displayImage)
                        : CircleAvatar(
                            child: Image.file(
                            displayImage,
                          ))),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  XFile? pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 100,
                  );
                  setState(() {
                    displayImage = File(pickedFile!.path);
                    defaultImage = false;
                  });
                },
                child: const Text(
                  "Change Display Picture",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF11245A),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.95,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                children: [
                  TextField(
                    controller: patientNameController,
                    decoration: const InputDecoration(
                      labelText: "Patient Name",
                      labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF11245A),
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                  TextField(
                    controller: patientAgeController,
                    decoration: const InputDecoration(
                      labelText: "Patient Age",
                      labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF11245A),
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                  TextField(
                    controller: patientIDController,
                    decoration: const InputDecoration(
                      labelText: "Set Patient ID",
                      labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF11245A),
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                  TextField(
                    controller: patientPasswordController,
                    decoration: const InputDecoration(
                      labelText: "Set Patient Password",
                      labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF11245A),
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                  const SizedBox(height: 35.0),
                  Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          final patientData = {
                            "name": patientNameController.text,
                            "age": patientAgeController.text,
                          };

                          try {
                            final caregiver = FirebaseFirestore.instance
                                .collection('caregivers')
                                .doc('$uid');

                            final patientDoc = caregiver
                                .collection('patients')
                                .doc(patientIDController.text);

                            //Add patient to caregiver's patients list
                            await patientDoc.set(patientData);


                            // Add patient to users list
                            final userDoc = FirebaseFirestore.instance
                                .collection('users')
                                .doc(patientIDController.text);

                            await userDoc.set(patientData);

                            final _bucketImage = FirebaseStorage.instance.ref(
                                'users/${patientNameController.text}/display/icon.png');

                            await _bucketImage.putFile(displayImage);

                            final displayURL = await FirebaseStorage.instance.ref(
                                'users/'
                                    '${patientNameController.text}/display/icon.png')
                                .getDownloadURL();


                            await patientDoc.update(
                              {
                                "displayPicture" : displayURL,
                              }
                            );


                            // Return to caregiver profile
                            Navigator.pop(context);
                          } catch (e) {
                            return;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey[900],
                        ),
                        child: const Text("REGISTER PATIENT")),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
            //    ),
          ],
        ),
      ),
    );
  }
}
