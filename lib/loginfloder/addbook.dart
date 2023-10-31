import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:songs_app/loginfloder/authentication.dart';
import 'package:songs_app/songaddingoreditingfolder/songaddedit.dart';
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
      'PIN NUMBER FOR BOOK',
      'DISPLAY NAME',
      'VERSE FOR DISPLAY',
      'CHRUCH NAME'
    ];

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'SONG BOOK DETAILS',
          style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: 'f1',
            color: Color.fromARGB(255, 16, 44, 86),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                  top: 12.0, bottom: 5.0, left: 12.0, right: 12.0),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 8; i++)
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: TextField(
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
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                  ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 14.0),
            ),
            FloatingActionButton.extended(
                onPressed: () async {
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
                        context);
                    if (result != null) {
                      for (int i = 0; i < 8; i++) {
                        _controllers[i].text = '';
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Addeditsong(eachid: result.uid.toString())));
                    }
                  }
                },
                label: const Text('SUBMIT', style: TextStyle(fontSize: 25))),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
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
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
          ],
        ),
      ),
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
            Navigator.pop(
              context,
            );
          }
          if (index == 1) {
            Navigator.pop(context);
            Navigator.pop(context);
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
