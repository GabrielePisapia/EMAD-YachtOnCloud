import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:yachtoncloud/template.dart';
import 'colorsVideosorveglianza.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import 'theme/colors.dart';

class VlcVinfo extends StatefulWidget {
  const VlcVinfo({Key? key}) : super(key: key);

  @override
  _VideoInfoState createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VlcVinfo> {
  VlcPlayerController _controller = VlcPlayerController.network(
    "rtsp://rtsp.stream/pattern",
    hwAcc: HwAcc.FULL,
    autoPlay: true,
    options: VlcPlayerOptions(),
  );

  Future<void> initializePlayer() async {}
  @override
  void initState() {
    super.initState();
  }

  List videoList = [];
  late bool _isPlaying = false;

  bool _disposed = false;
  bool _playArea = false;
  int _isPlayingIndex = 1;
  String dataSource =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  //String dataSource = "http://213.226.254.135:91/mjpg/video.mjpg";
  //VideoPlayerController? _controller;

  @override
  void dispose() {
    _disposed = true;
    _controller.pause();
    _controller.dispose();

    super.dispose();
  }

  late String downloadURL;

  @override
  Widget build(BuildContext context) {
    return Template(
      appBarTitle: "Yacht on Cloud",
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              backgroundColor2,
              backgroundColor1,
            ],
            begin: const FractionalOffset(0.0, 2.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Container(
        decoration: _playArea == false
            ? BoxDecoration(
                gradient: LinearGradient(
                colors: [
                   backgroundColor2,
                  backgroundColor1,
                ],
                begin: const FractionalOffset(0.0, 0.4),
                end: Alignment.topRight,
              ))
            : BoxDecoration(color: AppColor.gradientSecond),
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
                                      color: Colors.black,
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
                            children: [
                             /* InkWell(
                                onTap: () {
                                  debugPrint("tapped");
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                  color: AppColor.secondPageTopIconColor,
                                ),
                              ),
                              Expanded(child: Container()),
                              Icon(
                                Icons.info_outline,
                                size: 20,
                                color: AppColor.secondPageTopIconColor,
                              )*/
                            ],
                          ),
                        ),
                        _playView(context),
                      ],
                    ),
                  ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                  ),
                ),
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
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(child: Container()),
                        Row(
                          children: [
                            Icon(Icons.settings, size: 30, color: Colors.black),
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

  Widget _playView(BuildContext context) {
    return VlcPlayer(
        controller: _controller,
        aspectRatio: 16 / 9,
        placeholder: const Center(child: CircularProgressIndicator()));
  }

  _buildCard(int index) {
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
                      image: AssetImage(
                          //videolist[index]["thumb_url"] nel caso di dati da db
                          'assets/azimut.jpg'),
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
                  Text(
                    "Videocamera ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ) //videoList[index]["title"]
                  ,
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      "Poppa",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ) //videoList[index]["time"]
                ],
              ),
            ],
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0XFFeaeefc),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "",
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
                              color: const Color(0XFF839fed),
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

  /*var _onUpdateControllerTime;
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
      if (_disposed) return;
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }
    _isPlaying = playing;
  }*/

  _initializeVideo(int index) async {
    final controller = VlcPlayerController.network(dataSource,
        hwAcc: HwAcc.FULL,
        autoPlay: false,
        options: VlcPlayerOptions()); //dataSource
  }

  _onTapVideo(int index) {
    //videoList[index]["urlVideo"]
    _initializeVideo(index);
  }

  _listView() {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        itemCount: 4, //videolist.length
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
}
