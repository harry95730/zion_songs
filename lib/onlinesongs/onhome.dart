// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/classoffunc/extractdata.dart';
import 'package:songs_app/offlinesongs/favsongs.dart';
import 'package:songs_app/offlinesongs/history.dart';
import 'package:songs_app/offlinesongs/ohome.dart';
import 'package:songs_app/offlinesongs/opensongoftheday.dart';
import 'package:songs_app/onlinesongs/onpsearch.dart';
import 'package:songs_app/onlinestart.dart';
import 'package:songs_app/onlinesongs/onqtelugu.dart';
import 'package:songs_app/onlinesongs/onrgenre.dart';
import '../info.dart';

class Onlinehome extends StatefulWidget {
  const Onlinehome({
    Key? key,
  }) : super(key: key);

  @override
  _OnlinehomeState createState() => _OnlinehomeState();
}

class _OnlinehomeState extends State<Onlinehome> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    allthesongs();
  }

  allthesongs() async {
    abgt = await Dat().displaySubcollectionTitles(book, context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        heightFactor: BorderSide.strokeAlignCenter,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    } else {
      return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.pinkAccent,
                ])),
                accountName: Text('ZION SONGS'),
                accountEmail: SelectableText(
                  'zionhouseofprayer497@gmail.com',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/s.png'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.queue_music, color: Colors.blue.shade100),
                title: const Text(
                  'Song of the day',
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Songoftheday()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite, color: Colors.pinkAccent),
                title: const Text(
                  'Favourites',
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Fav()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.history, color: Colors.black),
                title: const Text(
                  'history',
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const History()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.online_prediction),
                title: const Text('Search Online'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Onlinepage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.not_listed_location_outlined,
                    color: Colors.deepPurple.shade300),
                title: const Text('App Info'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SecondPage()));
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.share_outlined, color: Colors.blueAccent),
                title: const Text('Share App'),
                onTap: () {
                  Share.share(
                      "https;//play.google.com/stote/appsdetails?id=com,instructivetech.testapp");
                },
              ),
            ],
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          decoration: imageUrl.isNotEmpty
              ? BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.cover),
                )
              : const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/i3.jpg"),
                      fit: BoxFit.cover),
                ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Melodies',
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      decoration: TextDecoration.none,
                      fontSize: 55.0,
                      fontFamily: 'f1',
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'of',
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      decoration: TextDecoration.none,
                      fontSize: 50.0,
                      fontFamily: 'f1',
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'ZION',
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      decoration: TextDecoration.none,
                      fontFamily: 'f1',
                      fontSize: 55.0,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 40)),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Sing aloud unto ',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'f4',
                        fontSize: 22.0,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 16.0)),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'God our Strength',
                    style: Decorate().trext(22.0, 'f4'),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 6.0)),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'psalms 81:1',
                    style: Decorate().trext(18.0, 'f3'),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Decorate().butto1(Listofbooksongs(), 'SEARCH',
                        Icons.manage_search_rounded, context),
                    Decorate().butto1(const Songbooktelugu(), 'ALPHA ',
                        Icons.switch_access_shortcut, context),
                    Decorate().butto1(const Onlinegenre(), 'CATEGORY',
                        Icons.lyrics_outlined, context),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 50)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HebronPage()),
                    );
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: Decorate().eachtile(),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        book1 == 'ZION_SONGS' ? 'HEBRON SONGS' : 'ZION SONGS',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                            fontFamily: 'f1',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return Decorate().butto2(context);
          },
        ),
      );
    }
  }
}
