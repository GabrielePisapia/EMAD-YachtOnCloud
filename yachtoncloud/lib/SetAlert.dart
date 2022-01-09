import 'package:flutter/material.dart';
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SetAlertPage_> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SetAlertPage_> {
  // ignore: unused_field

  int val = -1;

  /*
onChange(int value) {
  setState(() {
    selectedRadioTile = value;
  });
}*/

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    
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
                            style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                  ))),
                  Align( alignment: Alignment.centerLeft, child:Padding( padding: EdgeInsets.only(bottom: 7), 
                            child: Text(
                              'Imposta miglia',
                              style: TextStyle(
                                    color: textColor,
                                    letterSpacing: 1.0,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                            ),
                          )), 
            SizedBox(
              height: 10,
          ),
             Container(
          height: 319,
              //width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
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
              child: Column( children: [ /*Center(
                child: Text(
              'Imposta miglia:',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),*/
            //SizedBox(height: 5),
            Padding(
                padding: EdgeInsets.all(10), child: Column( children: [ RadioListTile<int>(
              value: 1,
              groupValue: val,
              title: Text("5 miglia",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              onChanged: (value) {
                setState(() {
                  val = value!;
                  //selected: true;
                });
              },
              activeColor: Colors.orange[200],
            ),
            RadioListTile<int>(
              value: 2,
              groupValue: val,
              title: Text("10 miglia",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              onChanged: (value) {
                setState(() {
                  val = value!;
                  //selected:true;
                });
              },
              activeColor: Colors.orange[200],
            ),
            RadioListTile<int>(
              value: 3,
              groupValue: val,
              title: Text("15 miglia",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              onChanged: (value) {
                setState(() {
                  val = value!;
                  //selected:true;
                });
              },
              activeColor: Colors.orange[200],
            ),
            RadioListTile<int>(
              value: 4,
              groupValue: val,
              title: Text("Disattiva",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              onChanged: (value) {
                setState(() {
                  val = value!;
                  //selected:true;
                });
              },
              activeColor: Colors.orange[200],
            )])),  
            Center(
              child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Miglia personalizzate',
                    fillColor: Colors.orange[300],
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),   
          ],
        )),
        SizedBox(height: 10),
        Center( child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(18.0),
                         side: BorderSide(color: buttonColor)))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SetAlertPage(),
                ));
              },
              child: Text(
                'Imposta notifica di movimento',
                style: TextStyle(color: textColor),
              ),
          )),
          ])),
    ));
  }
}
