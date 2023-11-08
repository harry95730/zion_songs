// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:songs_app/loginfloder/authentication.dart';
import 'package:songs_app/offlinesongs/ohome.dart';
import 'package:songs_app/onlinestart.dart';
import 'package:songs_app/songaddingoreditingfolder/page1edit.dart';
import 'package:songs_app/loginfloder/updatebook.dart';

// ignore: must_be_immutable
class EntryPage extends StatefulWidget {
  EntryPage({super.key, required this.x});
  List<List<String>> x = [[]];

  @override
  // ignore: library_private_types_in_public_api
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  File? filea;
  bool isload = false;
  String tet = 'PICK A IMAGE FOR BACKGROUND';
  final List<TextEditingController> _controllers =
      List.generate(8, (index) => TextEditingController());

  var manag = <String>['', '', '', '', '', '', '', ''];
  @override
  Widget build(BuildContext context) {
    var manage = [
      'EMAIL',
      'PASSWORD',
      'CONFIRM PASSWORD',
      'MOBILE NUMBER',
      'PIN FOR BOOK',
      'DISPLAY NAME',
      'VERSE FOR DISPLAY',
      'CHRUCH NAME'
    ];

    return isload
        ? const Center(
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
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'SONG BOOK DETAILS',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'f1',
                  color: Color.fromARGB(255, 16, 44, 86),
                ),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 8; i++)
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: SizedBox(
                          height: 45,
                          child: TextField(
                            style: const TextStyle(fontSize: 16.0),
                            obscureText: i == 1 || i == 2 ? true : false,
                            controller: _controllers[i],
                            onChanged: (value) {
                              setState(() {
                                manag[i] = '';
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.edit_outlined),
                              labelText: manage[i],
                              errorText: manag[i].isNotEmpty ? manag[i] : null,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          tet,
                          style: TextStyle(
                              color: tet == 'PICK A IMAGE FOR BACKGROUND'
                                  ? Colors.red
                                  : Colors.green),
                        ),
                        OutlinedButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['jpg', 'png'],
                            );
                            if (result != null) {
                              File file = File(result.files.single.path!);
                              if (file.path.endsWith('jpg') ||
                                  file.path.endsWith('png')) {
                                filea = file;
                                setState(() {
                                  tet = 'IMAGE IS SELECTED';
                                });
                              }
                            } else {
                              setState(() {
                                filea = null;
                                tet = 'PICK A IMAGE FOR BACKGROUND';
                              });
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            'UPLOAD',
                          ),
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Updatebook(x: widget.x),
                            ));
                      },
                      child: const Text(
                        'EXISTING USERS ? LOGIN ',
                      ),
                    ),
                    const SizedBox(
                      height: 65,
                    )
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    isload = true;
                  });
                  if (_controllers[1].text != _controllers[2].text) {
                    setState(() {
                      manag[2] = "Password doesn't match";
                    });
                  } else {
                    setState(() {
                      manag[2] = '';
                    });
                    for (int i = 0; i < widget.x.length; i++) {
                      if (widget.x[i][0] == _controllers[5].text) {
                        setState(() {
                          manag[5] = "Song book name exists";
                        });
                        return;
                      } else if (widget.x[i][1] == _controllers[4].text) {
                        setState(() {
                          manag[4] = "Song book pin exists";
                        });
                        return;
                      }
                    }
                    setState(() {
                      manag[5] = '';
                    });

                    for (int i = 0; i < _controllers.length; i++) {
                      if (_controllers[i].text.isEmpty) {
                        showErrorNotification(
                            context, 'All the fields must be filled');
                        return;
                      }
                    }

                    User? result = await AuthService().registerUser1(
                        _controllers[0].text,
                        _controllers[1].text,
                        _controllers[5].text,
                        _controllers[4].text,
                        _controllers[6].text,
                        _controllers[7].text,
                        filea,
                        context);
                    if (result != null) {
                      for (int i = 0; i < 8; i++) {
                        _controllers[i].text = '';
                      }
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Addeditsong(eachid: result.uid.toString())));
                    }
                  }
                  setState(() {
                    isload = false;
                  });
                },
                child: const Text('SUBMIT')),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.search, color: Colors.blue),
                  label: 'search song book',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.offline_bolt),
                  label: 'offline songs',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.update),
                  label: 'upload songs',
                ),
              ],
              onTap: (index) {
                if (index == 0) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Onlinepage()),
                    (Route<dynamic> route) => false,
                  );
                }
                if (index == 1) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HebronPage()),
                    (Route<dynamic> route) => false,
                  );
                }
                if (index == 2) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Updatebook(x: widget.x),
                      ));
                }
              },
            ),
          );
  }

  void showErrorNotification(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
