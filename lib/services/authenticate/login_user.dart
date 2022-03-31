import 'package:aut_assist/services/usermodel.dart';
import 'package:aut_assist/user/userhome.dart';
import 'package:flutter/material.dart';
import 'package:aut_assist/services/auth.dart';
import 'package:provider/provider.dart';

class UserLoginPage extends StatelessWidget {
  const UserLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Decide(),
          '/login': (context) => UserHome()
        }


    );
  }
}

class Decide extends StatelessWidget {
  const Decide({Key? key}) : super(key: key);

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
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(
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
                          "(User)",
                          style: TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //const SizedBox(height: 75.0),
              Expanded(
                flex: 2,
                child: Container(
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
                            borderSide: BorderSide(color: Colors.teal)
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
                              borderSide: BorderSide(color: Colors.teal)
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
                            primary: Colors.teal,
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
              ),



            ],
          ),
        )
    );
  }
}





