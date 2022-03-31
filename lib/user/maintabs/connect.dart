import 'package:flutter/material.dart';


class Connect extends StatefulWidget {
  const Connect({Key? key}) : super(key: key);

  @override
  State<Connect> createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Connect"),
    );
  }
}
