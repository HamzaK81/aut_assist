import 'package:aut_assist/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aut_assist/user/maintabs/account.dart';
import 'package:aut_assist/user/maintabs/connect.dart';
import 'package:aut_assist/user/maintabs/outdoors.dart';
import 'package:aut_assist/user/maintabs/trainingscreen.dart';
import '../services/usermodel.dart';


class UserHome extends StatefulWidget {
  UserHome({Key? key}) : super(key: key);



  @override
  State<UserHome> createState() => _HomeState();
}


class _HomeState extends State<UserHome> {
  final AuthService _auth = AuthService();
  final Stream<AppUser?>? user = AuthService().user;
  int _selectedPage = 0;
  final _pageController = PageController(initialPage: 0);

  List<Widget> screens = [
    const TrainingPage(),
    const Outdoors(),
  ];


  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;

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


        // PAGES
        body: PageView(
          controller: _pageController,
          children: screens,
          onPageChanged: (value) => setState(() => _selectedPage = value),
          physics: const NeverScrollableScrollPhysics(),
        ),


        // FLOATING ACTION BUTTON
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            _auth.signOut();

          },
          child: const Icon(Icons.add_call),
          backgroundColor: Color(0xFFFF0000),
        ),


        // BOTTOM NAVIGATOR SECTION
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          // Change page number on tap,
          onTap: (index) => _pageController.animateToPage(index,
              duration: Duration(microseconds: 300), curve: Curves.easeIn),

          backgroundColor: Color(0xFF36474F),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey[400],
          selectedItemColor: Colors.green,
          unselectedFontSize: 12.0,
          selectedFontSize: 12.0,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Training",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Personal",
            ),
          ],
        )
    );
  }


}


