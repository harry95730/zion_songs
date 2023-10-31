import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:songs_app/offlinesongs/ohome.dart';
import 'package:songs_app/onlinesongs/onlinehome.dart';
import 'package:songs_app/onlinestart.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

bool isLoading = false;
bool access = false;
int globalVariable = 0;
String book1 = 'ZION_SONGS';
String book = '';
List<List<String>> abgt = [];
List<Song> songs = [];
Map<String, dynamic> dataoflink = {};
Song ha = Song(number: 1, text: '', etext: '', oldnum: [], genre: '', song: {});

class Song {
  final int number;
  final String text;
  final String etext;
  final List<dynamic> oldnum;
  final String genre;
  final Map<String, dynamic> song;
  Song({
    required this.number,
    required this.text,
    required this.etext,
    required this.oldnum,
    required this.genre,
    required this.song,
  });
  factory Song.fromMap(Map<String, dynamic> e) {
    return Song(
      number: e['number'],
      etext: e['etext'],
      oldnum: e['oldnum'],
      genre: e['genre'],
      song: e['song'],
      text: e['text'],
    );
  }
}

Future<void> fetchJsonFromGoogleDrive() async {
  try {
    const url =
        'https://drive.google.com/uc?id=1pStQY3l45g3CA9K4sXE55t_saeusFfHe';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      dataoflink = jsonData["songs"] as Map<String, dynamic>;
      access = true;
    } else {
      access = false;

      throw Exception('Failed to load JSON file');
    }
  } catch (e) {
    access = false;
  }
}

class Decorate {
  Widget botto(BuildContext context, Widget page1, Widget page2, IconData ic1,
      IconData ic2, String a1, String a2) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      elevation: 2,
      unselectedLabelStyle: const TextStyle(color: Colors.white),
      unselectedItemColor: const Color.fromRGBO(251, 250, 250, 1),
      currentIndex: 2,
      showSelectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            ic1,
            color: const Color.fromRGBO(177, 158, 143, 1),
          ),
          label: a1,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.offline_bolt,
            color: Color.fromRGBO(177, 158, 143, 1),
          ),
          label: book1 == 'ZION_SONGS' ? 'HEBRON' : 'ZION',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Color.fromRGBO(177, 158, 143, 1),
          ),
          label: 'abc',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.flash_on_outlined,
            color: Color.fromRGBO(177, 158, 143, 1),
          ),
          label: 'OTHER',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            ic2,
            color: const Color.fromRGBO(177, 158, 143, 1),
          ),
          label: a2,
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => page1,
            ),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HebronPage(),
            ),
          );
        } else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Onlinehome(),
            ),
          );
        } else if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Onlinepage(),
            ),
          );
        } else if (index == 4) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => page2,
            ),
          );
        }
      },
    );
  }

  Widget butto(Widget page, String matter, double num, String fam,
      BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
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
            matter,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: num,
                fontFamily: fam,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget butto1(
      Widget page, String matter, IconData iconData, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          gradient: Decorate().eachtile(),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Icon(
                iconData,
                color: Colors.black,
                size: 40,
              ),
              Text(
                matter,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontFamily: 'f1',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchDataFromJsonFile() async {
    try {
      String jsonString = await rootBundle.loadString('assets/son.json');
      final data = jsonDecode(jsonString);
      final son = data[book1] as List<dynamic>;
      songs = son.map((e) {
        return Song.fromMap(e);
      }).toList();
    } catch (error) {
      // ignore: use_build_context_synchronously
      AlertDialog(
        title: const Text('Error'),
        content: Text('An error occurred: $error'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.error_outline),
          ),
        ],
      );
    }
  }

  BoxDecoration completetile() {
    return BoxDecoration(
      gradient: Decorate().eachtile(),
      border: Border.all(
        color: const Color.fromARGB(255, 10, 19, 37),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(20),
    );
  }

  LinearGradient eachtile() {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(255, 255, 255, 255),
        Color.fromARGB(255, 255, 255, 255),
        Color.fromRGBO(177, 158, 143, 1),
      ],
    );
  }

  Icon x(String p) {
    return const Icon(
      Icons.lyrics_outlined,
      color: Colors.white,
      size: 40,
    );
  }

  TextStyle trext(double s, String x) {
    return TextStyle(
        decoration: TextDecoration.none,
        fontFamily: x,
        fontSize: s,
        color: const Color.fromARGB(255, 255, 255, 255),
        fontWeight: FontWeight.bold);
  }

  InputDecoration searc(String p) {
    return InputDecoration(
      prefixIcon: const Icon(Icons.search),
      labelText: p,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
    );
  }

  InputDecoration searc1(String p, String r) {
    return InputDecoration(
      prefix: Text('$r. '),
      labelText: p,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
    );
  }

  BoxDecoration f() {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 48, 237, 240),
        ],
      ),
      border: Border.all(
        color: const Color.fromARGB(255, 10, 19, 37),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(20),
    );
  }

  BoxDecoration inh() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 48, 237, 240),
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 255, 255, 255),
        ],
      ),
    );
  }

  void fre(Map<String, dynamic> song) {
    String po = "";
    song.forEach((key, value) {
      if (key[0] == 'a') {
        po += ' $value\n\n';
      } else {
        po += '$key $value\n\n';
      }
    });
    Share.share(po);
  }
}
