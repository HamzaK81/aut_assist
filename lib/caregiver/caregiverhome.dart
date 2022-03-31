import 'package:aut_assist/caregiver/maintabsCG/personalCG/personalCG.dart';
import 'package:aut_assist/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/usermodel.dart';
import 'maintabsCG/accountCG/accountCG.dart';
import 'maintabsCG/progressCG/progress.dart';
import 'maintabsCG/trainingCG/trainingCG.dart';


class CaregiverHome extends StatefulWidget {
  CaregiverHome({Key? key}) : super(key: key);



  @override
  State<CaregiverHome> createState() => _HomeState();
}


class _HomeState extends State<CaregiverHome> {
  final AuthService _auth = AuthService();
  final Stream<AppUser?>? user = AuthService().user;
  int _selectedPage = 0;
  final _pageController = PageController(initialPage: 0);

  List<Widget> screens = [
    const AccountCG(),
    const TrainingControl(),
    const PersonalCG(),
    const ProgressCG(),
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


        // BOTTOM NAVIGATOR SECTION
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          // Change page number on tap,
          onTap: (index) => _pageController.animateToPage(index,
              duration: Duration(microseconds: 300), curve: Curves.easeIn),

          backgroundColor: Color(0xFF36474F),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey[400],
          selectedItemColor: Colors.redAccent,
          unselectedFontSize: 12.0,
          selectedFontSize: 12.0,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "Account",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Training",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Personal",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.scatter_plot_rounded),
              label: "Progress",
            ),
          ],
        )
    );
  }

}


