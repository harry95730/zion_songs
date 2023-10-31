// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/classoffunc/extractdata.dart';
import 'package:songs_app/songaddingoreditingfolder/finaleditpage.dart';

// ignore: must_be_immutable
class AddTextFieldPage extends StatefulWidget {
  AddTextFieldPage({
    super.key,
    required this.fou,
    required this.boold,
    required this.sid,
    required this.br,
  });
  List<String> fou;
  final String boold;
  final String sid;
  final bool br;

  @override
  _AddTextFieldPageState createState() => _AddTextFieldPageState();
}

class _AddTextFieldPageState extends State<AddTextFieldPage> {
  final List<TextEditingController> _controllers = [];
  Map<String, String> reqsong = {};
  final TextEditingController _pallavi = TextEditingController();
  final TextEditingController _anupallavi = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.br) {
      calsong();
    }
  }

  void calsong() async {
    reqsong = await Dat().songrequ(widget.boold, widget.sid, context);
    setState(() {
      for (var p in reqsong.keys) {
        if (p == ('పల్లవి')) {
          _pallavi.text = reqsong['పల్లవి']!;
        } else if (p == ('అనుపల్లవి')) {
          _anupallavi.text = reqsong['అనుపల్లవి']!;
        } else {
          _controllers.add(TextEditingController(text: reqsong[p]));
        }
      }
    });
  }

  void _addTextField() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  void _removeTextField(int index) {
    setState(() {
      _controllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'SONGS ADDING OR UPDATING',
                    style: TextStyle(fontSize: 25),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _pallavi,
                          maxLines: null,
                          decoration: Decorate().searc1('పల్లవి', '..'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          maxLines: null,
                          controller: _anupallavi,
                          decoration: Decorate().searc1('అనుపల్లవి', '..'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: _controllers.asMap().entries.map((entry) {
                      final index = entry.key;
                      final controller = entry.value;
                      return Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: controller,
                                decoration: Decorate().searc1(
                                    'Stanger ${index + 1}',
                                    (index + 1).toString()),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _removeTextField(index),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: const Icon(Icons.delete),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _addTextField,
                    icon: const Icon(Icons.add),
                    label: const Text('Add stanger'),
                  ),
                  TextButton(
                    onPressed: () {
                      List<Map<String, String>> xa = [];
                      if (_pallavi.text != "") {
                        var rs = {
                          'title': "పల్లవి",
                          'subtitle': _pallavi.text,
                        };
                        xa.add(rs);
                      }
                      if (_anupallavi.text != "") {
                        var rs = {
                          'title': "అనుపల్లవి",
                          'subtitle': _anupallavi.text,
                        };
                        xa.add(rs);
                      }
                      var j = 1;
                      for (var i in _controllers) {
                        if (i.text != "") {
                          xa.add({
                            'title': j.toString(),
                            'subtitle': i.text,
                          });
                          j = j + 1;
                        }
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReorderableMapList(
                            mapList: xa,
                            bookid: widget.boold,
                            songid: widget.sid,
                            sr: widget.br,
                            fou: widget.fou,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'PREVIEW TO REORDER AND SAVE',
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                ],
              ),
            ),
          ),
        ),
        extendBody: true,
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
