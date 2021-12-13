// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:yachtoncloud/drawer.dart';
import 'package:yachtoncloud/navigation_provider.dart';
import 'package:yachtoncloud/template.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: unused_field
  int _counter = 0;
  int crnLevel = 0;
  String testo =
      'Benvenuto, per cominciare ad utilizzare Yacht on Cloud, puoi utilizzare il seguente link ed associare una nuova box';
  String newText = "Benvenuto, Checo Legend Perez";

  // ignore: unused_element

  @override
  Widget build(BuildContext context) {
    return Template(
        boxDecoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color(0xFF00CCFF),
                const Color(0xFF3366FF),
              ],
              begin: const FractionalOffset(0.0, 2.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(35.0, 70.0, 35.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  _counter == 0 ? testo.toString() : newText.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2.0,
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Yacht-bro.png',
                      height: 300,
                      width: 250,
                    ),
                  ],
                ),
              ),
              //Divider(height: 60.0, color: Colors.grey[500]),

              //Space from different widget
              SizedBox(height: 10.0),

              Container(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      _counter == 1 ? _counter = 0 : _counter = 1;
                    });
                  },
                  child: Text(
                    'Associa Box',
                    style: TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                        letterSpacing: 2.0),
                  ),
                ),
                /*child: Text(
                'Associa una nuova box',
                style: TextStyle(
                    color: Colors.orange[600],
                    letterSpacing: 1.0,
                    fontSize: 20.0,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.normal),
              ),*/
              ),

              SizedBox(height: 30.0),
            ],
          ),
        ),
        appBarTitle: "Yacht on Cloud");
  }
}
