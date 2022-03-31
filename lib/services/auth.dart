import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'usermodel.dart';


class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AppUser? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return AppUser(username: user.uid, password: user.email);
  }

  Stream<AppUser?>? get user{
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  // sign in with email and password
  Future<AppUser?> signInWithEmailAndPassword(
      String email,
      String password,
      ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(credential.user);
  }


  // register with email and password
  Future<AppUser?> registerWithEmailAndPassword(
      String email,
      String password,
      ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return null;
    // return _userFromFirebase(credential.user);
  }


  // logout
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

}