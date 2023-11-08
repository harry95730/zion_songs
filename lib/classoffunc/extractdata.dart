// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

String imageUrl = '';

class Dat {
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

  Future<List<List<String>>> displaySubcollectionTitles(
      String userid, BuildContext context) async {
    try {
      late List<List<String>> abc = [];
      final mainCollectionRef = FirebaseFirestore.instance
          .collection('all songs')
          .doc(userid)
          .collection('songs');

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('all songs')
          .doc(userid)
          .get();
      if (documentSnapshot.exists) {
        String fieldValue = documentSnapshot['image'];
        await downloadImage(fieldValue, context);
      }
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

  Future<void> downloadImage(String fieldval, BuildContext context) async {
    try {
      final FirebaseStorage storage = FirebaseStorage.instance;
      Reference imageRef = storage.ref().child(fieldval);
      final String downloadURL = await imageRef.getDownloadURL();
      imageUrl = downloadURL;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<List> songrequ(
      String userid, String songid, BuildContext context) async {
    try {
      final mainCollectionRef = FirebaseFirestore.instance
          .collection('all songs')
          .doc(userid)
          .collection('songs')
          .doc(songid);

      final mainCollectionSnapshot = await mainCollectionRef.get();
      List songsList = mainCollectionSnapshot['song'];

      return songsList;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return [];
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
      return def;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
    return [];
  }

  Future<bool> updateDocumentField(String bookId, String songid,
      List<String> fieldToUpdate, List<Map> upde, BuildContext context) async {
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

  Future<bool> addition(String userid, String songid,
      List<String> fieldToUpdate, List<Map> upde, BuildContext context) async {
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
