import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:provider/provider.dart';
import 'package:yachtoncloud/theme/colors.dart';
import 'navigation_provider.dart';
import 'template.dart';
import 'package:flutter/foundation.dart';

bool _obscureText = true;
bool isSwitched = true;

class ChartData {
  ChartData(String x, int y, Color? color) {
    this.x = x;
    this.y = y;
    this.color = color!;
  }
  late final String x;
  late final int y;
  late final Color color;
}

class DetailsConnettivita extends StatefulWidget {
  @override
  _DetailsConnettivitaState createState() => _DetailsConnettivitaState();
}

class _DetailsConnettivitaState extends State<DetailsConnettivita> {
  var nomeRete = "";
  var statusRete = true;
  var indic;
  final TextEditingController reteController = new TextEditingController();
  Future<DocumentSnapshot<Map<String, dynamic>>>? _connData;

  ScrollController _controller = ScrollController();

  Future<DocumentSnapshot<Map<String, dynamic>>> getConnData() async {
    debugPrint("Ma almeno ci arrivo qua?");
    final uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Utenti');
    var snap =
        await FirebaseFirestore.instance.collection('Utenti').doc(uid).get();

    //ECCO IL TUO INDICE
    SharedPreferences prefs = await SharedPreferences.getInstance();
    indic = prefs.getInt('indice');
    print("INDEX connettivita ${indic}");

    nomeRete = snap.data()!['boxes'][indic]['box']['router']['nomeRete'];
    statusRete = snap.data()!['boxes'][indic]['box']['router']['attivo'];
    isSwitched = statusRete;
    debugPrint(nomeRete);
    return await snap;
  }

  Future<String> UpdateRouterStateDB() async {
    String esito = "";
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference users =
          FirebaseFirestore.instance.collection('Utenti');
      var snap =
          await FirebaseFirestore.instance.collection('Utenti').doc(uid).get();
      final data = snap.data();
      final boxes =
          data!['boxes'].map((item) => item as Map<String, dynamic>).toList();
      final box = boxes[0]['box'];
      debugPrint(box.toString());
      final router = box['router'];

      if (reteController.text != "") {
        router['nomeRete'] = reteController.text;
      }
      router['attivo'] = statusRete;

      await FirebaseFirestore.instance
          .collection('Utenti')
          .doc(uid)
          .update(data);
      esito = 'Ok';
      return esito;
    } catch (ex) {
      debugPrint(ex.toString());
      return ex.toString();
    }
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    _connData = getConnData(); //the listener for up and down.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Template(
        appBarTitle: 'Yacht on Cloud',
        boxDecoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [backgroundColor2, backgroundColor1]),
        ),
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: _connData,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: appBarColor1),
                );
              } else if (snap.hasData) {
                debugPrint("Non devo pi?? aspettare");

                return SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 100.0, 30.0, 5.0),
                      child: Column(children: [
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  nomeRete.toString(),
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: textColor,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                ))),
                        SizedBox(
                          height: 13,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 7),
                              child: Text(
                                'Status rete',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: textColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal)),
                              ),
                            )),
                        Container(
                            height: 100,
                            //width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      cardsColor1,
                                      cardsColor2,
                                    ]),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: shadowCard.withOpacity(0.01),
                                    spreadRadius: 5,
                                    blurRadius: 3,
                                    // changes position of shadow
                                  ),
                                ]),
                            child: Column(children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 25, left: 20, right: 20),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Image.asset(
                                          isSwitched
                                              ? 'assets/wifiON.png'
                                              : 'assets/wifiOFF.png',
                                          height: 70,
                                          width: 70,
                                        )),
                                        Expanded(
                                            child: Column(children: [
                                          Center(
                                              child: Text(
                                            "Status: " +
                                                (isSwitched
                                                    ? "Attivo"
                                                    : "Disattivo"),
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: textColor,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          )),
                                          Switch(
                                            value: isSwitched,
                                            onChanged: (value) {
                                              setState(() {
                                                isSwitched = value;
                                                statusRete = value;
                                                debugPrint(
                                                    isSwitched.toString() +
                                                        " " +
                                                        statusRete.toString());
                                              });
                                            },
                                            activeTrackColor: activeTrackLight,
                                            activeColor: activeTrackDark,
                                          ),
                                        ]))
                                      ]))
                            ])),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 7),
                              child: Text(
                                'Nome e password',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: textColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal)),
                              ),
                            )),
                        Container(
                          height: 160,
                          //width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    cardsColor1,
                                    cardsColor2,
                                  ]),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: shadowCard.withOpacity(0.01),
                                  spreadRadius: 5,
                                  blurRadius: 3,
                                  // changes position of shadow
                                ),
                              ]),
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  child: Container(
                                    //width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: TextFormField(
                                      controller: reteController,
                                      decoration: InputDecoration(
                                        hintText: nomeRete,
                                        hintStyle: TextStyle(color: textColor.withOpacity(0.8)),
                                        fillColor: fieldTextColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: TextFormField(
                                      autocorrect: false,
                                      obscureText: _obscureText,
                                      initialValue: 'Password',
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          color: textColor.withOpacity(0.7),
                                            icon: Icon(_obscureText
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            onPressed: () {
                                              setState(() {
                                                debugPrint('prechange: ' +
                                                    _obscureText.toString());
                                                _obscureText = !_obscureText;
                                                debugPrint('postchange: ' +
                                                    _obscureText.toString());
                                              });
                                            }),
                                        hintText: 'Password',
                                        hintStyle: TextStyle(color: textColor.withOpacity(0.8)),
                                        fillColor: fieldTextColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        Container(
                          width: 250,
                          height: 50,
                          margin: EdgeInsets.symmetric(vertical: 1),
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(buttonColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(color: buttonColor)))),
                            onPressed: () {
                              var esito = "";
                              UpdateRouterStateDB().then((val) {
                                esito = val;
                                print(esito);
                                if (esito == "Ok") {
                                  var res = true;
                                  debugPrint(esito + " " + res.toString());
                                  Navigator.pop(context, res);
                                } else {
                                  var res = false;
                                  debugPrint(esito + " " + res.toString());
                                  Navigator.pop(context, res);
                                }
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Conferma modifiche',
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
                        )
                      ])),
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
            }));
  }
}

