import 'package:flutter/material.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/onlinesongs/onlinepsearch.dart';
import 'package:songs_app/onlinesongs/onlinehome.dart';
import 'package:songs_app/onlinesongs/onlineqtelugu.dart';
import 'package:songs_app/onlinesongs/onlinesong.dart';

class Onlinegenre extends StatelessWidget {
  const Onlinegenre({super.key});

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
        child: const Onlinegenre1(),
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
              Icons.menu_book_rounded,
              color: Color.fromRGBO(177, 158, 143, 1),
            ),
            label: 'ALPHA INDEX',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Listofbooksongs(),
              ),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Onlinehome(),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Songbooktelugu(),
              ),
            );
          }
        },
      ),
    );
  }
}

class Onlinegenre1 extends StatefulWidget {
  const Onlinegenre1({super.key});

  @override
  State<Onlinegenre1> createState() => _Onlinegenre1State();
}

class _Onlinegenre1State extends State<Onlinegenre1> {
  late Map<String, List<List<String>>> _searchResults;
  @override
  void initState() {
    super.initState();
    makegenre();
  }

  void makegenre() {
    Map<String, List<List<String>>> searchResul = {};
    for (var ele in abgt) {
      if (searchResul.containsKey(ele[4])) {
        searchResul[ele[4]]!.add(ele);
      } else {
        searchResul[ele[4]] = [ele];
      }
      setState(() {
        _searchResults = searchResul;
      });
    }
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
              Navigator.pop(context);
            },
          ),
          title: const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 10),
            child: Text(
              'CATEGORY OF SONGS',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontFamily: 'f1',
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              final key = _searchResults.keys.elementAt(index);
              final value = _searchResults[key];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  padding: const EdgeInsets.all(3.0),
                  alignment: Alignment.center,
                  decoration: Decorate().completetile(),
                  child: ExpansionTile(
                    title: Text(
                      key.toUpperCase(),
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value!.length,
                        itemBuilder: (context, idx) {
                          final son = value[idx];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              padding: const EdgeInsets.all(3.0),
                              alignment: Alignment.center,
                              decoration: Decorate().completetile(),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) => Onlinedisplaysong(
                                            searchResult: son,
                                          )),
                                    ),
                                  );
                                },
                                child: Ink(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: son[1].isNotEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  son[1],
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
                                                  son[2].toUpperCase(),
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
                                              ],
                                            )
                                          : Text(
                                              son[2].toUpperCase(),
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                      trailing: Text(
                                        son[3].toString(),
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
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
