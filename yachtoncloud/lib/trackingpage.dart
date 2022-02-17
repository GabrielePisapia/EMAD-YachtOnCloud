import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:flutter_map/flutter_map.dart' as Marker;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yachtoncloud/SetAlert.dart';
import 'package:yachtoncloud/template.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:yachtoncloud/theme/colors.dart';
import 'navigation_provider.dart';

void main() {
  runApp(const TrackingPage());
}

class TrackingPage extends StatelessWidget {
  const TrackingPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => NavigationProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: const TrackingPage_(),
        ),
      );
}

class TrackingPage_ extends StatefulWidget {
  const TrackingPage_({Key? key}) : super(key: key);

  @override
  State<TrackingPage_> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TrackingPage_> {
  late LatLng currentPos;
  late LatLng visionPos;
  late LatLng lat, long;
  var stato = true;
  late Timer timer;
  bool res = true;
  var circleMarkers;
  var indic;

  @override
  void initState() {
    super.initState();
    //timer = Timer.periodic(Duration(seconds: 20), (Timer t) { getLatLong(); this.setState(() {

    // });});
  }

  @override
  /*void dispose() {
    timer.cancel();
    super.dispose();
  }*/

  Future<DocumentSnapshot<Map<String, dynamic>>> getLatLong() async {
    debugPrint("Ma almeno ci arrivo qua?");
    final uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Utenti');
    var snap =
        await FirebaseFirestore.instance.collection('Utenti').doc(uid).get();
    //ECCO IL TUO INDICE
    SharedPreferences prefs = await SharedPreferences.getInstance();
    indic = prefs.getInt('indice');
    print("INDEX tracking ${indic}");
    currentPos = LatLng(
        snap.data()!['boxes'][indic]['box']['gps']['currentPosition']['lat'],
        snap.data()!['boxes'][indic]['box']['gps']['currentPosition']['long']);
    var migliaAlert = snap.data()!['boxes'][indic]['box']['gps']['migliaAlert'];

    stato = snap.data()!['boxes'][indic]['box']['gps']['attivo'];
    var migliaMetri = (migliaAlert * 1.60934) * 1000;
     debugPrint("alert " +migliaAlert.toString());
    debugPrint("metri " +migliaMetri.toString());
    circleMarkers = <CircleMarker>[
      CircleMarker(
        point: LatLng(currentPos.latitude, currentPos.longitude),
        color: appBarColor1.withOpacity(0.15),
        borderStrokeWidth: 2,
        useRadiusInMeter: true,
        radius: migliaMetri, // 2000 meters | 2 km,
        borderColor: appBarColor2,       
      ),
    ];

    visionPos = currentPos;
    debugPrint(currentPos.toString());
    return await snap;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    TileLayerOptions openStreetMap = TileLayerOptions(
      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
      subdomains: ['a', 'b', 'c'],
      attributionBuilder: (_) {
        return Text("© OpenSeaMap and OpenStreetMap");
      },
    );

    TileLayerOptions openSeaMarks = TileLayerOptions(
        urlTemplate: "http://tiles.openseamap.org/seamark/{z}/{x}/{y}.png",
        backgroundColor: Colors.transparent);

    getWidget(bool res) {
      debugPrint("getwidget " + res.toString());
      if (res) {
        return <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 7, bottom: 7),
              child: Text('Impostazione notifica',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)))),
          Container(
              width: 200,
              height: 150,
              child:
                  Lottie.asset('assets/success.json', fit: BoxFit.scaleDown)),
          Padding(
              padding: EdgeInsets.all(20),
              child: Text('Notifica impostata con successo!',
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
                Navigator.of(context).maybePop();
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
              child: Text('Impostazione notifica',
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
              child: Text('Impostazione della notifica fallita, riprova.',
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
                Navigator.of(context).maybePop();
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

    Future<void> _showMyDialog(bool res) async {
      return showDialog<void>(
        useRootNavigator: false,
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
                children: getWidget(res),
              )),
            ),
            contentPadding: EdgeInsets.all(0.0),
          );
        },
      );
    }

    return Template(
      appBarTitle: "Yacht on Cloud",
      child: new Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned(
              child: Container(
            decoration: BoxDecoration(
                color: cardsColor1,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: shadowCard.withOpacity(0.01),
                    spreadRadius: 10,
                    blurRadius: 3,
                    // changes position of shadow
                  ),
                ]),
            width: double.infinity,
            height: double.infinity,
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: getLatLong(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: appBarColor1),
                    );
                  } else if (snap.hasData) {
                    debugPrint("Non devo più aspettare");
                    return FlutterMap(
                      options: MapOptions(
                        center: visionPos,
                        zoom: 16,
                      ),
                      layers: [
                        //openSeaMarks,
                        openStreetMap,
                        openSeaMarks,
                        stato ? CircleLayerOptions(circles: circleMarkers) : CircleLayerOptions(circles: []),
                        MarkerLayerOptions(
                          markers: [
                            Marker.Marker(
                              width: 25.0,
                              height: 25.0,
                              point: currentPos,
                              builder: (ctx) => Container(
                                child: Image.asset(
                                  'assets/yacht.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Center(
                        child: Text("${snap.error}",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: textColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))));
                  }
                }),
          )),
          // ),
          //),
          Positioned(
              top: size.height - 100,
              child: Center(
                  child: Container(
                width: 250,
                height: 50,
                margin: EdgeInsets.symmetric(vertical: 1),
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(buttonColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(color: buttonColor)))),
                  onPressed: () async {
                    final value = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SetAlertPage_(title: "peppe")),
                    );
                    setState(() {
                      res = value;
                      debugPrint("help " + res.toString());
                    });
                    debugPrint("MA CHE SUCCEDE SCUSA");
                    await _showMyDialog(res);
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Imposta notifica',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: textColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))),
        ],
      ),
      //),
      boxDecoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0XFF6dd5ed),
              Color(0XFF2193b0),
            ],
            begin: FractionalOffset(0.0, 2.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
