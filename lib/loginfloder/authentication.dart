// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> changeuserpass(String email, BuildContext context) async {
    // ignore: duplicate_ignore
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('VERIFICATION LINK SENT'),
        backgroundColor: Color.fromARGB(255, 77, 253, 50),
      ));

      return true;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
        backgroundColor: Colors.red,
      ));
      return false;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.amberAccent,
      ));
      return false;
    }
  }

  Future<User?> loginUser(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
        backgroundColor: Colors.red,
      ));
      return null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.amberAccent,
      ));
      return null;
    }
  }

  Future<User?> registerUser1(String email, String password, String displayName,
      String pin, String verse, String chruchinfo, BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('all songs')
          .doc(userCredential.user!.uid)
          .set({
        'display name': displayName,
        'verse': verse,
        'pin': pin,
        'chruch': chruchinfo,
        'number': 0
      });
      await FirebaseFirestore.instance
          .collection('all songs')
          .doc(userCredential.user!.uid)
          .collection('songs')
          .doc('song0')
          .set({
        'title': "",
        'english': "",
        "number": '',
        "old number": [],
        "song": {},
      });
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
        backgroundColor: Colors.red,
      ));
      return null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.amberAccent,
      ));
      return null;
    }
  }
}
