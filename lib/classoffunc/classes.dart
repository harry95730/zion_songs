import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:share_plus/share_plus.dart';
import 'package:songs_app/offlinesongs/hivdb.dart';
import 'package:songs_app/onlinesongs/onhome.dart';
import 'package:http/http.dart' as http;

bool isLoading = false;
int globalVariable = 0;
String book1 = 'ZION_SONGS';
String book = '';
List<Map> sondat = [];
List<Map> songhis = [];
List<List<dynamic>> songhis1 = [];
List<List<String>> abgt = [];
List<Song> songs = [];
Map<String, dynamic> dataoflink = {};
Map<String, dynamic> dataoflike = {};
Song ha = Song(number: 1, text: '', etext: '', oldnum: [], genre: '', song: {});

class Song {
  final int number;
  final String text;
  final String etext;
  final List<dynamic> oldnum;
  final String genre;
  final Map<String, dynamic> song;
  Song({
    required this.number,
    required this.text,
    required this.etext,
    required this.oldnum,
    required this.genre,
    required this.song,
  });
  factory Song.fromMap(Map<String, dynamic> e) {
    return Song(
      number: e['number'],
      etext: e['etext'],
      oldnum: e['oldnum'],
      genre: e['genre'],
      song: e['song'],
      text: e['text'],
    );
  }
}

Future<void> fetchJsonFromGoogleDrive() async {
  const url =
      'https://drive.google.com/uc?id=1pStQY3l45g3CA9K4sXE55t_saeusFfHe';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    dataoflink = jsonData["songs"] as Map<String, dynamic>;
    final box = await Hive.openBox('songDataBox');
    var myData = box.get('songs');
    if (myData == null) {
      List<SongData> toadd = [];
      List<SongData> toadd1 = [];
      for (int i = 0; i < 867; i++) {
        if (i < 165) {
          toadd.add(SongData(link: '', start: 0, like: false));
        }
        toadd1.add(SongData(link: '', start: 0, like: false));
      }
      final data = {"ZION_SONGS": toadd, "HEBRON_SONGS": toadd1};
      await box.put('songs', data);
    }
    Map<String, dynamic> addingtothe = {};
    for (var i in dataoflink.keys) {
      Map<String, dynamic> ech = dataoflink[i];
      List<SongData> ad = [];
      for (var k in ech.keys) {
        int numb = int.parse(k);

        Map<String, dynamic> each1 = ech[k];
        SongData oko = myData[i][numb - 1];
        oko.link = each1["link"].toString();
        oko.start = each1["start"];
        ad.add(oko);
      }
      addingtothe[i] = ad;
      dataoflike[i] = ad;
    }
    await box.put('songs', addingtothe);
    fetchdatafromBox();
    await box.close();
  } else {
    throw Exception('Failed to load JSON file');
  }
}

Future<void> fetchdatafromBox() async {
  final box = await Hive.openBox('songDataBox');
  var myData = box.get('songs');
  List<SongData> toadd = [];
  List<SongData> toadd1 = [];
  if (myData == null) {
    for (int i = 0; i < 867; i++) {
      if (i < 165) {
        toadd.add(SongData(link: '', start: 0, like: false));
      }
      toadd1.add(SongData(link: '', start: 0, like: false));
    }
    final data = {"ZION_SONGS": toadd, "HEBRON_SONGS": toadd1};
    await box.put('songs', data);
    dataoflike = {'ZION_SONGS': toadd, 'HEBRON_SONGS': toadd1};
  } else {
    dataoflike = {
      'ZION_SONGS': myData['ZION_SONGS'],
      'HEBRON_SONGS': myData['HEBRON_SONGS']
    };
  }

  var myData1 = box.get('songoftheday');
  if (myData1 != null) {
    sondat.clear();
    for (var i in myData1.keys) {
      sondat.add({i: myData1[i]});
    }
  }
  var myData2 = box.get('historyoftheapp');
  if (myData2 != null) {
    for (var i in myData2.keys) {
      DateTime dateTime = DateTime.parse(i.toString());
      songhis1.add([dateTime, myData2[i]]);
    }
  }
  await box.close();
}

Future<void> updatedatafromBox(SongData harry, int index, bool torf) async {
  final box = await Hive.openBox('songDataBox');
  var myData = box.get('songs');
  if (myData != null) {
    List<dynamic> zionSongsData = myData['ZION_SONGS'];
    List<dynamic> hebronSongsData = myData['HEBRON_SONGS'];
    if (book1 == 'ZION_SONGS') {
      if (torf) {
        zionSongsData[index].like = !zionSongsData[index].like;
      } else {
        zionSongsData[index].link = harry.link;
        zionSongsData[index].start = harry.start;
      }
    } else {
      if (torf) {
        hebronSongsData[index].like = !hebronSongsData[index].like;
      } else {
        hebronSongsData[index].link = harry.link;
        hebronSongsData[index].start = harry.start;
      }
    }
    final data = {"ZION_SONGS": zionSongsData, "HEBRON_SONGS": hebronSongsData};
    await box.put('songs', data);
    dataoflike = {'ZION_SONGS': zionSongsData, 'HEBRON_SONGS': hebronSongsData};
  }
  await box.close();
}

