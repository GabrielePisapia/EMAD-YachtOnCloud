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

  void bb() {
    print('Clicked Clicked');

    setState(() {
      createGrid = widget.creaGrid;
      print("siu");
      print(createGrid);
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
        .then((querySnapshot) {
      if (querySnapshot.data()!.containsKey("boxes")) {
        //debugPrint("ok, non c'è proprio il campo box " + uid);
        boxesList = querySnapshot.data()!['boxes'];
        print("query ${querySnapshot.data()}");
        if(boxesList.length != 0) {
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
    var textList = [
      "Videosorveglianza",
      "Impostazioni \nvideosorveglianza",
      "Storico \nregistrazioni",
      "Connettività",
      "Impostazioni \nconnettività",
      "Tracking GPS",
      "Notifica di movimento",
      "Associa nuova box"
    ];
    var assetsList = [
      "video-camera.png",
      "setting.png",
      "list.png",
      "smartphone.png",
      "settingwifi.png",
      "compass.png",
      "job.png",
      "qr-code.png"
    ];

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
                            Image.asset(
                              "assets/${assetsList[index]}",
                              width: 100,
                              height: 100,
                            ),
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
                      onTap: () {
                        final navigateTo = (page) =>
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => page,
                            ));
                        switch (index) {
                          case 0:
                            navigateTo(VlcVinfo());
                            break;
                          case 1:
                            navigateTo(StatusVideocamere());
                            break;
                          case 2:
                            navigateTo(VideoInfoBySearch());
                            break;
                          case 3:
                            navigateTo(Connettivita());
                            break;
                          case 4:
                            navigateTo((DetailsConnettivita()));
                            break;
                          case 5:
                            navigateTo(TrackingPage());
                            break;
                          case 6:
                            navigateTo(SetAlertPage());
                            break;
                          case 7:
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScanPage()));
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
              debugPrint("Non devo più aspettare ${boxesList.length}");
              return Expanded(child: GridView.builder(
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
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        //videolist[index]["thumb_url"] nel caso di dati da db
                                        boxesList[index]['box']['img']),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              boxesList[index]['box']['nome'].toString(),
                              style: cardTextStyle,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()));
                      },
                    );
                  }));
            }
            return Center(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 60,
                                child: InkWell(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/qr-code.png",
                                        width: 200,
                                        height: 150,
                                      ),
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
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScanPage()),
                                    );
                                    // Show PopUp
                                    await Dialogs.materialDialog(
                                        color: Colors.white,
                                        msg: 'Associazione box riuscita!',
                                        title: 'Associazione',
                                        lottieBuilder: Lottie.asset(
                                          'assets/success.json',
                                          fit: BoxFit.contain,
                                        ),
                                        context: context,
                                        actions: [
                                          IconsButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            text: 'Ok',
                                            iconData: Icons.done,
                                            color: Colors.blue,
                                            textStyle: TextStyle(color: Colors.white),
                                            iconColor: Colors.white,
                                          ),
                                        ],
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
                colors: [dashboardBackground1, dashboardBackground2]),
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
                      colors: [backgroundColor1, backgroundColor2]),
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
