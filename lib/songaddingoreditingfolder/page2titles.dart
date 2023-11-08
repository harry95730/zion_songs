// ignore_for_file: library_private_types_in_public_api, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/classoffunc/extractdata.dart';
import 'package:songs_app/songaddingoreditingfolder/page3order.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage(
      {super.key, required this.s, required this.booksid, required this.sonid});
  final bool s;
  final String booksid;
  final String sonid;

  @override
  _TextFieldPageState createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  List<String> _editors = ['', '', '', ''];
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  final TextEditingController _pallavi = TextEditingController();
  final TextEditingController _anupallavi = TextEditingController();
  final List<TextEditingController> _controllers = [];
  Map<String, String> reqsong = {};

  @override
  void initState() {
    super.initState();
    if (widget.s) {
      calme();
      calsong();
    }
  }

  void calsong() async {
    List reqsong = await Dat().songrequ(widget.booksid, widget.sonid, context);
    setState(() {
      for (int i = 0; i < reqsong.length; i++) {
        Map each = reqsong[i];
        for (var key in each.keys) {
          if (key == ('పల్లవి')) {
            _pallavi.text = each['పల్లవి']!;
          } else if (key == ('అనుపల్లవి')) {
            _anupallavi.text = each['అనుపల్లవి']!;
          } else {
            _controllers.add(TextEditingController(text: each[key]));
          }
        }
      }
    });
  }

  void calme() async {
    _editors = await Dat().getdata(widget.booksid, widget.sonid, context);
    setState(() {
      if (_editors.isNotEmpty) {
        _controller1.text = _editors[0];
        _controller2.text = _editors[1];
        _controller3.text = _editors[2];
        _controller4.text = _editors[3];
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
        appBar: AppBar(
          title: const Text('SONG DETAILS'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _controller1,
                        decoration: InputDecoration(
                          labelText: 'Title 1',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _controller2,
                        decoration: InputDecoration(
                          labelText: 'Title 2',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _controller3,
                        decoration: InputDecoration(
                          labelText: 'Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _controller4,
                        decoration: InputDecoration(
                          labelText: 'Other Num.. separate with,',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Text('SONG LYRICS', style: TextStyle(fontSize: 20)),
              Column(
                children: [
                  ListTile(
                    title: TextField(
                      controller: _pallavi,
                      maxLines: null,
                      decoration: Decorate().searc1('పల్లవి', '..'),
                    ),
                  ),
                  ListTile(
                    title: TextField(
                      maxLines: null,
                      controller: _anupallavi,
                      decoration: Decorate().searc1('అనుపల్లవి', '..'),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: _controllers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: TextField(
                      controller: _controllers[index],
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _removeTextField(index);
                            });
                          },
                          child: const Icon(Icons.delete),
                        ),
                        labelText: 'Stanger ${index + 1}',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                onPressed: _addTextField,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add),
                    Text('Add stanger'),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_controller1.text.isEmpty || _controller3.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('neccesary fields must be filled'),
                      backgroundColor: Colors.red,
                    ));
                  } else {
                    List<Map<String, String>> xa = [];
                    if (_pallavi.text != "") {
                      var rs = {
                        "పల్లవి": _pallavi.text,
                      };
                      xa.add(rs);
                    }
                    if (_anupallavi.text != "") {
                      var rs = {
                        "అనుపల్లవి": _anupallavi.text,
                      };
                      xa.add(rs);
                    }
                    var j = 1;
                    for (var i in _controllers) {
                      if (i.text != "") {
                        xa.add({
                          j.toString(): i.text,
                        });
                        j = j + 1;
                      }
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Changelist(
                          mapList: xa,
                          bookid: widget.booksid,
                          songid: widget.sonid,
                          sr: widget.s,
                          fou: [
                            _controller1.text,
                            _controller2.text,
                            _controller3.text,
                            _controller4.text
                          ],
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  'PREVIEW TO REORDER AND SAVE',
                ),
              ),
              const SizedBox(height: 65)
            ],
          ),
        ),
      ),
    );
  }
}
