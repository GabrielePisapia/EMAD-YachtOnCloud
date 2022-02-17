import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

class StatusVideocamere extends StatefulWidget {
  @override
  _StatusVideocamereState createState() => _StatusVideocamereState();
}

class _StatusVideocamereState extends State<StatusVideocamere> {
  List<TextEditingController> nameController = [];
  var cameras = [];
  Future<List>? _futureData;

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

  Future<List> getCameraData() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
      var indic = prefs.getInt('indice');
    debugPrint("Ma almeno ci arrivo qua?");
    final uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Utenti');
    var snap =
        await FirebaseFirestore.instance.collection('Utenti').doc(uid).get();
    return await snap.data()!['boxes'][indic]['box']['videocamere'];
  }

  Future<String> UpdateCameraStateDB() async {
    String esito = "";
    try {
       SharedPreferences prefs = await SharedPreferences.getInstance();
      var indic = prefs.getInt('indice');
      final uid = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference users =
          FirebaseFirestore.instance.collection('Utenti');
      var snap =
          await FirebaseFirestore.instance.collection('Utenti').doc(uid).get();
      final data = snap.data();

      final boxes =
          data!['boxes'].map((item) => item as Map<String, dynamic>).toList();
      final box = boxes[indic]['box'];
      debugPrint(box.toString());
      final videoCamere = box['videocamere'];

      for (int i = 0; i < cameras.length; i++) {
        videoCamere[i]['attivo'] = cameras[i]['attivo'];
        if (nameController[i].text != "") {
          videoCamere[i]['nomeCamera'] = nameController[i].text;
        }
      }

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

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    _futureData = getCameraData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Widget createRow(String nomeCamera, bool status, int i, double size) {
      var index = i;
      return Padding(
          padding: EdgeInsets.only(top: 20, left: 20),
          child: Container(
            width: size - 70,
            child: Row(
              children: [
                Container(
                    //width: double.infinity,
                    height: 50,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextField(
                        controller: nameController[i],
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: nomeCamera,
                            hintStyle: TextStyle(color: textColor.withOpacity(0.8)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            fillColor: fieldTextColor,
                            filled: true))),
                SizedBox(
                  width: 20,
                ),
                Image.asset(
                  status ? 'assets/camera.png' : 'assets/no-camera.png',
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  height: 20,
                  child: Switch(
                    activeTrackColor: activeTrackLight,
                    activeColor: activeTrackDark,
                    value: status,
                    onChanged: (val2) {
                      //debugPrint(status.toString() + " " + val2.toString());
                      setState(() {
                        status = val2;
                        cameras[i]['attivo'] = val2;
                        //debugPrint(cameras.toString());
                      });
                    },
                  ),
                ),
              ],
            ),
          ));
    }

    List<Widget> createList(double size) {
      List<Widget> list = [];
      for (int i = 0; i < cameras.length; i++) {
        nameController.add(new TextEditingController());
        list.add(createRow(cameras[i]['nomeCamera'], cameras[i]['attivo'], i, size));
        if (i != cameras.length - 1) {
          list.add(SizedBox(
            height: 10,
          ));
        }
      }
      list.add(SizedBox(
        height: 20,
      ));
      return list;
    }

    return Template(
        appBarTitle: 'Yacht on Cloud',
        boxDecoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [backgroundColor2, backgroundColor1]),
        ),
        child: FutureBuilder<List>(
            future: _futureData,
            builder: (BuildContext context, AsyncSnapshot<List> snap) {
              if (!snap.hasData) {
                debugPrint(snap.toString() + " " + cameras.toString());
                return Center(
                  child: CircularProgressIndicator(color: appBarColor1),
                );
              } else if (snap.hasData) {
                debugPrint("Non devo più aspettare");
                cameras = snap.data!;
                return SingleChildScrollView(
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
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 7),
                              child: Text('Nomi e stato',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: textColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal))),
                            )),
                        Container(
                          height: 330,
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
                          child: SingleChildScrollView(
                              child: Column(

                            children: createList(size.width),
                          )),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Container(
                                width: 200,
                                height: 50,
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              buttonColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              side: BorderSide(
                                                  color: buttonColor)))),
                                  onPressed: () {
                                    var esito = "";
                                    UpdateCameraStateDB().then((val) {
                                      esito = val;
                                      print(esito);
                                      if (esito == "Ok") {
                                        var res = true;
                                        debugPrint(
                                            esito + " " + res.toString());
                                        Navigator.pop(context, res);
                                      } else {
                                        var res = false;
                                        debugPrint(
                                            esito + " " + res.toString());
                                        Navigator.pop(context, res);
                                      }
                                    });
                                  },
                                  child: Text(
                                    'Conferma modifiche',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: textColor,
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                ))),
                      ])),
                );
              } else {
                debugPrint("Non so why " + cameras.toString());
                return Center(
                    child: Text("Non so perchè: ${snap.error}",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))));
              }
            }));
  }
}
