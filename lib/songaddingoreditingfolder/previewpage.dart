// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:songs_app/classoffunc/extractdata.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class PreviewSong extends StatelessWidget {
  const PreviewSong(
      {super.key,
      required this.mapLis,
      required this.booid,
      required this.songio,
      required this.vra,
      required this.fou});
  final Map<String, String> mapLis;
  final String booid;
  final String songio;
  final bool vra;
  final List<String> fou;

  void _shareDictionaryData(dictionaryData) {
    String sharedText = '';
    dictionaryData.forEach((key, value) {
      sharedText += '$key  $value\n\n';
    });
    Share.share(sharedText);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(240, 83, 201, 219),
            elevation: 0,
            title: const Text(
              'SONG VIEW ',
              style: TextStyle(
                color: Colors.black,
              ),
            )),
        body: Scaffold(
          appBar: AppBar(
            leading: Center(
              child: Text(
                fou[2],
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    fou[0],
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 30)),
                  Text(
                    fou[3],
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 30)),
                  Text(
                    fou[1],
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            actions: [
              const Padding(padding: EdgeInsets.all(20)),
              IconButton(
                  onPressed: () {
                    _shareDictionaryData(mapLis);
                  },
                  icon: const Icon(Icons.share, color: Colors.black)),
            ],
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 48, 237, 240)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          body: PreviewScrollableTextContainer(
            text: mapLis,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                if (vra) {
                  submit(context);
                } else {
                  subm(context);
                }
              },
              elevation: 0,
              backgroundColor: Colors.transparent,
              label: const Text(
                'SAVE',
                style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              )),
        ),
      ),
    );
  }

  void submit(BuildContext context) async {
    bool bs =
        await Dat().updateDocumentField(booid, songio, fou, mapLis, context);
    if (bs) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  void subm(BuildContext context) async {
    bool bs = await Dat().addition(booid, songio, fou, mapLis, context);
    if (bs) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}

class PreviewScrollableTextContainer extends StatefulWidget {
  final Map<String, String> text;

  const PreviewScrollableTextContainer({super.key, required this.text});

  @override
  State<PreviewScrollableTextContainer> createState() =>
      _PreviewScrollableTextContainerState();
}

class _PreviewScrollableTextContainerState
    extends State<PreviewScrollableTextContainer> {
  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: InteractiveViewer(
        minScale: 0.1,
        maxScale: 2.0,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.text.entries.map((entry) {
              return ListTile(
                dense: true,
                minLeadingWidth: 1.0,
                leading: Text(
                  entry.key,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                title: Text(
                  entry.value.toString(),
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
