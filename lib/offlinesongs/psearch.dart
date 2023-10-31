import 'package:flutter/material.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/offlinesongs/qtelugu.dart';
import 'package:songs_app/offlinesongs/rgenre.dart';
import 'ohome.dart';
import 'song.dart';

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({
    super.key,
  });

  @override
  State<MyHomePage1> createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  TextEditingController controller = TextEditingController();
  final List<Song> _searchResults = [];
  @override
  void initState() {
    super.initState();
    controller.text = "";

    setState(() {
      songs.sort((a, b) => a.number.compareTo(b.number));
    });
  }

  _onSearchTextChanged(String query) async {
    _searchResults.clear();
    if (query.isEmpty) {
      setState(() {});
      return;
    }
    for (var element in songs) {
      if (element.text.toString().toLowerCase().contains(query.toLowerCase()) ||
          element.etext.toLowerCase().contains(query.toLowerCase()) ||
          element.number.toString().contains(query.toLowerCase())) {
        _searchResults.add(element);
      } else {
        for (var ip in element.oldnum) {
          if (ip.toString().contains(query)) {
            _searchResults.add(element);
          }
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          setState(() {
            _onSearchTextChanged(controller.text);
          });
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
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/i12.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 22.0),
            ),
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
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10),
                child: TextField(
                  onChanged: _onSearchTextChanged,
                  controller: controller,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    labelText: 'Search Song Number / Name',
                    hintMaxLines: 1,
                  ),
                ),
              ),
            ),
            Expanded(
              child: _searchResults.isNotEmpty || controller.text.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final son1 = _searchResults[index];
                          final text = son1.text;
                          final etext = son1.etext;
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              padding: const EdgeInsets.all(3.0),
                              alignment: Alignment.center,
                              decoration: Decorate().completetile(),
                              child: InkWell(
                                onTap: () {
                                  ha = son1;
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
                                        Color.fromRGBO(177, 158, 143, 1),
                                        Color.fromARGB(255, 255, 255, 255),
                                      ],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: text.isNotEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  text,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                                Text(
                                                  etext.toUpperCase(),
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Text(
                                              etext.toUpperCase(),
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                      trailing: Text(
                                        son1.number.toString(),
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
                          );
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: ListView.builder(
                        itemCount: songs.length,
                        itemBuilder: (content, index) {
                          final son1 = songs[index];
                          final text = son1.text;
                          final etext = son1.etext;
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              padding: const EdgeInsets.all(3.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(255, 255, 255, 255),
                                    Color.fromARGB(255, 255, 255, 255),
                                    Color.fromRGBO(177, 158, 143, 1)
                                  ],
                                ),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 10, 19, 37),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: InkWell(
                                onTap: () {
                                  ha = son1;
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
                                        Color.fromRGBO(177, 158, 143, 1),
                                        Color.fromARGB(255, 255, 255, 255),
                                        Color.fromARGB(255, 255, 255, 255),
                                      ],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: text.isNotEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  text,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                                Text(
                                                  etext.toUpperCase(),
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Text(
                                              etext.toUpperCase(),
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                      trailing: Text(
                                        son1.number.toString(),
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
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
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
            label: 'ALPHA INDEX',
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
                builder: (context) => const TeluguIndex(),
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
    );
  }
}
