// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<User?> registerUser1(
      String email,
      String password,
      String displayName,
      String pin,
      String verse,
      String chruchinfo,
      File? file,
      BuildContext context) async {
    try {
      String newname = '';
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (file != null) {
        try {
          if (file.path.endsWith('jpg')) {
            newname = '$displayName.jpg';
          } else if (file.path.endsWith('png')) {
            newname = '$displayName.png';
          }

          Reference storageReference =
              FirebaseStorage.instance.ref().child(newname);
          UploadTask uploadTask = storageReference.putFile(file);
          await uploadTask;
          await FirebaseFirestore.instance
              .collection('all songs')
              .doc(userCredential.user!.uid)
              .set({
            'display name': displayName,
            'verse': verse,
            'pin': pin,
            'chruch': chruchinfo,
            'number': 0,
            'image': newname
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
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ));
        }
      }

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
