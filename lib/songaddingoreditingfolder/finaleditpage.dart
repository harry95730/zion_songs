import 'package:flutter/material.dart';
import 'package:songs_app/songaddingoreditingfolder/previewpage.dart';

class ReorderableMapList extends StatefulWidget {
  final List<Map<String, dynamic>> mapList;
  final String bookid;
  final String songid;
  final bool sr;
  final List<String> fou;
  const ReorderableMapList(
      {super.key,
      required this.mapList,
      required this.bookid,
      required this.songid,
      required this.sr,
      required this.fou});

  @override
  // ignore: library_private_types_in_public_api
  _ReorderableMapListState createState() => _ReorderableMapListState();
}

class _ReorderableMapListState extends State<ReorderableMapList> {
  List<Map<String, dynamic>> _reorderedMapList = [];

  @override
  void initState() {
    super.initState();
    _reorderedMapList = List.from(widget.mapList);
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _reorderedMapList.removeAt(oldIndex);
      _reorderedMapList.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'REORDER THE SONG ',
              style: TextStyle(
                color: Colors.black,
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ReorderableListView.builder(
            itemCount: _reorderedMapList.length,
            onReorder: _onReorder,
            itemBuilder: (context, index) {
              final map = _reorderedMapList[index];
              return ListTile(
                key: ValueKey(index),
                contentPadding: const EdgeInsets.all(0),
                leading: IconButton(
                  onPressed: () {
                    if (index > 0) {
                      setState(() {
                        final item = _reorderedMapList.removeAt(index);
                        _reorderedMapList.insert(index - 1, item);
                      });
                    }
                  },
                  icon: const Icon(Icons.keyboard_arrow_up),
                ),
                title: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    map['subtitle'],
                    style: const TextStyle(
                        height: 1.5,
                        fontSize: 16,
                        color: Color.fromARGB(255, 3, 1, 1)),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    if (index < _reorderedMapList.length - 1) {
                      setState(() {
                        final item = _reorderedMapList.removeAt(index);
                        _reorderedMapList.insert(index + 1, item);
                      });
                    }
                  },
                  icon: const Icon(Icons.keyboard_arrow_down),
                ),
              );
            },
          ),
        ),
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Map<String, String> kl = {};
              for (var ma in _reorderedMapList) {
                final title = ma['title'] ?? '';
                final subtitle = ma['subtitle']?.toString() ?? '';
                kl[title] = subtitle;
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PreviewSong(
                            mapLis: kl,
                            booid: widget.bookid,
                            songio: widget.songid,
                            vra: widget.sr,
                            fou: widget.fou,
                          )));
            },
            elevation: 0,
            backgroundColor: Colors.transparent,
            label: const Text(
              'VIEW TO SAVE',
              style: TextStyle(color: Colors.black),
            )),
      ),
    );
  }
}
