// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:songs_app/classoffunc/extractdata.dart';
import 'package:songs_app/songaddingoreditingfolder/page1edit.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class Changelist extends StatefulWidget {
  final List<Map<String, dynamic>> mapList;
  final String bookid;
  final String songid;
  final bool sr;
  final List<String> fou;
  const Changelist(
      {super.key,
      required this.mapList,
      required this.bookid,
      required this.songid,
      required this.sr,
      required this.fou});

  @override
  _ChangelistState createState() => _ChangelistState();
}

class _ChangelistState extends State<Changelist> {
  int count = 0;
  @override
  void initState() {
    super.initState();
    count = 0;
    WakelockPlus.enable();
  }

  void _shareDictionaryData(List dictionaryData) {
    String sharedText = '';
    for (int i = 0; i < dictionaryData.length; i++) {
      Map xf = dictionaryData[i];
      for (var j in xf.keys) {
        sharedText += "$j.  ${xf[j]}\n\n";
      }
    }
    Share.share(sharedText);
  }

  void submit(BuildContext context) async {
    bool bs = await Dat().updateDocumentField(
        widget.bookid, widget.songid, widget.fou, widget.mapList, context);
    if (bs) {
      WakelockPlus.disable();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Addeditsong(eachid: widget.bookid)),
        (Route<dynamic> route) => false,
      );
    }
  }

  void subm(BuildContext context) async {
    bool bs = await Dat().addition(
        widget.bookid, widget.songid, widget.fou, widget.mapList, context);
    if (bs) {
      WakelockPlus.disable();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Addeditsong(eachid: widget.bookid)),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Drag to REORDER ',
              style: TextStyle(
                color: Colors.black,
              ),
            )),
        body: Scaffold(
          appBar: AppBar(
            leading: Center(
              child: Text(
                widget.fou[2],
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    widget.fou[0],
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            actions: [
              const Padding(padding: EdgeInsets.all(20)),
              IconButton(
                  onPressed: () {
                    _shareDictionaryData(widget.mapList);
                  },
                  icon: const Icon(Icons.share, color: Colors.black)),
            ],
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: widget.mapList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> item = widget.mapList[index];
                List keys = item.keys.toList();
                if (index == 0) {
                  count = 0;
                }
                if (keys[0] != "పల్లవి" && keys[0] != "అనుపల్లవి") {
                  count++;
                }
                return Draggable<Map<String, dynamic>>(
                  data: item,
                  childWhenDragging: Container(
                    color: Colors.blue.shade300,
                    child: ListTile(
                        title: Row(
                      children: [
                        Expanded(
                            flex: keys[0] == "పల్లవి" || keys[0] == "అనుపల్లవి"
                                ? 2
                                : 1,
                            child: keys[0] == "పల్లవి"
                                ? Text(keys[0])
                                : keys[0] == "అనుపల్లవి"
                                    ? const Text("అ||ప||")
                                    : Text('$count')),
                        Expanded(
                            flex: keys.isNotEmpty ? 9 : 10,
                            child: keys.isNotEmpty
                                ? Text(item[keys[0]])
                                : Text(item[keys[0]])),
                      ],
                    )),
                  ),
                  feedback: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(height: 30, color: Colors.blue)),
                  child: DragTarget<Map<String, dynamic>>(
                    builder: (context, acceptedData, rejectedData) {
                      return ListTile(
                          title: Row(
                        children: [
                          Expanded(
                              flex:
                                  keys[0] == "పల్లవి" || keys[0] == "అనుపల్లవి"
                                      ? 2
                                      : 1,
                              child: keys[0] == "పల్లవి"
                                  ? Text(keys[0])
                                  : keys[0] == "అనుపల్లవి"
                                      ? const Text("అ||ప||")
                                      : Text('$count')),
                          Expanded(
                              flex:
                                  keys[0] == "పల్లవి" || keys[0] == "అనుపల్లవి"
                                      ? 9
                                      : 10,
                              child: Text(item[keys[0]])),
                        ],
                      ));
                    },
                    onWillAccept: (data) {
                      setState(() {});
                      return true;
                    },
                    onAccept: (data) {
                      setState(() {
                        widget.mapList
                            .removeWhere((element) => element == data);
                        widget.mapList.insert(index, data);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevatedButton(
            onPressed: () {
              if (widget.sr) {
                submit(context);
              } else {
                subm(context);
              }
            },
            child: const Text(
              'SAVE',
              style: TextStyle(color: Colors.black),
            )),
      ),
    );
  }
}
