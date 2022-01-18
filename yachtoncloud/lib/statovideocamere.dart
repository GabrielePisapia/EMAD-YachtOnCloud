import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          home: StatusVideocamere(),
        ),
      );
}

/*class _statoVideocamere extends StatefulWidget {
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
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [backgroundColor2, backgroundColor1]),
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
}*/

class StatusVideocamere extends StatefulWidget {
  @override
  _StatusVideocamereState createState() => _StatusVideocamereState();
}

class _StatusVideocamereState extends State<StatusVideocamere> {
  bool switchValue1 = false, switchValue2 = true, switchValue3 = true, switchValue4 = true;
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
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [backgroundColor2, backgroundColor1]),
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
                          "Impostazioni videocamere",
                          style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                        ))),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 7),
                      child: Text(
                        'Nomi e stato',
                        style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                      ),
                    )),
                
                Container(
                  height: 300,
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
                          padding:
                              EdgeInsets.only(top: 20, left: 20),
                          child:Row(children: [
                            Container(
                            //width: double.infinity,
                            height: 50,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              //initialValue: 'Yachtz25',
                              decoration: InputDecoration(
                                hintText: 'Videocamera1',
                                fillColor: fieldTextColor,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                            ),
                          ),
                           SizedBox(
                              width: 30,
                            ),
                            Image.asset(
                              switchValue2 ? 'assets/camera.png' : 'assets/no-camera.png',
                              height: 30,
                              width: 30,
                              color: switchValue2 ? Colors.green : Colors.red,
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
                          ],)),
                    Padding(
                          padding:
                              EdgeInsets.only(top: 20, left: 20),
                          child:Row(children: [
                            Container(
                            //width: double.infinity,
                            height: 50,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              //initialValue: 'Yachtz25',
                              decoration: InputDecoration(
                                hintText: 'Videocamera2',
                                fillColor: fieldTextColor,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                            ),
                          ),
                           SizedBox(
                              width: 30,
                            ),
                            Image.asset(
                              switchValue1 ? 'assets/camera.png' : 'assets/no-camera.png',
                              height: 30,
                              width: 30,
                              color: switchValue1 ? Colors.green : Colors.red,
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
                          ],)),
                           Padding(
                          padding:
                              EdgeInsets.only(top: 20, left: 20),
                          child:Row(children: [
                            Container(
                            //width: double.infinity,
                            height: 50,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              //initialValue: 'Yachtz25',
                              decoration: InputDecoration(
                                hintText: 'Videocamera3',
                                fillColor: fieldTextColor,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                            ),
                          ),
                           SizedBox(
                              width: 30,
                            ),
                            Image.asset(
                              switchValue3 ? 'assets/camera.png' : 'assets/no-camera.png',
                              height: 30,
                              width: 30,
                              color: switchValue3 ? Colors.green : Colors.red,
                            ),
                           
                           SizedBox(
                              height: 20,
                              child: Switch(
                                activeColor: Colors.green,
                                inactiveThumbColor: Colors.red,
                                value: switchValue3,
                                onChanged: (val3) {
                                  setState(() {
                                    switchValue3 = val3;
                                  });
                                },
                              ),
                            ),
                          ],)),
                           Padding(
                          padding:
                              EdgeInsets.only(top: 20, left: 20),
                          child:Row(children: [
                            Container(
                            //width: double.infinity,
                            height: 50,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: TextFormField(
                              //initialValue: 'Yachtz25',
                              decoration: InputDecoration(
                                hintText: 'Videocamera4',
                                fillColor: fieldTextColor,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                            ),
                          ),
                           SizedBox(
                              width: 30,
                            ),
                            Image.asset(
                              switchValue4 ? 'assets/camera.png' : 'assets/no-camera.png',
                              height: 30,
                              width: 30,
                              color: switchValue4 ? Colors.green : Colors.red,
                            ),
                           
                           SizedBox(
                              height: 20,
                              child: Switch(
                                activeColor: Colors.green,
                                inactiveThumbColor: Colors.red,
                                value: switchValue4,
                                onChanged: (val4) {
                                  setState(() {
                                    switchValue4 = val4;
                                  });
                                },
                              ),
                            ),
                          ],)),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Container(
                      width: 200,
                      height: 50,
                      child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(buttonColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
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
                         style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                      ),
                    ))),
              ])),
        ));
  }
}
