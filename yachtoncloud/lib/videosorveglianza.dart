import 'package:flutter/material.dart';

import 'package:yachtoncloud/navigation_provider.dart';
import 'package:yachtoncloud/statovideocamere.dart';
import 'package:yachtoncloud/storicoregistrazioni.dart';
import 'package:yachtoncloud/template.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const mainVideo_());
}

class mainVideo_ extends StatelessWidget {
  const mainVideo_({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => NavigationProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: const mainVideo(title: 'Flutter Demo Home Page'),
        ),
      );
}

class mainVideo extends StatefulWidget {
  const mainVideo({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _mainVideoState createState() => _mainVideoState();
}

class _mainVideoState extends State<mainVideo> {
  final names = [
    "Videosorveglianza1",
    "Videosorveglianza2",
    "Videosorveglianza3",
    "Videosorveglianza4",
    "Videosorveglianza5",
  ];
  @override
  Widget build(BuildContext context) {
    return Template(
        boxDecoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color(0xFF00CCFF),
                Colors.blue,
              ],
              begin: const FractionalOffset(0.0, 2.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 30, 200, 0),
                            child: Text(
                              names[index].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(35.0, 0, 35.0, 0),
                            width: double.infinity,
                            height: 150,
                            child: Card(
                              child: Container(
                                height: 150,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/Webinar-pana.png'))),
                              ),
                              margin: EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 15.0),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffA5FECB)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.blue)))),
                            onPressed: null,
                            child: Text(
                              'Clicca per visualizzare il video',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue)))),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const storicoReg(),
                  ));
                  // Respond to button press
                },
                child: Text(
                  'Storico registrazioni',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue)))),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const statoVideocamere(),
                  ));
                  // Respond to button press
                },
                child: Text(
                  'Vai alle impostazioni',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        appBarTitle: "Yacht on Cloud");
  }
}
