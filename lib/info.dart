import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/i3.jpg"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(padding: EdgeInsets.only(top: 10)),
              IconButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  icon: const Icon(
                    Icons.home,
                    size: 40.0,
                    color: Colors.white,
                  )),
              const Column(
                children: [
                  Padding(padding: EdgeInsets.all(10)),
                  Text(
                    '"Dedicated to the"',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'f4',
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 15)),
                  Text(
                    '"Glory of GOD"',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'f4',
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Column(
                children: [
                  Text(
                    'Melodies',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      decoration: TextDecoration.none,
                      fontSize: 55.0,
                      fontFamily: 'f1',
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'of',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0, // shadow blur
                          color: Color.fromARGB(255, 0, 0, 0), // shadow color
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      decoration: TextDecoration.none,
                      fontSize: 50.0,
                      fontFamily: 'f1',
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'ZION',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0, // shadow blur
                          color: Color.fromARGB(255, 0, 0, 0), // shadow color
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      decoration: TextDecoration.none,
                      fontFamily: 'f1',
                      fontSize: 55.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
                child: Text(
                  'I will sing of the Lord\'s great love forever; with my mouth i will make your faithfulness known through all generation.\npsalm 89:1',
                  maxLines: null,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'f3',
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Divider(
                  height: 20,
                  thickness: 5,
                  color: Colors.white,
                ),
              ),
              const Column(
                children: [
                  Text(
                    "APP DEVELOPED BY:",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17.0,
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 8)),
                  Text(
                    "ZION HOUSE OF PRAYER ",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20.0,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'font1',
                    ),
                  ),
                  Text(
                    "DEVARAPALLI, EAST GODAVARI-534313",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 20.0,
                        decoration: TextDecoration.none,
                        fontFamily: 'font1',
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {
            Share.share(
                "https;//play.google.com/stote/appsdetails?id=com,instructivetech.testapp");
          },
          label: const Row(
            children: [
              Icon(
                Icons.share_outlined,
                color: Colors.white,
              ),
              Padding(padding: EdgeInsets.only(left: 8)),
              Text(
                'SHARE APP',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          )),
    );
  }
}
