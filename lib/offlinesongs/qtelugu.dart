import 'package:flutter/material.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/offlinesongs/favsongs.dart';
import 'package:songs_app/offlinesongs/ohome.dart';
import 'package:songs_app/offlinesongs/psearch.dart';
import 'package:songs_app/offlinesongs/rgenre.dart';
import 'song.dart';

class TeluguIndex extends StatefulWidget {
  const TeluguIndex({
    Key? key,
  }) : super(key: key);

  @override
  State<TeluguIndex> createState() => _TeluguIndexState();
}

class _TeluguIndexState extends State<TeluguIndex> {
  void refresh() {
    setState(() {
      songs.sort((a, b) => a.text.compareTo(b.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/i12.jpg"), fit: BoxFit.cover),
        ),
        child: TeluguIndex1(refresh: refresh),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(13, 13, 13, 1),
        elevation: 2,
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        unselectedItemColor: const Color.fromRGBO(251, 250, 250, 1),
        currentIndex: 1,
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book_rounded,
              color: Color.fromRGBO(177, 158, 143, 1),
            ),
            label: 'SEARCH',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color.fromRGBO(177, 158, 143, 1),
            ),
            label: 'abc',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.lyrics_outlined,
              color: Color.fromRGBO(177, 158, 143, 1),
            ),
            label: 'CATEGORY',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage1(),
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
                builder: (context) => const ExpandableList(),
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
        onPressed: () async {
          if (book1 == 'HEBRON_SONGS') {
            book1 = 'ZION_SONGS';
          } else {
            book1 = 'HEBRON_SONGS';
          }
          await Decorate().fetchDataFromJsonFile();
          refresh();
        },
        child: Ink(
          child: Text(
            book1 == 'ZION_SONGS' ? 'HEBRON SONGS' : 'ZION SONGS',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontFamily: 'f1',
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class TeluguIndex1 extends StatefulWidget {
  final Function refresh;
  const TeluguIndex1({
    super.key,
    required this.refresh,
  });

  @override
  State<TeluguIndex1> createState() => _TeluguIndex1State();
}

class _TeluguIndex1State extends State<TeluguIndex1> {
  @override
  void initState() {
    super.initState();

    sortcal();
  }

  void sortcal() {
    songs.sort((a, b) => a.text.compareTo(b.text));
  }

  void sortval() {
    songs.sort((a, b) => a.number.compareTo(b.number));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 25,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              weight: 20.0,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HebronPage(),
                ),
              );
            },
          ),
          title: const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 10),
            child: Text(
              'ALPHABETICAL ORDER',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontFamily: 'f1',
                  fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Fav()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.pinkAccent.shade700,
                      size: 25,
                    ),
                  ],
                ))
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return songs[index].text.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        padding: const EdgeInsets.all(3.0),
                        alignment: Alignment.center,
                        decoration: Decorate().completetile(),
                        child: InkWell(
                          onTap: () {
                            ha = songs[index];
                            sortval();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HebronSong(),
                              ),
                            );
                          },
                          child: Ink(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 48, 237, 240),
                                  Color.fromARGB(255, 255, 255, 255),
                                  Color.fromARGB(255, 255, 255, 255),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      songs[index].text,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    Text(
                                      songs[index].etext.toUpperCase(),
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Text(
                                  songs[index].number.toString(),
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(height: 0);
            },
          ),
        ),
      ],
    );
  }
}
