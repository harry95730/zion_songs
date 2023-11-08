// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:share_plus/share_plus.dart';
import 'package:songs_app/classoffunc/classes.dart';
import 'package:songs_app/info.dart';
import 'package:songs_app/offlinesongs/favsongs.dart';
import 'package:songs_app/offlinesongs/ohome.dart';
import 'package:songs_app/offlinesongs/psearch.dart';
import 'package:songs_app/offlinesongs/qtelugu.dart';
import 'package:songs_app/offlinesongs/rgenre.dart';
import 'package:songs_app/offlinesongs/song.dart';
import 'package:songs_app/onlinestart.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Future<void> functi() async {
    songhis1.sort((a, b) => b[0].compareTo(a[0]));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      functi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: const Text('HISTORY OF SONGS',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          actions: [
            FloatingActionButton(
                onPressed: () async {
                  final box = await Hive.openBox('songDataBox');
                  var myData1 = box.get('historyoftheapp');
                  if (myData1 != null) {
                    myData1.clear();
                    await box.put('historyoftheapp', myData1);
                    await box.close();
                    songhis1.clear();
                    setState(() {});
                  }
                },
                child: const Column(
                  children: [
                    Expanded(
                        flex: 7,
                        child: Icon(Icons.cancel_presentation_rounded)),
                    Expanded(
                        flex: 3,
                        child: Center(
                            child: Text(
                          'Clear history',
                          style: TextStyle(fontSize: 7),
                        )))
                  ],
                ))
          ],
        ),
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return Decorate().butto2(context);
          },
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.pinkAccent,
                ])),
                accountName: Text('ZION SONGS'),
                accountEmail: SelectableText(
                  'zionhouseofprayer497@gmail.com',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/s.png'),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.tealAccent,
                ),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HebronPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite, color: Colors.pinkAccent),
                title: const Text(
                  'Favourites',
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Fav()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.search,
                  color: Colors.deepOrange,
                ),
                title: const Text('Search'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage1(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.switch_access_shortcut,
                  color: Colors.pinkAccent,
                ),
                title: const Text('Alphabetical Order'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TeluguIndex(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.lyrics_outlined,
                  color: Colors.deepPurpleAccent.shade100,
                ),
                title: const Text('Category'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExpandableList(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.online_prediction),
                title: const Text('Search Online'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Onlinepage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.not_listed_location_outlined,
                    color: Colors.deepPurple.shade300),
                title: const Text('App Info'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SecondPage()));
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.share_outlined, color: Colors.blueAccent),
                title: const Text('Share App'),
                onTap: () {
                  Share.share(
                      "https;//play.google.com/stote/appsdetails?id=com,instructivetech.testapp");
                },
              ),
            ],
          ),
        ),
        body: songhis1.isNotEmpty
            ? ListView.builder(
                itemCount: songhis1.length,
                itemBuilder: (context, index) {
                  final Map son = songhis1[index][1];

                  DateTime dateTime =
                      DateTime.parse(songhis1[index][0].toString());

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () async {
                          book1 = son['book'];
                          await Decorate().fetchDataFromJsonFile();
                          int num = son['number'];
                          ha = songs[num];
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HebronSong(),
                            ),
                          );
                          setState(() {});
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 2),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              son['title'].toString(),
                              maxLines: 1,
                            ),
                            trailing: Text(
                                "${dateTime.hour}:${dateTime.minute}:${dateTime.second}  ${dateTime.day}/${dateTime.month}"),
                          ),
                        )),
                  );
                },
              )
            : const Center(child: Text('No data')));
  }
}
