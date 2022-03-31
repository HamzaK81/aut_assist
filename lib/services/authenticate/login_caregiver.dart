import 'package:aut_assist/services/authenticate/register_caregiver.dart';
import 'package:aut_assist/services/usermodel.dart';
import 'package:aut_assist/user/userhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aut_assist/services/auth.dart';
import 'package:provider/provider.dart';

import '../../caregiver/maintabsCG/accountCG/addPatient.dart';

class CareGiverLoginPage extends StatelessWidget {
  const CareGiverLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Decide(),
          '/register': (context) => CareGiverRegisterPage(),
          '/addPatient': (context) => AddPatient(),
        }


    );
  }
}

class Decide extends StatelessWidget {
  Decide({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = AuthService();

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
                          authService.signInWithEmailAndPassword(
                              emailController.text,
                              passwordController.text
                          );
                        },
                        child: const Text("Log in"),
                      ),
                    ),
                  ],
                ),
              ),
             Container(
                 margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 35.0), 
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     const Padding(
                       padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                       child: Text(
                         "Don't have an account?", 
                         style: TextStyle(
                           color: Colors.white, 
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                     ),

                              ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red[800],
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/register');
                                      },
                                      child: const Text("Register"),
                              ),
                            ],
                          ),
                        ),
                  ],
                ),
              ),
        );
  }
}





