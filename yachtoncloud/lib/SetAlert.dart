import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yachtoncloud/template.dart';
import 'package:provider/provider.dart';
import 'package:yachtoncloud/theme/colors.dart';
import 'navigation_provider.dart';

void main() {
  runApp(const SetAlertPage());
}


class SetAlertPage extends StatelessWidget {
  const SetAlertPage({Key? key}) : super(key: key);

  final int selectedRadio = 0;
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
          home: const SetAlertPage_(title: 'Flutter Demo Home Page'),
        ),
      );
}

class SetAlertPage_ extends StatefulWidget {
  const SetAlertPage_({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SetAlertPage_> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SetAlertPage_> {
  final TextEditingController migliaController = new TextEditingController();
  int val = -1;

Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                hintText: 'Miglia personalizzate',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  fillColor: fieldTextColor,
                  filled: true))
        ],
      ),
    );
  }
    Widget _migliaWidget() {
    return _entryField("", migliaController);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    
    return Template(
      appBarTitle: 'Yacht on Cloud',
      boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [backgroundColor2, backgroundColor1])),
      child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 100.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 10),
                child:Align( alignment: Alignment.centerLeft, child: Text(
                            "Imposta notifica di movimento",
                            style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  ))),
                  Align( alignment: Alignment.centerLeft, child:Padding( padding: EdgeInsets.only(bottom: 7), 
                            child: Text(
                              'Imposta miglia',
                              style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                            ),
                          )), 
            SizedBox(
              height: 10,
          ),
             Container(
          height: 326,
              //width: double.infinity,
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
              child: Column( children: [ 
            Padding(
                padding: EdgeInsets.all(10), child: Column( children: [ RadioListTile<int>(
              value: 1,
              groupValue: val,
              title: Text("5 miglia",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal))),
              onChanged: (value) {
                setState(() {
                  val = value!;
                  //selected: true;
                });
              },
              activeColor: activeColorRadio,
            ),
            RadioListTile<int>(
              value: 2,
              groupValue: val,
              title: Text("10 miglia",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal))),
              onChanged: (value) {
                setState(() {
                  val = value!;
                  //selected:true;
                });
              },
              activeColor: activeColorRadio,
            ),
            RadioListTile<int>(
              value: 3,
              groupValue: val,
              title: Text("15 miglia",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal))),
              onChanged: (value) {
                setState(() {
                  val = value!;
                  //selected:true;
                });
              },
              activeColor: activeColorRadio,
            ),
            RadioListTile<int>(
              value: 4,
              groupValue: val,
              title: Text("Disattiva",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal))),
              onChanged: (value) {
                setState(() {
                  val = value!;
                  //selected:true;
                });
              },
              activeColor: activeColorRadio,
            )])),  
            Center(
              child: Container(
                width: size.width - 150,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: _migliaWidget()
              ),
            ),
            SizedBox(height: 20),   
          ],
        )),
        SizedBox(height: 10),
        Center( child: Container(
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
        onPressed: () {
               
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
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    )),
          ])),
    ));
  }
}
