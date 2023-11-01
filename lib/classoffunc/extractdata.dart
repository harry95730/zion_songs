// ignore_for_file: use_build_context_synchronously

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Dat {
  Future<List<List<String>>> displaySubcollectionTitles(
      String userid, BuildContext context) async {
    try {
      late List<List<String>> abc = [];
      final mainCollectionRef = FirebaseFirestore.instance
          .collection('all songs')
          .doc(userid)
          .collection('songs');

      final mainCollectionSnapshot = await mainCollectionRef.get();

      for (final mainDoc in mainCollectionSnapshot.docs) {
        if (mainDoc['title'] == "") {
        } else {
          List<String> def = [
            mainDoc.id,
            mainDoc['title'],
            mainDoc['english'],
            mainDoc['number'],
            mainDoc['genre']
          ];

          abc.add(def);
        }
      }
      return abc;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return [[]];
  }

  Future<Map<String, String>> songrequ(
      String userid, String songid, BuildContext context) async {
    try {
      late Map<String, String> abc = {};
      final mainCollectionRef = FirebaseFirestore.instance
          .collection('all songs')
          .doc(userid)
          .collection('songs')
          .doc(songid);

      final mainCollectionSnapshot = await mainCollectionRef.get();
      LinkedHashMap<String, dynamic>? songsList =
          mainCollectionSnapshot['song'] as LinkedHashMap<String, dynamic>;
      //print(songsList);
      for (var song in songsList.keys) {
        abc[song] = songsList[song].toString();
      }
      return abc;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return {};
  }

  Future<List<dynamic>> songlisu(
      String userid, String songid, BuildContext context) async {
    try {
      final mainCollectionRef = FirebaseFirestore.instance
          .collection('all songs')
          .doc(userid)
          .collection('songs')
          .doc(songid);

      final mainCollectionSnapshot = await mainCollectionRef.get();
      List<dynamic>? songsList = mainCollectionSnapshot['old number'];
      if (songsList != null) {
        return songsList;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return [];
  }

  Future<List<String>> getdata(
      String userid, String songid, BuildContext context) async {
    try {
      List<String> def = [];
      late Map<String, String> abc = {};
      final mainCollectionRef = FirebaseFirestore.instance
          .collection('all songs')
          .doc(userid)
          .collection('songs')
          .doc(songid);

      final mainCollectionSnapshot = await mainCollectionRef.get();
      def.add(mainCollectionSnapshot['title'].toString());
      def.add(mainCollectionSnapshot['english'].toString());
      def.add(mainCollectionSnapshot['number'].toString());
      List<dynamic>? songsL = mainCollectionSnapshot['old number'];
      String l = '';
      if (songsL != null) {
        for (var i in songsL) {
          l += i.toString();
          l += ',';
        }
      }
      def.add(l.toString());
      def.add(mainCollectionSnapshot['genre'].toString());
      Map<String, dynamic>? songsList = mainCollectionSnapshot['song'];
      if (songsList != null) {
        for (var song in songsList.keys) {
          abc[song] = songsList[song].toString();
        }
      }
      return def;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return [];
  }

  Future<bool> updateDocumentField(
      String bookId,
      String songid,
      List<String> fieldToUpdate,
      Map<String, String> upde,
      BuildContext context) async {
    try {
      List<int> numbersList = [];

      if (fieldToUpdate[3].isNotEmpty) {
        List<String> numberStrings = fieldToUpdate[3].split(',');

        for (String number in numberStrings) {
          int? parsedNumber = int.tryParse(number.trim());
          if (parsedNumber != null) {
            numbersList.add(parsedNumber);
          }
        }
      }
      await FirebaseFirestore.instance
          .collection('all songs')
          .doc(bookId)
          .collection('songs')
          .doc(songid)
          .delete();
      await FirebaseFirestore.instance
          .collection('all songs')
          .doc(bookId)
          .collection('songs')
          .doc(songid)
          .set({
        'song': upde,
        'english': fieldToUpdate[1],
        'title': fieldToUpdate[0],
        'number': fieldToUpdate[2],
        'old number': numbersList,
        'genre': 'psalm'
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Song updated successfuly'),
        backgroundColor: Color.fromARGB(255, 117, 247, 145),
      ));
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return false;
  }

  Future<bool> addition(
      String userid,
      String songid,
      List<String> fieldToUpdate,
      Map<String, String> upde,
      BuildContext context) async {
    try {
      final mainCollectionRef =
          FirebaseFirestore.instance.collection('all songs').doc(userid);

      final mainCollectionSnapshot = await mainCollectionRef.get();
      int r = mainCollectionSnapshot['number'];

      await FirebaseFirestore.instance
          .collection('all songs')
          .doc(userid)
          .update({
        'number': r + 1,
      });
      String p = 'song${r + 1}';
      List<int> numbersList = [];

      if (fieldToUpdate[3].isNotEmpty) {
        List<String> numberStrings = fieldToUpdate[3].split(',');

        for (String number in numberStrings) {
          int? parsedNumber = int.tryParse(number.trim());
          if (parsedNumber != null) {
            numbersList.add(parsedNumber);
          }
        }
      }
      List<Map<String, dynamic>> dataToSave = [];
      if (upde.isNotEmpty) {
        for (var i in upde.keys) {
          dataToSave.add({
            'name': i,
            'value': upde[i],
            'order': FieldValue.serverTimestamp()
          });
        }
      }

      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final WriteBatch batch = firestore.batch();
      for (var itemData in dataToSave) {
        batch.set(
          firestore
              .collection('all songs')
              .doc(userid)
              .collection('songs')
              .doc(p),
          itemData,
        );
      }

      await batch.commit();
      await FirebaseFirestore.instance
          .collection('all songs')
          .doc(userid)
          .collection('songs')
          .doc(p)
          .set({
        'title': fieldToUpdate[0],
        'english': fieldToUpdate[1],
        "number": fieldToUpdate[2],
        "old number": numbersList,
        "genre": 'psalms',
        "song": upde,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Song added successfuly'),
        backgroundColor: Color.fromARGB(255, 117, 247, 145),
      ));
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return false;
  }
}
