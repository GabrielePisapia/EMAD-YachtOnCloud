// ignore_for_file: prefer_const_literals_to_create_immutables

//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yachtoncloud/SetAlert.dart';
import 'package:yachtoncloud/connettivita.dart';
import 'package:yachtoncloud/drawer.dart';
import 'package:yachtoncloud/navigation_provider.dart';
import 'package:yachtoncloud/paginaIniziale.dart';
import 'package:yachtoncloud/realTimeVideo.dart';
import 'package:yachtoncloud/scanpage.dart';
import 'package:yachtoncloud/statovideocamere.dart';
import 'package:yachtoncloud/template.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yachtoncloud/theme/colors.dart';

import 'package:yachtoncloud/trackingpage.dart';
import 'package:yachtoncloud/videoscreenbydate.dart';
import 'package:yachtoncloud/vlc_screen.dart';

import 'theme/colors.dart';
import 'theme/colors.dart';
import 'indice.dart';

void main() {
  runApp(const Dashboard());
}

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

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
          home: const DashboardBox(indice: 0),
        ),
      );
}

class DashboardBox extends StatefulWidget {
  const DashboardBox({Key? key, required this.indice}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final int indice;

  @override
  State<DashboardBox> createState() => _DashboardBoxState();
}

class _DashboardBoxState extends State<DashboardBox> {
  // ignore: unused_field
  var indic;
  Indice indx = Indice();

  void bb() {
    print('Clicked Clicked');
    indic = widget.indice;
    setState(() {
      print("siu");
      print(indic);
    });
  }
  //TODO: Creare dashboard copiando associabox afammok a mammt

  List boxesList = [];
  Future<DocumentSnapshot<Map<String, dynamic>>> getBoxes() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Utenti');
    FirebaseFirestore.instance
        .collection('Utenti')
        .doc(uid)
        .get()
        .then((querySnapshot) async {
      if (querySnapshot.data()!.containsKey("boxes")) {
        //debugPrint("ok, non c'è proprio il campo box " + uid);
        debugPrint(
            "Indice dash ${querySnapshot.data()!['boxes'][widget.indice]}");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('indice', widget.indice);
        indic = widget.indice;
        boxesList = querySnapshot.data()!['boxes'][widget.indice];
        print("query ${querySnapshot.data()}");
      }
    });
    return await FirebaseFirestore.instance.collection('Utenti').doc(uid).get();
    //debugPrint("inserisco la box " + uid);
  }

  @override
  Widget build(BuildContext context) {
    var res = true;
    var size = MediaQuery.of(context).size;
    var cardTextStyle = GoogleFonts.poppins(
        textStyle: TextStyle(
            color: textColorDashboard,
            fontSize: 12,
            fontWeight: FontWeight.bold));
    var textList = [
      "Videosorveglianza",
      "Impostazioni \nvideosorveglianza",
      "Storico \nregistrazioni",
      "Connettività",
      "Impostazioni \nconnettività",
      "Tracking GPS",
      "Notifica di movimento",
      "Cambia box",
      "Associa nuova box"
    ];
    var assetsList = [
      "camer.png",
      "setti.png",
      "storico.png",
      "wifismart.png",
      "wifi.png",
      "tracking.png",
      "notifications.png",
      "box.png",
      "qrc.png"
    ];

    getWidgetAssocia(bool res) {
      if (res) {
        return <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 7, bottom: 7),
              child: Text('Associazione box',
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
              child: Text('Associazione box riuscita!',
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
      } else {
        return <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 7, bottom: 7),
              child: Text('Associazione box',
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
              child: Text('Associazione box fallita, riprova.',
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

    getWidgetConn(bool res) {
      if (res) {
        return <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 7, bottom: 7),
              child: Text('Dati connettività',
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
              child: Text('Modifiche avvenute con successo!',
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
      } else {
        return <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 7, bottom: 7),
              child: Text('Dati connettività',
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
              child: Text('Modifiche fallite, riprova.',
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

    getWidgetAlert(bool res) {
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
              child:
                  Lottie.asset('assets/success.json', fit: BoxFit.scaleDown)),
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
              child: Text(
                  'Modifica ai dati delle videocamere fallita, riprova.',
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

    List<Widget> getWidget(int c, bool res) {
      switch (c) {
        case 1:
          return getWidgetAssocia(res);
        case 2:
          return getWidgetConn(res);
        case 3:
          return getWidgetAlert(res);
        case 4:
          return getWidgetCamera(res);
        default:
          return [Center()];
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

    _gridView() {
      return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getBoxes(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: appBarColor1),
              );
            } else if (snap.hasData) {
              debugPrint("Non devo più aspettare");
              return GridView.builder(
                  itemCount: assetsList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return new GestureDetector(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Transform.scale(
                            // scale: 1.5,
                            /*child:*/ Image.asset(
                              "assets/${assetsList[index]}",
                              width: 100,
                              height: 90,
                            ),
                            //),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              textList[index],
                              style: cardTextStyle,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      onTap: () async {
                        final navigateTo = (page) =>
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => page,
                            ));
                        switch (index) {
                          case 0:
                            navigateTo(RealTimeVideo(indice: indic));
                            break;
                          case 1:
                            final value = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StatusVideocamere()),
                            );
                            setState(() {
                              res = value;
                            });
                            await _showMyDialog(res, 4);
                            break;
                          case 2:
                            navigateTo(VideoInfoBySearch());
                            break;
                          case 3:
                            navigateTo(Connettivita());
                            break;
                          case 4:
                            final value = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsConnettivita()),
                            );
                            setState(() {
                              res = value;
                            });
                            await _showMyDialog(res, 2);
                            break;
                          case 5:
                            navigateTo(TrackingPage());
                            break;
                          case 6:
                            final value = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SetAlertPage_(title: "peppe")),
                            );
                            setState(() {
                              res = value;
                            });
                            await _showMyDialog(res, 3);
                            break;
                          case 7:
                            navigateTo(PaginaIniziale());
                            break;

                          case 8:
                            // mark the function as async
                            print('tap');
                            final value = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScanPage()),
                            );
                            setState(() {
                              res = value;
                            });
                            debugPrint("TRMOOOOOOON " + res.toString());
                            // Show PopUp
                            await _showMyDialog(res, 1);
                            bb();
                            break;
                        }
                      },
                    );
                  });
            }
            return Center(
                child: Text("O cazz",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold))));
          });
    }

    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [backgroundColor1, backgroundColor2]),
          ),
          child: Stack(
            children: [
              Container(
                height: 200.0,
                decoration: new BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      blurRadius: 40.0,
                    )
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [dashboardBackground1, dashboardBackground2]),
                  borderRadius: new BorderRadius.vertical(
                      bottom: new Radius.elliptical(
                          MediaQuery.of(context).size.width, 100.0)),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        height: 64,
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Dashboard",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: textColor,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold))),
                              ],
                            )
                          ],
                        ),
                      ),

                      //sostituire con createGrid perché cosi esce sempre la dashboard
                      Expanded(child: _gridView())
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
