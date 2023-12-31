import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/offlinesongs/hivdb.dart';
import 'psearch.dart';
import 'ohome.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:convert';

class HebronSong extends StatefulWidget {
  const HebronSong({
    super.key,
  });

  @override
  State<HebronSong> createState() => _HebronSongState();
}

class _HebronSongState extends State<HebronSong> {
  bool kr = false;
  bool yt = false;
  SongData newone = SongData(link: '', start: 0, like: false);

  @override
  void dispose() {
    super.dispose();
    payload = null;
  }

  Future<void> gtlik() async {
    await fetchJsonFromGoogleDrive();
    setState(() {
      kr = true;
    });
  }

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();

    setState(() {
      newone = dataoflike[book1][ha.number - 1];
      yt = false;
      kr = true;
      updatehistory(ha);
    });
  }

  Map? payload;

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;
    if (data != null) {
      if (data is RemoteMessage) {
        payload = data.data;
        if (payload!.isNotEmpty) {
          int intValue = int.parse(payload!['number']) - 1;
          ha = songs[intValue];
          newone = dataoflike[book1][ha.number - 1];
          if (newone.link.isNotEmpty) {
            yt = true;
          }
        } else {
          ha = songs[0];
        }
      }
      if (data is NotificationResponse) {
        payload = jsonDecode(data.payload!);
        if (payload!.isNotEmpty) {
          int intValue = int.parse(payload!['number']) - 1;
          ha = songs[intValue];
          newone = dataoflike[book1][ha.number - 1];
          if (newone.link.isNotEmpty) {
            yt = true;
          }
        } else {
          ha = songs[0];
        }
      }
    }
    return kr
        ? Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: const Color.fromARGB(252, 0, 0, 0),
                onPressed: () {
                  if (ha.number > 1 && kr) {
                    ha = songs[ha.number - 2];
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HebronSong(),
                      ),
                    );
                  }
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  color: const Color.fromARGB(252, 0, 0, 0),
                  onPressed: () {
                    if (ha.number < songs.length && kr) {
                      ha = songs[ha.number];
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HebronSong(),
                        ),
                      );
                    }
                  },
                ),
              ],
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
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HebronPage()),
                        (Route<dynamic> route) => false,
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
                          builder: (context) => const MyHomePage1(),
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
                          isLoading = false;
                        } else {
                          isLoading = true;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  kr = false;
                });
                gtlik();
              },
              child: Scaffold(
                backgroundColor: isLoading ? Colors.white : Colors.black,
                appBar: AppBar(
                  title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          ha.number.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0)),
                        Text(
                          ha.text.toString(),
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
                      onPressed: () async {
                        await updatedatafromBox(newone, ha.number - 1, true);
                        setState(() {});
                      },
                      icon: Icon(Icons.favorite,
                          color: newone.like ? Colors.pink : Colors.grey),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (newone.link != "") {
                          setState(() {
                            yt = !yt;
                          });
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("NO SONG\nPULL DOWN TO REFRESH"),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      icon: Icon(yt ? Icons.stop_circle : Icons.play_circle,
                          color: newone.link.isEmpty
                              ? Colors.grey
                              : yt
                                  ? Colors.red
                                  : Colors.green),
                    ),
                    IconButton(
                        onPressed: () {
                          Decorate().fre(ha.song);
                        },
                        icon: const Icon(Icons.share, color: Colors.black)),
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
                body: HebronScrollableTextContainer(
                  text: ha.song,
                  yt: yt,
                  sang: ha,
                  link: newone.link,
                  start: newone.start,
                ),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    setState(() {
                      WakelockPlus.disable();
                    });
                    if (payload != null) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HebronPage()),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      Navigator.pop(
                        context,
                      );
                    }
                  },
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  label: Text(
                    'BACK',
                    style: TextStyle(
                      color: isLoading
                          ? const Color.fromRGBO(177, 158, 143, 1)
                          : Colors.lightBlue,
                    ),
                  ),
                ),
              ),
            ),
          )
        : const Center(
            heightFactor: BorderSide.strokeAlignCenter,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
  }
}

class HebronScrollableTextContainer extends StatefulWidget {
  final Song sang;
  final String link;
  final Map<String, dynamic> text;
  final bool yt;
  final int start;
  const HebronScrollableTextContainer(
      {super.key,
      required this.text,
      required this.yt,
      required this.sang,
      required this.link,
      required this.start});

  @override
  State<HebronScrollableTextContainer> createState() =>
      _HebronScrollableTextContainerState();
}

class _HebronScrollableTextContainerState
    extends State<HebronScrollableTextContainer> {
  final TransformationController _transformationController =
      TransformationController();
  final double _baseFontSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: _transformationController,
      onInteractionEnd: (details) {
        setState(() {
          _transformationController.value = Matrix4.identity();
        });
      },
      child: CustomScrollView(
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
                      initialVideoId: widget.link,
                      flags: YoutubePlayerFlags(
                        startAt: widget.start,
                        autoPlay: true,
                        mute: false,
                        disableDragSeek: false,
                        showLiveFullscreenButton: true,
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
                            children: ha.oldnum.map((number) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  number.toString(),
                                  style: TextStyle(
                                    color: isLoading
                                        ? Colors.black
                                        : const Color.fromRGBO(
                                            177, 158, 143, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 10)),
                          Text(
                            ha.etext.toString(),
                            style: TextStyle(
                              color: isLoading
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
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: widget.text.length,
                    itemBuilder: (BuildContext context, int index) {
                      final entry = widget.text.entries.elementAt(index);
                      final isEven = index % 2 == 0;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: entry.key == 'పల్లవి:' ||
                                      entry.key == 'అ||ప||:'
                                  ? 2
                                  : 1,
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    entry.key[0] == 'a' ? '' : entry.key,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: isLoading
                                          ? isEven
                                              ? const Color.fromARGB(
                                                  196, 25, 18, 90)
                                              : Colors.black
                                          : isEven
                                              ? const Color.fromRGBO(
                                                  177, 158, 143, 1)
                                              : const Color.fromRGBO(
                                                  102, 255, 255, 0.9),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: SelectableText(
                                entry.value.toString(),
                                style: TextStyle(
                                  fontSize: _baseFontSize *
                                      _transformationController.value
                                          .getMaxScaleOnAxis(),
                                  fontWeight: FontWeight.bold,
                                  color: isLoading
                                      ? isEven
                                          ? const Color.fromARGB(
                                              196, 25, 18, 90)
                                          : Colors.black
                                      : isEven
                                          ? const Color.fromRGBO(
                                              102, 255, 255, 0.9)
                                          : const Color.fromRGBO(
                                              177, 158, 143, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
            ]),
          ),
        ],
      ),
    );
  }
}
