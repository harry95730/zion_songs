import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:songs_app/classoffunc/extractdata.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'onpsearch.dart';
import 'onhome.dart';

class Onlinedisplaysong extends StatefulWidget {
  const Onlinedisplaysong({super.key, required this.searchResult});
  final List<String> searchResult;

  @override
  State<Onlinedisplaysong> createState() => _OnlinedisplaysongState();
}

class _OnlinedisplaysongState extends State<Onlinedisplaysong> {
  bool isLoading = true;
  bool yt = false;
  bool _vro = false;
  List map = [];
  // ignore: prefer_typing_uninitialized_variables
  var data1;
  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    fre();
    darkorlight();
    yt = false;
  }

  void fre() async {
    map = await Dat().songrequ(book, widget.searchResult[0], context);
    setState(() {
      _vro = true;
    });
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

  Future<void> darkorlight() async {
    try {
      final son = globalVariable;
      setState(() {
        _vro = true;
        if (son == 0) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      });
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('An error occurred: $error'),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.error_outline),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(177, 158, 143, 1),
                Color.fromARGB(255, 255, 255, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              color: const Color.fromARGB(252, 0, 0, 0),
              onPressed: () {
                setState(() {
                  WakelockPlus.disable();
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Onlinehome(),
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              color: const Color.fromARGB(252, 0, 0, 0),
              onPressed: () {
                setState(() {
                  WakelockPlus.disable();
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Listofbooksongs(),
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25),
            ),
            IconButton(
              icon: Icon(isLoading ? Icons.lightbulb : Icons.lightbulb),
              color: isLoading ? Colors.black : Colors.white,
              onPressed: () async {
                setState(() {
                  if (isLoading) {
                    globalVariable = 1;
                    isLoading = false;
                  } else {
                    globalVariable = 0;
                    isLoading = true;
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: Scaffold(
        backgroundColor: isLoading ? Colors.white : Colors.black,
        appBar: AppBar(
          leadingWidth: 47,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Center(
              child: Text(
                widget.searchResult[3].toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Padding(padding: EdgeInsets.only(right: 5)),
                Text(
                  widget.searchResult[1],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (yt == false) {
                  setState(() {
                    yt = true;
                  });
                } else {
                  setState(() {
                    yt = false;
                  });
                }
              },
              icon: Icon(yt ? Icons.stop_circle : Icons.play_circle,
                  color: yt ? Colors.red : Colors.green),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  WakelockPlus.disable();
                });
                _shareDictionaryData(map);
              },
              icon: const Icon(Icons.share, color: Colors.black),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromRGBO(177, 158, 143, 1)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: _vro
            ? OnlineScroll(
                b: isLoading,
                yt: yt,
                text: map,
                si: widget.searchResult,
              )
            : const Center(child: CircularProgressIndicator()),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              WakelockPlus.disable();
            });
            Navigator.pop(
              context,
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          label: Text(
            'BACK',
            style: TextStyle(
                color: isLoading
                    ? Colors.lightBlue
                    : const Color.fromRGBO(177, 158, 143, 1)),
          ),
        ),
      ),
    );
  }
}

class OnlineScroll extends StatefulWidget {
  final List<String> si;
  final bool b;
  final bool yt;
  final List text;
  const OnlineScroll({
    super.key,
    required this.b,
    required this.yt,
    required this.text,
    required this.si,
  });

  @override
  State<OnlineScroll> createState() => _OnlineScrollState();
}

class _OnlineScrollState extends State<OnlineScroll> {
  int count = 0;
  late List<dynamic> num = [];

  @override
  void initState() {
    super.initState();
    fres();
  }

  void fres() async {
    num = await Dat().songlisu(book, widget.si[0], context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
          expandedHeight: widget.yt ? 200.0 : null,
          collapsedHeight: widget.yt ? 200.0 : null,
          pinned: widget.yt ? true : false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: widget.yt
              ? YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: 'tbh4JEmC6uo',
                    flags: const YoutubePlayerFlags(
                      startAt: 50,
                      autoPlay: true,
                      mute: false,
                      disableDragSeek: false,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.blueAccent,
                )
              : AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Row(
                          children: num.map((number) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                number.toString(),
                                style: TextStyle(
                                  color: widget.b
                                      ? Colors.black
                                      : const Color.fromRGBO(177, 158, 143, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const Padding(padding: EdgeInsets.only(right: 10)),
                        Text(
                          widget.si[2].toUpperCase(),
                          style: TextStyle(
                            color: widget.b
                                ? Colors.black
                                : const Color.fromRGBO(177, 158, 143, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.text.length,
                  itemBuilder: (context, index) {
                    Map item = widget.text[index];
                    List keys = item.keys.toList();
                    if (index == 0) {
                      count = 0;
                    }
                    if (keys[0] != "పల్లవి" && keys[0] != "అనుపల్లవి") {
                      count++;
                    }
                    return ListTile(
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
                            flex: keys[0] == "పల్లవి" || keys[0] == "అనుపల్లవి"
                                ? 10
                                : 10,
                            child: Text(item[keys[0]])),
                      ],
                    ));
                  }),
            ),
          ]),
        ),
      ],
    );
  }
}
