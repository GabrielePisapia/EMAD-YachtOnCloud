// ignore_for_file: prefer_const_literals_to_create_immutables

//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yachtoncloud/SetAlert.dart';
import 'package:yachtoncloud/connettivita.dart';
import 'package:yachtoncloud/dashboard.dart';
import 'package:yachtoncloud/drawer.dart';
import 'package:yachtoncloud/navigation_provider.dart';
import 'package:yachtoncloud/nomiBoxes.dart';
import 'package:yachtoncloud/scanpage.dart';
import 'package:yachtoncloud/statovideocamere.dart';
import 'package:yachtoncloud/template.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yachtoncloud/theme/colors.dart';
import 'package:yachtoncloud/trackingpage.dart';
import 'package:yachtoncloud/videoscreenbydate.dart';
import 'package:yachtoncloud/vlc_screen.dart';

void main() {
  runApp(const PaginaIniziale());
}

class PaginaIniziale extends StatelessWidget {
  const PaginaIniziale({Key? key}) : super(key: key);

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
          home: const AssociaBox(creaGrid: 1),
        ),
      );
}

class AssociaBox extends StatefulWidget {
  const AssociaBox({Key? key, required this.creaGrid}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final int creaGrid;

  @override
  State<AssociaBox> createState() => _AssociaBoxState();
}

class _AssociaBoxState extends State<AssociaBox> {
  // ignore: unused_field
  var createGrid;
  bool res = true;

  void bb() {
    print('Clicked Clicked');

    setState(() {
      createGrid = widget.creaGrid;
      print("siu");
      print(createGrid);
    });
  }
  //TODO: Creare dashboard copiando associabox afammok a mammt

  @override
  initState() {
    createGrid = 0;
    super.initState();
  }

  List boxesList = [];
  Future<DocumentSnapshot<Map<String, dynamic>>> getBoxes() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Utenti');
    FirebaseFirestore.instance
        .collection('Utenti')
        .doc(uid)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.data()!.containsKey("boxes")) {
        //debugPrint("ok, non c'è proprio il campo box " + uid);
        boxesList = querySnapshot.data()!['boxes'];
        print("query " + boxesList[0].toString());
        if (boxesList.length != 0) {
          boxesList.add({
            'box': {'nome': 'Impostazioni boxes'}
          });
          createGrid = 1;
        } else {
          createGrid = 0;
        }
        debugPrint(createGrid);
      }
    });
    return await FirebaseFirestore.instance.collection('Utenti').doc(uid).get();
    //debugPrint("inserisco la box " + uid);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cardTextStyle = GoogleFonts.poppins(
        textStyle: TextStyle(
            color: textColorDashboard,
            fontSize: 12,
            fontWeight: FontWeight.bold));

    getBoxWidget(bool res) {
      if (res) {
        return <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 7, bottom: 7),
              child: Text('Associazione',
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
              child: Text('Associazione',
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

    getNamesWidget(bool res) {
      if (res) {
        return <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 7, bottom: 7),
              child: Text('Impostazioni boxes',
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
              child: Text('Impostazioni dei boxes aggiornate con successo!',
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
              child: Text('Impostazioni boxes',
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
              child: Text('Aggiornamento fallito, riprova.',
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

    Future<void> _showMyDialog(bool res, int i) async {
      if (i == 0) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
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
                  children: getBoxWidget(res),
                )),
              ),
              contentPadding: EdgeInsets.all(0.0),
            );
          },
        );
      } else if (i == 1) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
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
                  children: getNamesWidget(res),
                )),
              ),
              contentPadding: EdgeInsets.all(0.0),
            );
          },
        );
      }
    }

    _checkGrid() {
      return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getBoxes(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: appBarColor1),
              );
            } else if (snap.hasData && boxesList.length != 0) {
              debugPrint("Non devo più aspettare lunghezza ${boxesList}");
              return Expanded(
                  child: GridView.builder(
                      itemCount: boxesList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Transform.scale(
                                    scale: 1.5,
                                    child: Image.asset(
                                      index < boxesList.length - 1
                                          ? "assets/box.png"
                                          : "assets/settingbox.png",
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  boxesList[index]['box']['nome'].toString(),
                                  style: cardTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            debugPrint("Indice${index}");
                            if (index < boxesList.length - 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DashboardBox(indice: index, scan : false, res : false)));
                            } else {
                              final value = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => statusBoxes()));
                              setState(() {
                                res = value;
                              });
                              await _showMyDialog(res, 1);
                            }
                          },
                        );
                      }));
            }
            debugPrint("sono fuori");
            return Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 60,
                child: InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.only(top: 15, left: 20, right: 20),
                          child: Image.asset(
                            "assets/qrc.png",
                            width: 100,
                            height: 100,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Associa box",
                        style: cardTextStyle,
                      ),
                    ],
                  ),
                  onTap: () async {
                    // mark the function as async
                    print('tap');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ScanPage()),
                    );
                    bb();
                  },
                ),
              ),
            );
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
                      _checkGrid()
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
