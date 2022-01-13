import 'package:flutter/material.dart';
import 'package:yachtoncloud/navigation_provider.dart';
import 'package:yachtoncloud/template.dart';
import 'package:provider/provider.dart';

import 'theme/colors.dart';

void main() {
  runApp(const statoVideocamere());
}

class statoVideocamere extends StatelessWidget {
  const statoVideocamere({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => NavigationProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: const _statoVideocamere(title: 'Flutter Demo Home Page'),
        ),
      );
}

class _statoVideocamere extends StatefulWidget {
  const _statoVideocamere({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  __statoVideocamereState createState() => __statoVideocamereState();
}

class __statoVideocamereState extends State<_statoVideocamere> {
  final name = ["Attivo", "Attivo", "Attivo", "Attivo", "Attivo"];
  final TableRow rowSpacer = TableRow(children: [
    SizedBox(
      height: 15,
    ),
    SizedBox(
      height: 15,
    ),
    SizedBox(
      height: 15,
    ),
    SizedBox(
      height: 15,
    ),
    SizedBox(
      height: 15,
    ),
  ]);
  bool switchValue1 = false, switchValue2 = true, switchValue = true;
  @override
  Widget build(BuildContext context) {
    return Template(
      appBarTitle: 'Yacht on Cloud',
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0XFF6dd5ed),
              const Color(0XFF2193b0),
            ],
            begin: const FractionalOffset(0.0, 2.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Text(
              "Stato videocamere",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Table(
              defaultColumnWidth:
                  FixedColumnWidth(MediaQuery.of(context).size.width / 4),
              children: [
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: TableCell(
                        child: Center(
                            child: Text(
                      "Videocamera1",
                      style: TextStyle(color: Colors.white),
                    ))),
                  ),
                  TableCell(
                    child: Center(
                        child: Text('Attivo',
                            style: TextStyle(color: Colors.greenAccent[700]))),
                  ),
                  SizedBox(
                    height: 20,
                    child: Switch(
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      value: switchValue,
                      onChanged: (val) {
                        setState(() {
                          switchValue = val;
                        });
                      },
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28),
                    child: TableCell(
                        child: Center(
                            child: Text(
                      "Videocamera2",
                      style: TextStyle(color: Colors.white),
                    ))),
                  ),
                  TableCell(
                    child: Center(
                        child: Text('Attivo',
                            style: TextStyle(color: Colors.greenAccent[700]))),
                  ),
                  SizedBox(
                    height: 20,
                    child: Switch(
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      value: switchValue1,
                      onChanged: (val1) {
                        setState(() {
                          switchValue1 = val1;
                        });
                      },
                    ),
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                      child: Center(
                          child: Text(
                    "Videocamera3",
                    style: TextStyle(color: Colors.white),
                  ))),
                  TableCell(
                    child: Center(
                        child: Text('Attivo',
                            style: TextStyle(color: Colors.greenAccent[700]))),
                  ),
                  SizedBox(
                    height: 20,
                    child: Switch(
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      value: switchValue2,
                      onChanged: (val2) {
                        setState(() {
                          switchValue2 = val2;
                        });
                      },
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatusVideocamere extends StatefulWidget {
  @override
  _StatusVideocamereState createState() => _StatusVideocamereState();
}

class _StatusVideocamereState extends State<StatusVideocamere> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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

    return Template(
        appBarTitle: 'Yacht on Cloud',
        boxDecoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                backgroundColor1,
                backgroundColor2,
              ],
              begin: const FractionalOffset(0.0, 2.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(30.0, 100.0, 30.0, 5.0),
              child: Column(children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "YachtZ25",
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.0,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ))),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 7),
                      child: Text(
                        'Status rete',
                        style: TextStyle(
                            color: textColor,
                            letterSpacing: 1.0,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Container(
                    height: 100,
                    //width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
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
                    child: Column(children: [])),
                SizedBox(
                  height: 15,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 7),
                      child: Text(
                        'Nome e password',
                        style: TextStyle(
                            color: textColor,
                            letterSpacing: 1.0,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Container(
                  height: 160,
                  //width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
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
                          padding:
                              EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: Container(
                            //width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              //initialValue: 'Yachtz25',
                              decoration: InputDecoration(
                                hintText: 'Yachtz25',
                                fillColor: listElementColor,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(buttonColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: buttonColor)))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StatusVideocamere()),
                        );
                      },
                      child: Text(
                        'Conferma modifiche',
                        style: TextStyle(color: textColor),
                      ),
                    )),
              ])),
        ));
  }
}
