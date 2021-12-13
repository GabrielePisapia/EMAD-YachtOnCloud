import 'package:flutter/material.dart';
import 'package:yachtoncloud/navigation_provider.dart';
import 'package:yachtoncloud/template.dart';
import 'package:provider/provider.dart';

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
  bool switchValue1 = false, switchValue2 = true;
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
            padding: const EdgeInsets.all(8.0),
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
                  TableCell(
                      child: Center(
                    child: RichText(
                        text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.settings,
                            color: Colors.grey[800],
                          ),
                        )
                      ],
                    )),
                  )),
                  SizedBox(
                    height: 20,
                    child: Switch(
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      value: switchValue1,
                      onChanged: (val) {
                        setState(() {
                          switchValue1 = val;
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
                  TableCell(
                      child: Center(
                    child: RichText(
                        text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.settings,
                            color: Colors.grey[800],
                          ),
                        )
                      ],
                    )),
                  )),
                  SizedBox(
                    height: 20,
                    child: Switch(
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      value: switchValue1,
                      onChanged: (val) {
                        setState(() {
                          switchValue1 = val;
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
                  TableCell(
                      child: Center(
                    child: RichText(
                        text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.settings,
                            color: Colors.grey[800],
                          ),
                        )
                      ],
                    )),
                  )),
                  SizedBox(
                    height: 20,
                    child: Switch(
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      value: switchValue1,
                      onChanged: (val) {
                        setState(() {
                          switchValue1 = val;
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
