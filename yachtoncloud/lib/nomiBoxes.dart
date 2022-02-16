import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yachtoncloud/navigation_provider.dart';
import 'package:yachtoncloud/template.dart';
import 'package:provider/provider.dart';

import 'theme/colors.dart';

class statoBoxes extends StatelessWidget {
  const statoBoxes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => NavigationProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: statusBoxes(),
        ),
      );
}

class statusBoxes extends StatefulWidget {
  @override
  _boxesState createState() => _boxesState();
}

class _boxesState extends State<statusBoxes> {
  List<TextEditingController> nameController = [];
  var boxesVar = [];
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

  Future<List> getBoxesData() async {
    debugPrint("Ma almeno ci arrivo qua?");
    final uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Utenti');
    var snap =
        await FirebaseFirestore.instance.collection('Utenti').doc(uid).get();
    return await snap.data()!['boxes'];
  }

  Future<String> UpdateBoxesStateDB() async {
    String esito = "";
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      CollectionReference users =
          FirebaseFirestore.instance.collection('Utenti');
      var snap =
          await FirebaseFirestore.instance.collection('Utenti').doc(uid).get();
      final data = snap.data();
      final boxes = data!['boxes'].map((item) => item as Map<String, dynamic>).toList();

      for (int i = 0; i < boxes.length; i++) {
        if (nameController[i].text != "") {
           boxes[i]['box']['nome'] = nameController[i].text;
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
    _futureData = getBoxesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Widget createRow(String nomeBox, int i) {
      var index = i;
      return Padding(
          padding: EdgeInsets.only(top: 20, left: 20),
          child: Row(
            children: [
              Container(
                  //width: double.infinity,
                  height: 50,
                  width: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextField(
                      controller: nameController[i],
                      obscureText: false,
                      decoration: InputDecoration(
                          hintText: nomeBox,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          fillColor: fieldTextColor,
                          filled:
                              true))
                  ),
            ],
          ));
    }

    List<Widget> createList() {
      List<Widget> list = [];
      for (int i = 0; i < boxesVar.length; i++) {
        nameController.add(new TextEditingController());
        list.add(createRow(boxesVar[i]['box']['nome'], i));
        if(i != boxesVar.length - 1) {
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
                debugPrint(snap.toString() + " " + boxesVar.toString());
                return Center(
                  child: CircularProgressIndicator(color: appBarColor1),
                );
              } else if (snap.hasData) {
                debugPrint("Non devo più aspettare");
                boxesVar = snap.data!;
                return SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 100.0, 30.0, 5.0),
                      child: Column(children: [
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Impostazioni boxes",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: textColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                ))),
                                SizedBox(height: 15,),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 7),
                              child: Text('Nomi boxes',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: textColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal))),
                            )),
                        Container(
                          height:330,
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
                          child: SingleChildScrollView( child: Column(
                            children:createList(), 
                          )),
                        ),
                        SizedBox(height: 13,),
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
                                    UpdateBoxesStateDB().then((val) {
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
                debugPrint("Non so why " + boxesVar.toString());
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
