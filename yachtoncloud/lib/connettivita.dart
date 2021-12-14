import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:provider/provider.dart';

import 'navigation_provider.dart';
import 'template.dart';

void main() {
  runApp(const Connettivita());
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      const Color(0xFFFF8F00),
      const Color(0xFFFFA737),
    ];

    return Template(
      appBarTitle: 'Yacht on Cloud',
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xFF00CCFF),
              Colors.red,
            ],
            begin: const FractionalOffset(0.0, 2.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        child: Column(
          children: [
            Center(
                child: Column(children: [
              Text(
                'Dettagli connettivià',
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 10.0),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Nome rete',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                        fontSize: 17,
                        fontWeight: FontWeight.normal)),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange[300])),
                    onPressed: () {
                      // Navigate back to first route when tapped.
                    },
                    child: Text('Modifica nome')),
              ])
            ])),

            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.orange[300])),
                onPressed: () {
                  // Navigate back to first route when tapped.
                },
                child: Text('Modifica password')),

            Text(
              'TIM',
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
            ),

            SizedBox(height: 15.0),
            Text(
              'Nome promozione e dettagli promozione',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 15.0),

            //Space from different widget

            //SizedBox(height: 30.0),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Powered by',
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.0,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Image.asset('assets/linear.png', height: 160, width: 250),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Connettivita extends StatelessWidget {
  const Connettivita({Key? key}) : super(key: key);

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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _myList = List.generate(5, (index) => ' dispositivo num. $index');

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      const Color(0xFFFF8F00),
      const Color(0xFFFFA737),
    ];

    return Template(
      appBarTitle: "Yacht on Cloud",
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
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Row(children: [
                Expanded(
                    child: Text(
                  'Nome rete:',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2.0,
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                )),
                Text(
                  'Yacht5ghz:',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2.0,
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                ),
                Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Ink(
                            decoration: const ShapeDecoration(
                              color: Color(0xFFFFA737),
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                                icon: Icon(Icons.settings),
                                color: Color(0xFFFF8F00),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SecondRoute()),
                                  );
                                }))))
              ]),
            ),

            SizedBox(height: 10.0),

            Center(
              child: Text(
                'Dispositivi collegati',
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              ),
            ),

            SizedBox(height: 15.0),

            Container(
                height: 100,
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.smartphone),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            tileColor: Colors.orange[300],
                            title: Text(
                              _myList[index],
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 2.0,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                            //subtitle: Text('${person.age}'),
                          ),
                        );
                      },
                      childCount: _myList.length,
                    ))
                  ],
                )),

            SizedBox(height: 45.0),

            Center(
              child: Text(
                'Consumi',
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              ),
            ),

            SizedBox(height: 25.0),

            Container(
                height: 200,
                width: 450,
                child: LineChart(LineChartData(
                    minX: 1,
                    maxX: 5,
                    minY: 0,
                    maxY: 10,
                    titlesData: LineTitles.getTitleData(),
                    gridData: FlGridData(
                      show: true,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: const Color(0xFF005B96),
                          strokeWidth: 1,
                        );
                      },
                      drawVerticalLine: true,
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: const Color(0xFF005B96),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border:
                          Border.all(color: const Color(0xFF005B96), width: 1),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(1, 3),
                          FlSpot(2, 2),
                          FlSpot(3, 5),
                          FlSpot(5, 2.5),
                        ],
                        isCurved: true,
                        colors: gradientColors,
                        barWidth: 3,
                        // dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          colors: gradientColors
                              .map((color) => color.withOpacity(0.4))
                              .toList(),
                        ),
                      ),
                    ]))),

            SizedBox(height: 15.0),

            //Space from different widget

            //SizedBox(height: 30.0),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Image.asset('assets/linear.png', height: 160, width: 250),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 20.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Menu',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 20.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Nome',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Email@example.com',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          )),
          ListTile(
            leading: Icon(
              Icons.wifi,
            ),
            title: Text('Connettività'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(
              Icons.video_settings_rounded,
            ),
            title: Text('Videosorveglianza'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(
              Icons.gps_fixed_outlined,
            ),
            title: Text('Tracking GPS'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.notification_important_rounded),
            title: Text('Notifica di movimento'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}

class LineTitles {
  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          getTextStyles: (context, value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 3:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 5:
                return '50GB';
              case 10:
                return '100GB';
            }
            return '';
          },
          reservedSize: 35,
          margin: 12,
        ),
      );
}
