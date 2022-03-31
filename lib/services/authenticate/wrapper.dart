import 'package:aut_assist/caregiver/caregiverhome.dart';
import 'package:aut_assist/services/authenticate/superlogin.dart';
import 'package:aut_assist/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:aut_assist/user/userhome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:aut_assist/services/usermodel.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<AppUser?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<AppUser?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final AppUser? user = snapshot.data;
          if (user == null){
            return MainScreen();
          } else {
            if (1 == 2) {
              return UserHome();
            } else {
              return CaregiverHome();
            }
          }
          //return user == null ? MainScreen() : (){return UserHome();};
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
