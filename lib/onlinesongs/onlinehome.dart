import 'package:flutter/material.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/classoffunc/extractdata.dart';
import 'package:songs_app/offlinesongs/ohome.dart';
import 'package:songs_app/onlinesongs/onlinepsearch.dart';
import 'package:songs_app/onlinestart.dart';
import 'package:songs_app/onlinesongs/onlineqtelugu.dart';
import 'package:songs_app/onlinesongs/onlinergenre.dart';
import '../info.dart';

class Onlinehome extends StatefulWidget {
  const Onlinehome({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
        body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/i3.jpg"), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.all(30)),
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
                  Decorate().butto1(const SecondPage(), 'APP INFO',
                      Icons.not_listed_location_outlined, context),
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
                    MaterialPageRoute(builder: (context) => const HebronPage()),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Decorate()
            .butto(const Onlinepage(), 'SEARCH ONLINE', 22.0, 'f1', context),
      );
    }
  }
}
