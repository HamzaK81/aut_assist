import 'package:flutter/material.dart';


class Outdoors extends StatefulWidget {
  const Outdoors({Key? key}) : super(key: key);

  @override
  State<Outdoors> createState() => _OutdoorsState();
}

class _OutdoorsState extends State<Outdoors> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Outdoors"),
    );
  }
}
