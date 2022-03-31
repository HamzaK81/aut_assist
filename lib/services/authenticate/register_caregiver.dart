import 'package:aut_assist/services/usermodel.dart';
import 'package:aut_assist/user/userhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aut_assist/services/auth.dart';
import 'package:provider/provider.dart';

class CareGiverRegisterPage extends StatelessWidget {
  const CareGiverRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Decide(),
        }


    );
  }
}

class Decide extends StatelessWidget {
  Decide({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = AuthService();

    CollectionReference caregiver = FirebaseFirestore.instance.
                                                collection('caregivers');

    return Scaffold(
      resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFF374B55),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        "AutAssist",
                        style: TextStyle(
                          fontFamily: "AutAssist",
                          fontSize: 50.0,
                          color: Color(0xAFFDFCFC),
                        ),
                      ),
                      Text(
                        "(Caregiver)",
                        style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 35.0),
                child: Column(
                  children: [
                    TextField(
                      cursorColor: Colors.white,
                      controller: nameController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent)
                        ),
                        labelText: "Name",
                        labelStyle: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    TextField(
                      cursorColor: Colors.white,
                      controller: emailController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent)
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent)
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                        ),
                        onPressed: () {
                          caregiver.add({
                            'email':emailController.text,
                            'name': nameController.text,
                          });
                          authService.registerWithEmailAndPassword(
                              emailController.text,
                              passwordController.text
                          );
                        },
                        child: const Text("Register"),
                      ),
                    ),
                        ],
                      ),
                    )
                  ],
                ),
              )
    );
  }
}

