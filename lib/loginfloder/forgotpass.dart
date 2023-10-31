import 'package:flutter/material.dart';
import 'package:songs_app/loginfloder/authentication.dart';

// ignore: must_be_immutable
class Forgotpass extends StatefulWidget {
  const Forgotpass({super.key});

  @override
  State<Forgotpass> createState() => ForgotpassState();
}

class ForgotpassState extends State<Forgotpass> {
  final TextEditingController _controller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            'CHANGE PASSWORD',
            style: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'f1',
              color: Color.fromARGB(255, 16, 44, 86),
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'CHANGE PASSWORD',
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
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              FloatingActionButton.extended(
                  onPressed: () async {
                    Future<bool> rm = AuthService()
                        .changeuserpass(_controller1.text, context);
                    if (await rm) {
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  },
                  label: const Text('SUBMIT', style: TextStyle(fontSize: 25))),
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'GOT BACK YOUR PASSWORD ? SIGNUP ',
                ),
              ),
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
          ],
          onTap: (index) {
            if (index == 0) {
              Navigator.pop(context);
              Navigator.pop(context);
            }
            if (index == 1) {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
