// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:songs_app/classoffunc/classes.dart';

class ProgressIndicatorPage extends StatefulWidget {
  const ProgressIndicatorPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProgressIndicatorPageState createState() => _ProgressIndicatorPageState();
}

class _ProgressIndicatorPageState extends State<ProgressIndicatorPage> {
  void f() async {
    await fetchJsonFromGoogleDrive();
    Navigator.pop(context);
  }

  @override
  void initState() {
    f();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading...'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.maxFinite,
        color: Colors.black,
        child: const Center(
          child:
              CircularProgressIndicator(backgroundColor: Colors.indigoAccent),
        ),
      ),
    );
  }
}
