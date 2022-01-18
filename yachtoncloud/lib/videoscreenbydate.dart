import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:yachtoncloud/template.dart';
import 'colorsVideosorveglianza.dart';
import 'theme/colors.dart';

class VideoInfoBySearch extends StatefulWidget {
  const VideoInfoBySearch({Key? key}) : super(key: key);

  @override
  _VideoInfoBySearchState createState() => _VideoInfoBySearchState();
}

class _VideoInfoBySearchState extends State<VideoInfoBySearch> {
  bool _folded = true;
  List videoList = [];
  late bool _isPlaying = false;
  bool _disposed = false;
  bool _playArea = false;
  int _isPlayingIndex = 1;
  String dataSource =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  VideoPlayerController? _controller;

  @override
  void dispose() {
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  colors: [backgroundColor1, backgroundColor2]
              ))
            :  BoxDecoration(
         gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [backgroundColor2, backgroundColor1]
              ),
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
                          height: 30,
                        ),
                        Center(
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            width: _folded ? 56 : 200,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: fieldTextColor,
                              boxShadow: kElevationToShadow[6],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 16),
                                    child: !_folded
                                        ? TextField(
                                            decoration: InputDecoration(
                                                hintText: 'Digita una data ',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none),
                                          )
                                        : null,
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: InkWell(
                                      borderRadius: BorderRadius.only(
                                        topLeft:
                                            Radius.circular(_folded ? 32 : 0),
                                        topRight: const Radius.circular(32),
                                        bottomLeft:
                                            Radius.circular(_folded ? 32 : 0),
                                        bottomRight: const Radius.circular(32),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Icon(
                                          _folded
                                              ? Icons.search_outlined
                                              : Icons.close,
                                          color: Colors.black,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _folded = !_folded;
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
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
                  color: boxVideoColor,
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
                          "Video più recenti",
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
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
              child: Text(
            "Preparing...",
            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: textColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal))
          )));
    }
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
                    "Video",
                    style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: textColorDashboard,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold))
                  ) //videoList[index]["title"]
                  ,
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      "Data: 20/01/2022",
                      style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal))
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
      if (_disposed) return;
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }
    _isPlaying = playing;
  }

  _initializeVideo(int index) async {
    final controller = VideoPlayerController.network(dataSource);
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller
      ..initialize().then((_) {
        old?.dispose();
        _isPlayingIndex = index;
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
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

  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  Widget _controlView(BuildContext context) {
    final noMute = (_controller?.value.volume ?? 0) > 0;
    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = convertTwo(remained ~/ 60.0);
    final secs = convertTwo(remained % 60);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: activeTrackColor,
              inactiveTrackColor: inactiveTrackColor,
              trackShape: RoundedRectSliderTrackShape(),
              trackHeight: 2.0,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
              thumbColor: thumbColor,
              overlayColor: Colors.red.withAlpha(32),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 28),
              tickMarkShape: RoundSliderTickMarkShape(),
              activeTickMarkColor: activeTickColor,
              inactiveTickMarkColor: inactiveTickColor,
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: indicatorColor,
              valueIndicatorTextStyle: const TextStyle(color: textColor),
            ),
            child: Slider(
              value: max(0, min(_progress * 100, 100)),
              min: 0,
              max: 100,
              divisions: 100,
              label: _position?.toString().split(".")[0],
              onChanged: (value) {
                setState(() {
                  _progress = value * 0.01;
                });
              },
              onChangeStart: (value) {
                _controller?.pause();
              },
              onChangeEnd: (value) {
                final duration = _controller?.value.duration;
                if (duration != null) {
                  var newValue = max(0, min(value, 99)) * 0.01;
                  var millis = (duration.inMilliseconds * newValue).toInt();
                  _controller?.seekTo(Duration(milliseconds: millis));
                  _controller?.play();
                }
              },
            )),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 5),
          //color: AppColor.gradientSecond,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Icon(
                      noMute
                          ? Icons.volume_up_outlined
                          : Icons.volume_off_outlined,
                      size: 30,
                      color: videoIconsColor,
                    ),
                  ),
                ),
                onTap: () {
                  if (noMute) {
                    _controller?.setVolume(0);
                  } else {
                    _controller?.setVolume(1.0);
                  }
                  setState(() {});
                },
              ),
              TextButton(
                  onPressed: () async {
                    final index = _isPlayingIndex - 1;
                    if (index >= 0) //&&videoList.length>=0
                    {
                      _initializeVideo(index);
                    } else {
                      Get.snackbar(
                        "Video",
                        "",
                        snackPosition: SnackPosition.BOTTOM,
                        icon: Icon(
                          Icons.face,
                          size: 30,
                          color: videoIconsColor,
                        ),
                        //backgroundColor: AppColor.gradientSecond,
                        colorText: textColor,
                        messageText: Text(
                          "No more video to play",
                          style: TextStyle(fontSize: 20, color: textColor),
                        ),
                      );
                    }
                  },
                  child: Icon(
                    Icons.fast_rewind_outlined,
                    size: 30,
                    color: videoIconsColor,
                  )),
              TextButton(
                  onPressed: () async {
                    if (_isPlaying) {
                      setState(() {
                        _isPlaying = false;
                      });
                      _controller?.pause();
                    } else {
                      setState(() {
                        _isPlaying = true;
                      });
                      _controller?.play();
                    }
                  },
                  child: Icon(
                    _isPlaying
                        ? Icons.pause_circle_filled_outlined
                        : Icons.play_arrow_outlined,
                    size: 30,
                    color: videoIconsColor,
                  )),
              TextButton(
                  onPressed: () async {
                    final index = _isPlayingIndex + 1;
                    //videolist.length-1
                    if (index <= 3) {
                      _initializeVideo(index);
                    } else {
                      Get.snackbar(
                        "Video",
                        "",
                        snackPosition: SnackPosition.BOTTOM,
                        icon: Icon(
                          Icons.face,
                          size: 30,
                          color: videoIconsColor,
                        ),
                        //backgroundColor: AppColor.gradientSecond,
                        colorText: textColor,
                        messageText: Text(
                          "No more videos in the list",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: textColor,
                                  fontSize: 1,
                                  fontWeight: FontWeight.bold))
                        ),
                      );
                    }
                  },
                  child: Icon(
                    Icons.fast_forward_outlined,
                    size: 30,
                    color: Colors.white,
                  )),
              Text(
                "$mins:$secs",
                style: TextStyle(color: textColor, shadows: [
                  Shadow(
                    offset: Offset(0.0, 1.0),
                    blurRadius: 4.0,
                    color: Color.fromARGB(150, 0, 0, 0),
                  )
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
