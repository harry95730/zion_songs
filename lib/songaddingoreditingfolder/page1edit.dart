// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/classoffunc/extractdata.dart';
import 'package:songs_app/songaddingoreditingfolder/page2titles.dart';
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
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
      body: _initialized
          ? Container(
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
              child: Addoredit(
                docid: widget.eachid,
                songeditofbook: _songeditlist,
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TextFieldPage(
                s: false,
                booksid: widget.eachid,
                sonid: '',
              ),
            ),
          );
        },
        child: const Text(
          'ADD NEW SONG',
          style: TextStyle(color: Colors.black),
        ),
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
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        print('Selected file: ${file.name}');

        print('File path: ${file.path}');

        File fle = File('file.path');
        if (await fle.exists()) {
          String content = await fle.readAsString();
          print(content);
        }
      }
    } catch (e) {
      //
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
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _onSearchTextChanged,
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                hintStyle: const TextStyle(color: Colors.white),
                fillColor: Colors.black,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                labelText: 'Search Song',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          _vro
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    var son1 = _searchResults[index][1];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(3.0),
                        alignment: Alignment.center,
                        decoration: Decorate().completetile(),
                        child: ListTile(
                          leading: Text(
                            _searchResults[index][3],
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          title: Text(
                            '$son1\n${_searchResults[index][2]}',
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
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
                    );
                  },
                )
              : Container(
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      'NO SONG BOOK FOUND',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
