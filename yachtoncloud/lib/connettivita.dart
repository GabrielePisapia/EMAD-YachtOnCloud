import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:provider/provider.dart';
import 'navigation_provider.dart';
import 'template.dart';

void main() {
  runApp(const Connettivita());
}

class ChartData {
        ChartData(String x, double y, Color? color) {
          this.x = x;
          this.y = y;
          this.color = color!;
        }
            late final String x;
            late final double y;
            late final Color color;
    }

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
    Widget build(BuildContext context) {
    return getBody(context);
  }


Widget getBody(BuildContext context) {

   final List<Color> gradientColors = [
      const Color(0xFFFF8F00),
      const Color(0xFFFFA737),
    ];

    final List<ChartData> chartData = [
            ChartData('Consumati', 150, Colors.blue),
            ChartData('Restanti', 50, Color(0xFFFF5E00)),
        ];
    final _myList = List.generate(5, (index) => 'dispositivo num. $index');
    ScrollController _controller = new ScrollController();
    
    _scrollListener() {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(()  {//you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
      }
    }
  @override
   void initState() {
      _controller = ScrollController();
      _controller.addListener(_scrollListener);//the listener for up and down. 
     super.initState();
    }
    
    var size = MediaQuery.of(context).size;

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
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFFF5E00).withOpacity(0.01),
                      spreadRadius: 5,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TIM - Promozione bella",
                            style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "\200GB",
                            style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: (size.width - 20),
                        height: 150,
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(
                                show: true,
                                drawHorizontalLine: true,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: Colors.white,
                                    strokeWidth: 0.1,
                                  );
                                }),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 22,
                                getTextStyles: (value) =>  const TextStyle(color: Colors.white, fontSize: 12),
                                    //const TextStyle(color: Colors.white, fontSize: 12),
                                getTitles: (value) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return 'LUN';
                                    case 3:
                                      return 'GIO';
                                    case 6:
                                      return 'DOM';
                                  }
                                  return '';
                                },
                                margin: 8,
                              ),
                              leftTitles: SideTitles(
                                showTitles: true,
                                getTextStyles: (value) => const TextStyle(color: Colors.white, fontSize: 12,),
                                getTitles: (value) {
                                  switch (value.toInt()) {
                                    case 1:
                                      return '10GB';
                                    case 3:
                                      return '50GB';
                                    case 5:
                                      return '100GB';
                                  }
                                  return '';
                                },
                                reservedSize: 35,
                                margin: 10,
                              ),
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            minX: 0,
                            maxX: 8,
                            minY: 0,
                            maxY: 6,
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 1.2),
                                  FlSpot(2.1, 2.2),
                                  FlSpot(2.8, 4.7),
                                  FlSpot(4.9, 2.1),
                                  FlSpot(6, 4),
                                  FlSpot(8, 5.7),
                                ],
                                isCurved: true,
                                colors: gradientColors,
                                barWidth: 3,
                                isStrokeCapRound: true,
                                dotData: FlDotData(
                                  show: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [ Container(
                  margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  width: (size.width - 40),
                  height: 190,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF00CCFF).withOpacity(0.01),
                          spreadRadius: 10,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 20, bottom: 5),
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding( padding: EdgeInsets.only(bottom: 5), 
                            child: Text(
                              'Dispositivi connessi',
                              style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox( height: 114, child: CustomScrollView(
                            controller: _controller,
                              slivers: [
                                SliverList(
                                   delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return SizedBox( height: 45, width: (size.width - 10) / 2, child:Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                      ),
                                      child: ListTile(
                                        visualDensity: VisualDensity(horizontal: -3, vertical: -4),
                                        leading:  Container(
                                          height: double.infinity,
                                          child:
                                             Container(padding: const EdgeInsets.all(0.0), child: Icon(Icons.smartphone, size: 19.0, color: Colors.white)),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0)),
                                        tileColor: Colors.orange[300],
                                        title: Text(
                                          _myList[index],
                                          style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                        ),
                                        //subtitle: Text('${person.age}'),
                                      ),
                                    ));
                                  },
                                  childCount: _myList.length,
                                ))
                              ],
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
              ),
              SizedBox(
                height: 20,
              ),
            Container(
                  margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  width: (size.width - 40),
                  height: 203,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF00CCFF).withOpacity(0.01),
                          spreadRadius: 10,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                  child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding( padding: const EdgeInsets.only(
                                left: 25, right: 25, top: 20, bottom: 5),
                                child: Text(
                              'Consumi',
                              style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                            )),
                            SizedBox( height: 150,
                              child: SfCircularChart(
                                legend: Legend(
                                  toggleSeriesVisibility: false,
                                  isVisible: true,
                                  textStyle: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.white,
                                  )),
                                series: <CircularSeries>[
                                // Renders doughnut chart
                                DoughnutSeries<ChartData, String>(
                                dataSource: chartData,
                                pointColorMapper:(ChartData data,  _) => data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                //explode: true,
                                //explodeIndex: 1,
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    textStyle: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.white,
                                    ),
                                    // Positioning the data label
                                    labelPosition: ChartDataLabelPosition.outside,
                                )
                            )
                        ]
                    )
                            )
                          ],
                        )
                      ],
                    ),
                  ),
            ]
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(18.0),
                         side: BorderSide(color: Colors.blue)))),
              onPressed: null,
              child: Text(
                'Impostazioni connettività',
                style: TextStyle(color: Colors.white),
              ),
          ),
        ],
      ),
    )])));
}
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
          getTextStyles: (value) => const TextStyle(
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
          getTextStyles: (value) => const TextStyle(
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

