import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    debugPrint("Ma almeno ci arrivo qua?");
    final uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Utenti');
    var snap =
        await FirebaseFirestore.instance.collection('Utenti').doc(uid).get();
    return await snap.data()!['boxes'][0]['box']['videocamere'];
    /*switchValues = [];
        for(int i = 0; i < cameras.length; i++) {
          switchValues.add(cameras[i]['attivo']);
        }
        debugPrint(switchValues.length.toString());*/
    //return cameras;
  }

  Future<String> UpdateCameraStateDB() async {
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

    Widget createRow(String nomeCamera, bool status, int i) {
      var index = i;
      return Padding(
          padding: EdgeInsets.only(top: 20, left: 20),
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
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          fillColor: fieldTextColor,
                          filled:
                              true)) /*TextFormField(
                              decoration: InputDecoration(
                                hintText: nomeCamera,
                                fillColor: fieldTextColor,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                            ),*/
                  ),
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
                  activeTrackColor:
                    activeTrackLight,
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
          ));
    }

    List<Widget> createList() {
      List<Widget> list = [];
      for (int i = 0; i < cameras.length; i++) {
        nameController.add(new TextEditingController());
        list.add(createRow(cameras[i]['nomeCamera'], cameras[i]['attivo'], i));
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
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 7),
                              child: Text('Nomi e stato',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: textColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))),
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
                            children:
                                createList() /*[
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
                    ]*/
                            ,
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
                                            fontWeight: FontWeight.bold)),
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
