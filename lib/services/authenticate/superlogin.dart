import 'package:flutter/material.dart';
import 'package:aut_assist/services/auth.dart';
import 'package:aut_assist/services/authenticate/login_user.dart';
import 'login_caregiver.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => Decide(),
      '/user': (context) => UserLoginPage(),
      '/caregiver': (context) => CareGiverLoginPage()
    });
  }
}

class Decide extends StatelessWidget {
  const Decide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: const Text(
                  "AutAssist",
                  style: TextStyle(
                    fontFamily: "AutAssist",
                    fontSize: 50.0,
                    color: Color(0xAFFDFCFC),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green[700],
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/user');
              },
              child: const Text("User"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red[900],
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/caregiver');
              },
              child: const Text("Therapist"),
            ),
          ],
        ),
      ),
    );
  }
}
