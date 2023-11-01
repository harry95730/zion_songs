import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/info.dart';
import 'package:songs_app/offlinesongs/favsongs.dart';
import 'package:songs_app/offlinesongs/ohome.dart';
import 'package:songs_app/offlinesongs/psearch.dart';
import 'package:songs_app/offlinesongs/rgenre.dart';
import 'package:songs_app/onlinestart.dart';
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
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/i12.jpg"),
                  fit: BoxFit.cover),
            ),
            child: TeluguIndex1(refresh: refresh),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () async {
                if (book1 == 'HEBRON_SONGS') {
                  book1 = 'ZION_SONGS';
                } else {
                  book1 = 'HEBRON_SONGS';
                }
                await Decorate().fetchDataFromJsonFile();
                refresh();
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromRGBO(102, 255, 255, 0.8),
                    ],
                  ),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 2.0),
                  child: Text(
                    book1 == 'ZION_SONGS' ? 'HEBRON' : 'ZION',
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
          ),
        ],
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
              Icons.search,
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
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return Decorate().butto2(context);
        },
      ),
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
              leading: const Icon(
                Icons.home,
                color: Colors.tealAccent,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HebronPage(),
                  ),
                );
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
              leading: const Icon(
                Icons.search,
                color: Colors.deepOrange,
              ),
              title: const Text('Search'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage1(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.lyrics_outlined,
                color: Colors.deepPurpleAccent.shade100,
              ),
              title: const Text('CATEGORY'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExpandableList(),
                  ),
                );
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
              leading: const Icon(
                Icons.not_listed_location_outlined,
              ),
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
