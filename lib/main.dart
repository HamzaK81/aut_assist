import 'package:aut_assist/services/auth.dart';
import 'package:aut_assist/user/userhome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/authenticate/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AutAssist());
}


class AutAssist extends StatefulWidget {
  const AutAssist({Key? key}) : super(key: key);

  @override
  State<AutAssist> createState() => _AutAssistState();
}

class _AutAssistState extends State<AutAssist> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) =>  const Wrapper(),
          'login': (context) => UserHome(),
        },
      ),
    );
  }
}

















