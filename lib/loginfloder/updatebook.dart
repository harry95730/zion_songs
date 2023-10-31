// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:songs_app/loginfloder/addbook.dart';
import 'package:songs_app/loginfloder/authentication.dart';
import 'package:songs_app/loginfloder/forgotpass.dart';
import 'package:songs_app/songaddingoreditingfolder/songaddedit.dart';

// ignore: must_be_immutable
class Updatebook extends StatefulWidget {
  Updatebook({super.key, required this.x});
  List<List<String>> x = [[]];

  @override
  State<Updatebook> createState() => UpdatebookState();
}

class UpdatebookState extends State<Updatebook> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'UPDATE',
          style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: 'f1',
            color: Color.fromARGB(255, 16, 44, 86),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'LOGIN TO UPDATE',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'f1',
                  fontSize: 22.0,
                  color: Color.fromARGB(255, 16, 44, 86),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, bottom: 5.0, left: 9.0, right: 9.0),
                  child: TextField(
                    controller: _controller1,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.edit_outlined),
                      labelText: 'EMAIL',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: TextField(
                    obscureText: true,
                    controller: _controller,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.edit_outlined),
                      labelText: 'PASSWORD',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                  )),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Forgotpass(),
                      ));
                },
                child: const Text(
                  'FORGOT PASSWORD',
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              FloatingActionButton.extended(
                  onPressed: () async {
                    User? result = await AuthService().loginUser(
                        _controller1.text, _controller.text, context);
                    if (result != null) {
                      _controller.text = '';
                      _controller1.text = '';
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Addeditsong(eachid: result.uid.toString())));
                    }
                  },
                  label: const Text('SUBMIT', style: TextStyle(fontSize: 25))),
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EntryPage(x: widget.x),
                      ));
                },
                child: const Text(
                  'JOIN AS A NEW USER ? SIGNUP ',
                ),
              ),
            ],
          ),
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
            label: 'new song book',
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
                builder: (context) => EntryPage(
                  x: widget.x,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