class Connettivita extends StatefulWidget {
  @override
  _ConnettivitaState createState() => _ConnettivitaState();
}

class _ConnettivitaState extends State<Connettivita> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var res = true;
    var nomeRete = "";
    var nomePromozione = "";
    var provider = "";
    int giga = 0;
    int consumati = 0;
    int restanti = 0;
    var _myList = [];
    List<ChartData> chartData = [];

    Future<DocumentSnapshot<Map<String, dynamic>>> getConnData() async {
      debugPrint("Ma almeno ci arrivo qua?");
      final uid = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference users =
          FirebaseFirestore.instance.collection('Utenti');
      var snap =
          await FirebaseFirestore.instance.collection('Utenti').doc(uid).get();
       SharedPreferences prefs = await SharedPreferences.getInstance();
      var indic = prefs.getInt('indice');
      print("INDICE CONNETTIVITA DUE ${prefs.getInt('indice')}");
      nomeRete = snap.data()!['boxes'][indic]['box']['router']['nomeRete'];
      giga = snap.data()!['boxes'][indic]['box']['router']['giga'];
      provider = snap.data()!['boxes'][indic]['box']['router']['provider'];
      nomePromozione = snap.data()!['boxes'][indic]['box']['router']['promozione'];
      consumati = snap.data()!['boxes'][indic]['box']['router']['consumati'];
      _myList = snap.data()!['boxes'][indic]['box']['router']['dispositivi'];
      restanti = giga - consumati;
      chartData = [
        ChartData('Consumati', int.parse(consumati.toString()), chartColor1),
        ChartData('Restanti', int.parse(restanti.toString()), chartColor2),
      ];
      debugPrint("VALORI: " + consumati.toString() + " " + restanti.toString());
      return await snap;
    }

    final List<Color> gradientColors = [
      chartColor1,
      chartColor2,
    ];

    ScrollController _controller = ScrollController();

    _scrollListener() {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        setState(() {
          //you can do anything here
        });
      }
      if (_controller.offset <= _controller.position.minScrollExtent &&
          !_controller.position.outOfRange) {
        setState(() {
          //you can do anything here
        });
      }
    }

    void initState() {
      _controller = ScrollController();
      _controller.addListener(_scrollListener); //the listener for up and down.
      super.initState();
    }

    var size = MediaQuery.of(context).size;

    getWidget(bool res) {
      if (res) {
        return <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 7, bottom: 7),
              child: Text('Dati connettivit??',
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
              child: Text('Dati connettivit??',
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

    Future<void> _showMyDialog(bool res) async {
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
        boxDecoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [backgroundColor2, backgroundColor1]),
        ),
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: getConnData(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: appBarColor1),
                );
              } else if (snap.hasData) {
                debugPrint("Non devo pi?? aspettare");
                return SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 0.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              nomeRete.toString(),
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: textColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            )),
                      ),
                      /*SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, right: 6),
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            cardsColor2,
                            cardsColor1,
                          ]),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: shadowCard.withOpacity(0.01),
                          spreadRadius: 5,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.toString() + " - " + nomePromozione.toString(),
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: textColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                giga.toString(),
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: textColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: (size.width - 20),
                            height: 150,
                            child: LineChart(
                              LineChartData(
                                gridData: FlGridData(
                                    show: true,
                                    drawHorizontalLine: true,
                                    getDrawingHorizontalLine: (value) {
                                      return FlLine(
                                        color: Colors.white,
                                        strokeWidth: 0.1,
                                      );
                                    }),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 22,
                                    getTextStyles: (value) =>
                                        GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: textColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal)),
                                    //const TextStyle(color: Colors.white, fontSize: 12),
                                    getTitles: (value) {
                                      switch (value.toInt()) {
                                        case 0:
                                          return 'LUN';
                                        case 3:
                                          return 'GIO';
                                        case 6:
                                          return 'DOM';
                                      }
                                      return '';
                                    },
                                    margin: 8,
                                  ),
                                  leftTitles: SideTitles(
                                    showTitles: true,
                                    getTextStyles: (value) =>
                                        GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: textColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal)),
                                    getTitles: (value) {
                                      switch (value.toInt()) {
                                        case 1:
                                          return '10GB';
                                        case 3:
                                          return '50GB';
                                        case 5:
                                          return '100GB';
                                      }
                                      return '';
                                    },
                                    reservedSize: 35,
                                    margin: 10,
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                minX: 0,
                                maxX: 8,
                                minY: 0,
                                maxY: 6,
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: [
                                      FlSpot(0, 1.2),
                                      FlSpot(2.1, 2.2),
                                      FlSpot(2.8, 4.7),
                                      FlSpot(4.9, 2.1),
                                      FlSpot(6, 4),
                                      FlSpot(8, 5.7),
                                    ],
                                    isCurved: true,
                                    colors: gradientColors,
                                    barWidth: 3,
                                    isStrokeCapRound: true,
                                    dotData: FlDotData(
                                      show: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),*/
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, bottom: 7),
                                  child: Text(
                                    'Dispositivi connessi',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: textColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                )),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 5, right: 5, bottom: 5),
                              width: (size.width - 40),
                              height: 160,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        cardsColor2,
                                        cardsColor1,
                                      ]),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: shadowCard.withOpacity(0.01),
                                      spreadRadius: 10,
                                      blurRadius: 3,
                                      // changes position of shadow
                                    ),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 25, top: 20, bottom: 5),
                                child: Column(
                                  //mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            height: 114,
                                            child: CustomScrollView(
                                              controller: _controller,
                                              slivers: [
                                                SliverList(
                                                    delegate:
                                                        SliverChildBuilderDelegate(
                                                  (context, index) {
                                                    return SizedBox(
                                                        height: 45,
                                                        width:
                                                            (size.width - 10) /
                                                                2,
                                                        child: Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                          ),
                                                          child: ListTile(
                                                            visualDensity:
                                                                VisualDensity(
                                                                    horizontal:
                                                                        -3,
                                                                    vertical:
                                                                        -4),
                                                            leading: Container(
                                                              height: double
                                                                  .infinity,
                                                              child: Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          0.0),
                                                                  child: Icon(
                                                                      Icons
                                                                          .smartphone,
                                                                      size:
                                                                          19.0,
                                                                      color:
                                                                          textColor)),
                                                            ),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.0)),
                                                            tileColor:
                                                                listElementColor,
                                                            title: Text(
                                                                _myList[index],
                                                                style: GoogleFonts.poppins(
                                                                    textStyle: TextStyle(
                                                                        color:
                                                                            textColor,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.normal))),
                                                            //subtitle: Text('${person.age}'),
                                                          ),
                                                        ));
                                                  },
                                                  childCount: _myList.length,
                                                ))
                                              ],
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, bottom: 7),
                                  child: Text(
                                    'Consumi',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: textColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                )),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 5, right: 5, bottom: 5),
                              width: (size.width - 40),
                              height: 150,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        cardsColor2,
                                        cardsColor1,
                                      ]),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: shadowCard.withOpacity(0.01),
                                      spreadRadius: 10,
                                      blurRadius: 3,
                                      // changes position of shadow
                                    ),
                                  ]),
                              child: Column(
                                //mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: 140,
                                          width: (size.width - 40),
                                          child: SfCircularChart(
                                              legend: Legend(
                                                  toggleSeriesVisibility: false,
                                                  isVisible: true,
                                                  textStyle: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: textColor,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight
                                                              .normal))),
                                              series: <CircularSeries>[
                                                // Renders doughnut chart
                                                DoughnutSeries<ChartData,
                                                        String>(
                                                    dataSource: chartData,
                                                    pointColorMapper:
                                                        (ChartData data, _) =>
                                                            data.color,
                                                    xValueMapper:
                                                        (ChartData data, _) =>
                                                            data.x,
                                                    yValueMapper:
                                                        (ChartData data, _) =>
                                                            data.y,
                                                    dataLabelSettings:
                                                        DataLabelSettings(
                                                      isVisible: true,
                                                      textStyle: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              color: textColor,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                      // Positioning the data label
                                                      labelPosition:
                                                          ChartDataLabelPosition
                                                              .outside,
                                                    ))
                                              ]))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            Container(
                              width: 250,
                              height: 50,
                              margin: EdgeInsets.symmetric(vertical: 1),
                              child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(buttonColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            side: BorderSide(
                                                color: buttonColor)))),
                                onPressed: () async {
                                  var value = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsConnettivita()),
                                  );
                                  setState(() {
                                    res = value;
                                  });
                                  debugPrint(
                                      "HELP MEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
                                  await _showMyDialog(res);
                                },
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Impostazioni connettivit??',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: textColor,
                                                  fontSize: 17,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]),
                    ],
                  ),
                ));
              } else {
                return Center(
                    child: Text("${snap.error}",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))));
              }
            }));
  }
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 20.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Menu',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 20.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Nome',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Email@example.com',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          )),
          ListTile(
            leading: Icon(
              Icons.wifi,
            ),
            title: Text('Connettivit??'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(
              Icons.video_settings_rounded,
            ),
            title: Text('Videosorveglianza'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(
              Icons.gps_fixed_outlined,
            ),
            title: Text('Tracking GPS'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.notification_important_rounded),
            title: Text('Notifica di movimento'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}

class LineTitles {
  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 3:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 5:
                return '50GB';
              case 10:
                return '100GB';
            }
            return '';
          },
          reservedSize: 35,
          margin: 12,
        ),
      );
}
