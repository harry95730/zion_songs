// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:songs_app/classoffunc/database.dart';
import 'package:songs_app/loginfloder/addbook.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/loginfloder/updatebook.dart';
import 'package:songs_app/onlinesongs/onlinehome.dart';

// ignore: must_be_immutable
class Onlinepage extends StatefulWidget {
  const Onlinepage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnlinepageState createState() => _OnlinepageState();
}

class _OnlinepageState extends State<Onlinepage> {
  bool _initialized = false;
  late List<List<String>> x = [[]];
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    try {
      List<List<String>> px = await Dbm().dataread(context);
      setState(() {
        _initialized = true;
        x = px;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _initialized
          ? Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/i12.jpg"),
                    fit: BoxFit.cover),
              ),
              child: Listofbooks(onlinelist: x),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class Listofbooks extends StatefulWidget {
  const Listofbooks({super.key, required this.onlinelist});
  final List<List<String>> onlinelist;
  @override
  State<Listofbooks> createState() => LlistofStaofbooks();
}

class LlistofStaofbooks extends State<Listofbooks> {
  TextEditingController controller = TextEditingController();
  List<List<String>> _searchResults = [[]];
  bool _vro = true;
  List<List<String>> op = [[]];
  @override
  void initState() {
    _searchResults = widget.onlinelist;
    super.initState();
  }

  Future<void> _onSearchTextChanged(String query) async {
    op.clear();
    if (query.isEmpty) {
      setState(() {
        _vro = true;

        _searchResults = List.from(widget.onlinelist);
      });
      return;
    }
    for (var element in List.from(widget.onlinelist)) {
      if (element[0].toString().toLowerCase().contains(query.toLowerCase()) ||
          element[1].toString().toLowerCase().contains(query.toLowerCase())) {
        _vro = true;
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
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/i12.jpg"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'SEARCH SONG BOOK ',
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 25.0,
              fontFamily: 'f1',
              color: Color.fromARGB(255, 16, 44, 86),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: _onSearchTextChanged,
                controller: controller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  labelText: 'Search Song book',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
            ),
            Expanded(
              child: _vro
                  ? ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        var son1 = _searchResults[index][0];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(5.0),
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
                                book = _searchResults[index][2];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Onlinehome(),
                                  ),
                                );
                              },
                              child: Ink(
                                child: ListTile(
                                  title: Text(
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
                                  trailing: Text(
                                    _searchResults[index][1],
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EntryPage(x: widget.onlinelist)));
                  },
                  child: const Text(
                    'ADD A NEW SONG BOOK',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Updatebook(x: widget.onlinelist)),
                    );
                  },
                  child: const Text(
                    'UPLOAD TO A SONG BOOK',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
