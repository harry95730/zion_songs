// ignore_for_file: library_private_types_in_public_api, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/classoffunc/extractdata.dart';
import 'package:songs_app/songaddingoreditingfolder/songlyricsadd.dart';

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

  void _submit() {
    if (_controller1.text.isEmpty ||
        _controller2.text.isEmpty ||
        _controller3.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('fields must be filled before updating lyrics'),
        backgroundColor: Colors.red,
      ));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddTextFieldPage(
            fou: [
              _controller1.text,
              _controller2.text,
              _controller3.text,
              _controller4.text
            ],
            boold: widget.booksid,
            br: widget.s,
            sid: widget.sonid,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.s) {
      calme();
    }
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
                    'SONG DETAILS',
                    style: TextStyle(fontSize: 40),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controller1,
                      decoration: Decorate().searc('Telugu title'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controller2,
                      decoration: Decorate().searc('English title'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controller3,
                      decoration: Decorate().searc('Number'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controller4,
                      decoration: Decorate()
                          .searc('List of old songs separate them with ,'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text(
                      'SONG LYRICS',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.transparent,
          elevation: 0,
          label: const Icon(
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
}