Future<void> updatehistory(Song ab) async {
  final box = await Hive.openBox('songDataBox');
  var myData = box.get('historyoftheapp');

  DateTime now = DateTime.now();
  int number = ab.number - 1;
  String? notificationText = ab.text.isNotEmpty ? ab.text : ab.etext;
  Map<String, dynamic> dat = {
    'book': book1,
    'number': number,
    'title': notificationText
  };
  myData ??= {};
  myData[now] = dat;
  songhis1.add([now, dat]);
  await box.put('historyoftheapp', myData);
}

class Decorate {
  Widget botto(BuildContext context, Widget page1, Widget page2, IconData ic1,
      IconData ic2, String a1, String a2) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      elevation: 2,
      unselectedLabelStyle: const TextStyle(color: Colors.white),
      unselectedItemColor: const Color.fromRGBO(251, 250, 250, 1),
      currentIndex: 1,
      showSelectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            ic1,
            color: const Color.fromRGBO(177, 158, 143, 1),
          ),
          label: a1,
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Color.fromRGBO(177, 158, 143, 1),
          ),
          label: 'abc',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            ic2,
            color: const Color.fromRGBO(177, 158, 143, 1),
          ),
          label: a2,
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => page1,
            ),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Onlinehome(),
            ),
          );
        } else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => page2,
            ),
          );
        }
      },
    );
  }

  Widget butto(Widget page, String matter, double num, String fam,
      BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          gradient: Decorate().eachtile(),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            matter,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: num,
                fontFamily: fam,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget butto1(
      Widget page, String matter, IconData iconData, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          gradient: Decorate().eachtile(),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Icon(
                iconData,
                color: Colors.black,
                size: 40,
              ),
              Text(
                matter,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontFamily: 'f1',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget butto2(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: Decorate().eachtile(),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        height: 40,
        width: 40,
        child: InkWell(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: const Icon(Icons.menu, color: Colors.black),
        ),
      ),
    );
  }

  Future<void> fetchDataFromJsonFile() async {
    try {
      String jsonString = await rootBundle.loadString('assets/son.json');
      final data = jsonDecode(jsonString);
      final son = data[book1] as List<dynamic>;
      songs = son.map((e) {
        return Song.fromMap(e);
      }).toList();
    } catch (error) {
      //
      AlertDialog(
        title: const Text('Error'),
        content: Text('An error occurred: $error'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.error_outline),
          ),
        ],
      );
    }
  }

  BoxDecoration completetile() {
    return BoxDecoration(
      gradient: Decorate().eachtile(),
      border: Border.all(
        color: const Color.fromARGB(255, 10, 19, 37),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(20),
    );
  }

  LinearGradient eachtile() {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(255, 255, 255, 255),
        Color.fromARGB(255, 255, 255, 255),
        Color.fromRGBO(177, 158, 143, 1),
      ],
    );
  }

  Icon x(String p) {
    return const Icon(
      Icons.lyrics_outlined,
      color: Colors.white,
      size: 40,
    );
  }

  TextStyle trext(double s, String x) {
    return TextStyle(
        decoration: TextDecoration.none,
        fontFamily: x,
        fontSize: s,
        color: const Color.fromARGB(255, 255, 255, 255),
        fontWeight: FontWeight.bold);
  }

  InputDecoration searc(String p) {
    return InputDecoration(
      prefixIcon: const Icon(Icons.search),
      labelText: p,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
    );
  }

  InputDecoration searc1(String p, String r) {
    return InputDecoration(
      prefix: Text('$r. '),
      labelText: p,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
    );
  }

  BoxDecoration f() {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 48, 237, 240),
        ],
      ),
      border: Border.all(
        color: const Color.fromARGB(255, 10, 19, 37),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(20),
    );
  }

  BoxDecoration inh() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 48, 237, 240),
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 255, 255, 255),
        ],
      ),
    );
  }

  void fre(Map<String, dynamic> song) {
    String po = "";
    song.forEach((key, value) {
      if (key[0] == 'a') {
        po += ' $value\n\n';
      } else {
        po += '$key $value\n\n';
      }
    });
    Share.share(po);
  }
}
