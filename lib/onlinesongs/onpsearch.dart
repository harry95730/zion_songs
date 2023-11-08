// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/onlinesongs/onqtelugu.dart';
import 'package:songs_app/onlinesongs/onrgenre.dart';
import 'package:songs_app/onlinesongs/onsong.dart';

class Listofbooksongs extends StatefulWidget {
  Listofbooksongs({
    super.key,
  });

  @override
  State<Listofbooksongs> createState() => ListStateofbooksongs();
}

class ListStateofbooksongs extends State<Listofbooksongs> {
  bool _initialized = false;
  @override
  void initState() {
    super.initState();
    sortfun();
  }

  void sortfun() {
    setState(() {
      _initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _initialized
              ? Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/i12.jpg"),
                        fit: BoxFit.cover),
                  ),
                  child: const Showsonglist(),
                )
              : const CircularProgressIndicator(),
        ),
        bottomNavigationBar: Decorate().botto(
            context,
            const Songbooktelugu(),
            const Onlinegenre(),
            Icons.menu_book_rounded,
            Icons.lyrics_outlined,
            'ALPHA INDEX',
            'CATEGORY'));
  }
}

class Showsonglist extends StatefulWidget {
  const Showsonglist({super.key});

  @override
  State<Showsonglist> createState() => _ShowsonglistState();
}

class _ShowsonglistState extends State<Showsonglist> {
  TextEditingController controller = TextEditingController();
  List<List<String>> _searchResults = [[]];
  bool _vro = true;

  late List<List<String>> op = [[]];
  @override
  void initState() {
    _searchResults = abgt;
    super.initState();
  }

  Future<void> _onSearchTextChanged(String query) async {
    op.clear();
    if (query.isEmpty) {
      setState(() {
        _vro = true;
        _searchResults = List.from(abgt);
      });
      return;
    }
    for (var element in List.from(abgt)) {
      if (element[1].toString().contains(query.toLowerCase()) ||
          element[2].toString().toLowerCase().contains(query.toLowerCase()) ||
          element[3].toString().toLowerCase().contains(query.toLowerCase())) {
        op.add(element);
      }
    }

    setState(() {
      _searchResults = op;
      if (op.isEmpty) {
        _vro = false;
      } else {
        _vro = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 22.0)),
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
                    labelText: 'Search  Song Number / Name',
                    hintMaxLines: 1,
                  ),
                ),
              ),
            ),
            Expanded(
              child: _vro
                  ? Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          var son1 = _searchResults[index][1];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(5.0),
                              decoration: Decorate().completetile(),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) => Onlinedisplaysong(
                                            searchResult: _searchResults[index],
                                          )),
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
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          son1,
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
                                          _searchResults[index][2]
                                              .toUpperCase(),
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
                                      _searchResults[index][3].toString(),
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
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text(
                        'NO SONG BOOK FOUND',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
