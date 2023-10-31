// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Dbm {
  Future<List<List<String>>> dataread(BuildContext context) async {
    late List<List<String>> abc = [];
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('all songs');
      QuerySnapshot querySnapshot = await users.get();
      for (var doc in querySnapshot.docs) {
        //print(doc.data());
        List<String> sd = [
          doc['display name'].toString(),
          doc['pin'].toString(),
          doc.id.toString()
        ];
        abc.add(sd);
      }
      return abc;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return abc;
  }

  /*Future<List<String>> getAllDocumentIds(String collectionName) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('all songs').get();

      List<String> documentIds =
          querySnapshot.docs.map((doc) => doc.id).toList();
      return documentIds;
    } catch (e) {
      print('Error retrieving document IDs: $e');
      return [];
    }
  }
  Future<void> displaySubcollectionTitles(String userid) async {
    try {
      final mainCollectionRef = FirebaseFirestore.instance
          .collection('all songs')
          .doc(userid)
          .collection('songs');

      final mainCollectionSnapshot = await mainCollectionRef.get();

      for (final mainDoc in mainCollectionSnapshot.docs) {
        final title = mainDoc.id;
        final x = mainDoc['title'];
        print(x);
        print('title: $title');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> datawrite() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('all songs');
    var loc = [];
    users.add({
      'verse': 'John Doe',
      'display name': 'john@example.com',
      'header': 'Songs of zion',
      'songs': loc,
    });
  }

  Future<void> addingsong(
      String docid, Map<String, dynamic> newData, BuildContext context) async {
    try {
      DocumentReference documentRef =
          FirebaseFirestore.instance.collection('all songs').doc(docid);

      String fieldToUpdate = 'songs';

      await documentRef.update({
        fieldToUpdate: FieldValue.arrayUnion([newData]),
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Song added successfuly'),
        backgroundColor: Color.fromARGB(255, 117, 247, 145),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }*/
}
