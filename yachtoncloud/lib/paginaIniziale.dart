// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yachtoncloud/drawer.dart';
import 'package:yachtoncloud/navigation_provider.dart';
import 'package:yachtoncloud/template.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yachtoncloud/theme/colors.dart';

void main() {
  runApp(const PaginaIniziale());
}

class PaginaIniziale extends StatelessWidget {
  const PaginaIniziale({Key? key}) : super(key: key);

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
          home: const AssociaBox(title: 'Flutter Demo Home Page'),
        ),
      );
}

class AssociaBox extends StatefulWidget {
  const AssociaBox({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<AssociaBox> createState() => _AssociaBoxState();
}

class _AssociaBoxState extends State<AssociaBox> {
  // ignore: unused_field
  var createGrid = 0;
  void bb() {
    print('Clicked Clicked');

    setState(() {
      createGrid = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cardTextStyle = GoogleFonts.poppins(
                        textStyle: TextStyle(
                        color: textColorDashboard,
                        fontSize: 12,
                        fontWeight: FontWeight.bold));
    var textList = [
      "Videosorveglianza",
      "Impostazioni \nvideosorveglianza",
      "Storico \nregistrazioni",
      "Connettività",
      "Impostazioni \nconnettività",
      "Tracking GPS",
      "Notifica di movimento"
    ];
    var assetsList = [
      "video-camera.png",
      "setting.png",
      "list.png",
      "smartphone.png",
      "settingwifi.png",
      "compass.png",
      "job.png"
    ];

    var myGridView = new GridView.builder(
        itemCount: assetsList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return new GestureDetector(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/${assetsList[index]}",
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    textList[index],
                    style: cardTextStyle,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          );
        });

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
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 200.0,
              decoration: new BoxDecoration(
                color: Color(0xff508FF7),
                boxShadow: [
                  new BoxShadow(
                    blurRadius: 40.0,
                  )
                ],
                borderRadius: new BorderRadius.vertical(
                    bottom: new Radius.elliptical(
                        MediaQuery.of(context).size.width, 100.0)),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      height: 64,
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dashboard",
                                style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold))
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    createGrid == 1
                        ? Expanded(child: myGridView)
                        : Center(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 60,
                              child: InkWell(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/qr-code.png",
                                      width: 200,
                                      height: 150,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Associa box",
                                      style: cardTextStyle,
                                    ),
                                  ],
                                ),
                                /*onTap: ()async {
                                  showDialog(context: context, builder: builder)
                                  bb();
                                },*/
                                onTap: () async {
                                  // mark the function as async
                                  print('tap');
                                  // Show PopUp

                                  // await the dialog
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Text(
                                              "Associazione box riuscita",
                                              style: cardTextStyle),
                                        ),
                                        actions: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                  "assets/check.png",
                                                  width: 80,
                                                  height: 80,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                    // Doesn't run
                                  );

                                  bb();
                                },
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
