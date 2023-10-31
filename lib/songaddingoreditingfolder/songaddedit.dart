// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/classoffunc/extractdata.dart';
import 'package:songs_app/songaddingoreditingfolder/songmaintext.dart';
import 'package:file_picker/file_picker.dart';

class Addeditsong extends StatefulWidget {
  Addeditsong({super.key, required this.eachid});
  String eachid;

  @override
  State<Addeditsong> createState() => _AddeditsongState();
}

class _AddeditsongState extends State<Addeditsong> {
  bool _initialized = false;
  late List<List<String>> _songeditlist = [[]];
  @override
  void initState() {
    super.initState();
    allthesongs();
  }

  allthesongs() async {
    _songeditlist =
        await Dat().displaySubcollectionTitles(widget.eachid, context);
    setState(() {
      _initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _initialized
            ? SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 255, 255, 255),
                        Color.fromARGB(255, 48, 237, 240),
                        Color.fromARGB(255, 255, 255, 255),
                      ],
                    ),
                  ),
                  child: Addoredit(
                    docid: widget.eachid,
                    songeditofbook: _songeditlist,
                  ),
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}

class Addoredit extends StatefulWidget {
  Addoredit({super.key, required this.docid, required this.songeditofbook});
  String docid = '';
  final List<List<String>> songeditofbook;
  List<String> docte = [];

  @override
  State<Addoredit> createState() => _AddoreditState();
}

class _AddoreditState extends State<Addoredit> {
  TextEditingController controller = TextEditingController();
  List<List<String>> _searchResults = [[]];
  bool _vro = true;

  late List<List<String>> op = [[]];
  @override
  void initState() {
    _searchResults = widget.songeditofbook;

    super.initState();
  }

  Future<void> pickAndOpenSpecificFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, // Specify the type of files to pick
        allowedExtensions: [
          'pdf',
          'doc',
          'docx',
          'txt'
        ], // List of allowed file extensions
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        // Do something with the selected file
        print('Selected file: ${file.name}');

        print('File path: ${file.path}');

        File fle = File('file.path');
        if (await fle.exists()) {
          String content = await fle.readAsString();
          print(content);
        }
      } else {
        // User canceled the picker
        print('No file selected.');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<void> _onSearchTextChanged(String query) async {
    op.clear();
    if (query.isEmpty) {
      setState(() {
        _vro = true;
        _searchResults = List.from(widget.songeditofbook);
      });
      return;
    }
    for (var element in List.from(widget.songeditofbook)) {
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
        return SafeArea(
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 10, left: 5, right: 5)),
              AppBar(
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
                  'SEARCH SONG',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 25.0,
                    fontFamily: 'f1',
                    color: Color.fromARGB(255, 16, 44, 86),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: _onSearchTextChanged,
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    labelText: 'Search Song',
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
                          var son1 = _searchResults[index][1];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(5.0),
                              decoration: Decorate().f(),
                              child: Ink(
                                child: ListTile(
                                  leading: Text(
                                    _searchResults[index][3],
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
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
                                        _searchResults[index][2],
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
                                  trailing: IconButton(
                                    color: Colors.black,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TextFieldPage(
                                              s: true,
                                              booksid: widget.docid,
                                              sonid: _searchResults[index][0]),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
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
              FloatingActionButton.extended(
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TextFieldPage(
                        s: false,
                        booksid: widget.docid,
                        sonid: '',
                      ),
                    ),
                  );
                },
                label: const Text(
                  'ADD NEW SONG',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
