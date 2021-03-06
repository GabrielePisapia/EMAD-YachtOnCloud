import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:yachtoncloud/statovideocamere.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yachtoncloud/template.dart';
import 'colorsVideosorveglianza.dart';
import 'connettivita.dart';
import 'theme/colors.dart';
import 'package:intl/intl.dart';

class RealTimeVideo extends StatefulWidget {
  const RealTimeVideo({Key? key, required this.indice}) : super(key: key);

  @override
  RealTimeVideoState createState() => RealTimeVideoState();

  final int indice;
}

class RealTimeVideoState extends State<RealTimeVideo> {
  bool _folded = true;
  List videoList = [];
  late bool _isPlaying = false;
  bool _disposed = false;
  bool _playArea = false;
  int _isPlayingIndex = 1;
  var indic;
  /*String dataSource =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";*/
  /*String dataSource =
      "https://storage.googleapis.com/yachtm/Video%20Interni.mp4";*/
  VideoPlayerController? _controller;

  @override
  void dispose() {
    _disposed = true;
    _controller?.pause();

    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  void updateUi() {
    setState(() {});
  }

  late Future<DocumentSnapshot<Map<String, dynamic>>> dataFrom;

  initState() {
    dataFrom = getData();
    super.initState();
  }

  String dataSource = '';
  List videoListTemp = [];
  Future<DocumentSnapshot<Map<String, dynamic>>> getData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Utenti');
    FirebaseFirestore.instance
        .collection('Utenti')
        .doc(uid)
        .get()
        .then((querySnapshot) async {
      if (querySnapshot.data()!.containsKey("boxes")) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        indic = prefs.getInt('indice');
        //indic = widget.indice;
        print("INDEX ${indic}");
        //debugPrint("ok, non c'?? proprio il campo box " + uid);
        print(
            "mammt ${querySnapshot.data()!['boxes'][indic]['box']['videocamere']}");
        videoListTemp = querySnapshot.data()!['boxes'][indic]['box']['videocamere'];
        //videoList = querySnapshot.data()!['boxes'][0]['box']['videocamere'];

        videoList = [
          for (var e in videoListTemp)
            if (e['attivo']) e
        ];

        print("LISTA NUOVA ${videoList}");

        print("query mammt ${querySnapshot.data()}");
      }
    });
    return await FirebaseFirestore.instance.collection('Utenti').doc(uid).get();
    //debugPrint("inserisco la box " + uid);
  }
  /*
  Future<DocumentSnapshot<Map<String, dynamic>>> getData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Utenti');
    var snap =
        await FirebaseFirestore.instance.collection('Utenti').doc(uid).get();
    videoList = snap.data()!['videocamere'];
    print("mannag ${videoList}");
    return await snap;
  }*/

  @override
  Widget build(BuildContext context) {
    var res = true;
    return Template(
      appBarTitle: 'Yacht on Cloud',
      boxDecoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [backgroundColor2, backgroundColor1])
          //stops: [0.0, 1.0],
          //tileMode: TileMode.clamp),
          ),
      child: Container(
        decoration: _playArea == false
            ? BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [backgroundColor1, backgroundColor2]))
            : BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [backgroundColor2, backgroundColor1]),
              ),
        child: Column(
          children: [
            _playArea == false
                ? Container(
                    padding: const EdgeInsets.fromLTRB(30, 70, 30, 0),
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Center(
                          child: Text(
                              "Qui puoi visualizzare i filmati real time delle videocamere",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ],
                    ),
                  )
                : Container(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          padding: const EdgeInsets.only(
                              top: 50, left: 30, right: 30),
                          child: Row(
                            children: [],
                          ),
                        ),
                        _playView(context),
                        _controlView(context),
                      ],
                    ),
                  ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          cardsColor1,
                          cardsColor2,
                        ]),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: shadowCard.withOpacity(0.01),
                        spreadRadius: 5,
                        blurRadius: 3,
                        // changes position of shadow
                      ),
                    ]),
                /*decoration: BoxDecoration(
                  color: boxVideoColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                  ),
                ),*/
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Videocamere",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal)),
                        ),
                        Expanded(child: Container()),
                        Row(
                          children: [
                            InkWell(
                              child: Icon(Icons.settings,
                                  size: 30, color: Colors.white),
                              onTap: () async {
                                final value = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          StatusVideocamere()),
                                );
                                setState(() {
                                  res = value;
                                });
                                await _showMyDialog(res, 1);
                                /*Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => StatusVideocamere()));*/
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(child: _listView()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* Future getData(result) async {
      result.get().then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          videoList = data['videosUrl'];
          print("Sesso anale ${data['videosUrl']}");
          //Funziona ma sembra chiamarlo sempre  elagga
          //setState(() {});
        } else {
          print("niente sesso anale");
        }
      });
    }*/

  /*List<dynamic> videosList;
    FirebaseFirestore.instance
        .collection('Utenti')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      videosList = value.data()!["videosUrl"];
      videoList = videosList;

      print(videoList.length);
    });*/
  //getData(result);
  getWidgetCamera(bool res) {
    if (res) {
      return <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 7, bottom: 7),
            child: Text('Dati videocamere',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)))),
        Container(
            width: 200,
            height: 150,
            child: Lottie.asset('assets/success.json', fit: BoxFit.scaleDown)),
        Padding(
            padding: EdgeInsets.all(20),
            child: Text(
                'I dati delle videocamere sono stati modificati con successo!',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: textColor,
                        fontSize: 17,
                        fontWeight: FontWeight.normal)))),
        Center(
            child: Container(
          width: 200,
          height: 50,
          margin: EdgeInsets.symmetric(vertical: 1),
          child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(buttonColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: buttonColor)))),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                dataFrom = getData();
              });
              //Nel caso mettiamo solo pop se accadono cose strane
              /*Navigator.of(context)
                  .push(new MaterialPageRoute(
                      builder: (context) => RealTimeVideo()))
                  .then((value) => setState(() => {}));*/

              /*Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => RealTimeVideo()));*/
              //Navigator.pop(context, true);
            },
            child: Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Ok',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.normal)),
                ),
              ),
            ),
          ),
        ))
      ];
    } else {
      return <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 7, bottom: 7),
            child: Text('Dati videocamere',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)))),
        Container(
            width: 200,
            height: 150,
            child: Lottie.asset('assets/fail.json', fit: BoxFit.scaleDown)),
        Padding(
            padding: EdgeInsets.all(20),
            child: Text('Modifica ai dati delle videocamere fallita, riprova.',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: textColor,
                        fontSize: 17,
                        fontWeight: FontWeight.normal)))),
        Center(
            child: Container(
          width: 200,
          height: 50,
          margin: EdgeInsets.symmetric(vertical: 1),
          child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(buttonColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: buttonColor)))),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Ok',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.normal)),
                ),
              ),
            ),
          ),
        ))
      ];
    }
  }

  Future<void> _showMyDialog(bool res, int c) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [dialogColor1, dialogColor2],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: shadowCard.withOpacity(0.01),
                    spreadRadius: 5,
                    blurRadius: 3,
                  ),
                ]),
            child: SingleChildScrollView(
                child: ListBody(
              children: getWidget(c, res),
            )),
          ),
          contentPadding: EdgeInsets.all(0.0),
        );
      },
    );
  }

  List<Widget> getWidget(int c, bool res) {
    switch (c) {
      case 1:
        return getWidgetCamera(res);
      default:
        return [Center()];
    }
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VisibilityDetector(
            key: Key("key"),
            onVisibilityChanged: (info) {
              if (info.visibleFraction == 0) {
                debugPrint("${info.visibleFraction} my widget is not visible");
                controller.pause();
                debugPrint("Value of ${controller}");
              }
            },
            child: VideoPlayer(controller)),
      );
    } else {
      return AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
              child: Text("Preparing...",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.normal)))));
    }
  }

  _buildCard(int index) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return Container(
      height: 135,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          //videolist[index]["thumb_url"] nel caso di dati da db
                          videoList[index]['img']),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(videoList[index]['nomeCamera'].toString(),
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: textColor,
                              fontSize: 17,
                              fontWeight: FontWeight
                                  .normal))) //videoList[index]["title"]
                  ,
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(DateFormat('dd-MM-yyyy').format(date),
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: textColor,
                                fontSize: 13,
                                fontWeight: FontWeight.normal))),
                  ) //videoList[index]["time"]
                ],
              ),
            ],
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Container(
                width: 100,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0XFFeaeefc),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    videoList[index]['posizione'].toString(),
                    style: TextStyle(color: Color(0XFF839fed)),
                  ),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 70; i++)
                    i.isEven
                        ? Container(
                            width: 3,
                            height: 1,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          )
                        : Container(
                            width: 3,
                            height: 1,
                            color: Colors.white,
                          )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  var _onUpdateControllerTime;
  Duration? _duration;
  Duration? _position;
  var _progress = 0.0;
  void _onControllerUpdate() async {
    if (_disposed) {
      return;
    }

    _onUpdateControllerTime = 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_onUpdateControllerTime > now) {
      return;
    }
    _onUpdateControllerTime = now + 500;

    final controller = _controller;
    if (controller == null) {
      debugPrint("controller merda");
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint("controller can not be initialized");
      return;
    }
    if (_duration == null) {
      _duration = _controller?.value.duration;
    }

    var duration = _duration;
    if (duration == null) return;

    var position = await controller.position;
    _position = position;
    final playing = controller.value.isPlaying;
    if (playing) {
      debugPrint("Sono nel playing");
      if (_disposed) return;
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }
    _isPlaying = playing;
  }

  _initializeVideo(int index) async {
    var value = videoList[index];
    final controller = VideoPlayerController.network(value['videoUrl']);
    final old = _controller;
    _controller = controller;
    if (old != null) {
      debugPrint("Sono all'interno dell'old");
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller
      ..initialize().then((_) {
        debugPrint("Si");
        old?.dispose();
        _isPlayingIndex = index;
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
  }

  _onTapVideo(int index) {
    //videoList[index]["urlVideo"]
    print(videoList[1]);
    var val = videoList[1];
    print(val['videoUrl']);
    _initializeVideo(index);
  }

  _listView() {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: dataFrom, //getData(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: appBarColor1),
            );
          } else if (snap.hasData) {
            debugPrint("Non devo pi?? aspettare ${videoList}");

            return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                itemCount: videoList.length, //videolist.length
                itemBuilder: (_, int index) {
                  return GestureDetector(
                    onTap: () {
                      _onTapVideo(index);
                      debugPrint(index.toString());

                      setState(() {
                        if (_playArea == false) {
                          _playArea = true;
                        }
                      });
                    },
                    child: _buildCard(index),
                  );
                });
          }
          return Center(
              child: Text("${snap.error}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))));
        });
  }

  Widget _controlView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 5),
          //color: AppColor.gradientSecond,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Clicca per uscire",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.normal))),
              TextButton(
                onPressed: () {
                  setState(() {
                    _playArea = false;
                  });
                },
                child: Image.asset(
                  'assets/undo.png',
                  height: 25,
                  width: 25,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
