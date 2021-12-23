import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:provider/provider.dart';
import 'package:yachtoncloud/theme/colors.dart';
import 'navigation_provider.dart';
import 'template.dart';
import 'package:flutter/foundation.dart';

bool _obscureText = true;
bool isSwitched = true;

class ChartData {
        ChartData(String x, int y, Color? color) {
          this.x = x;
          this.y = y;
          this.color = color!;
        }
            late final String x;
            late final int y;
            late final Color color;
    }

class DetailsConnettivita extends StatefulWidget {
  @override
  _DetailsConnettivitaState createState() => _DetailsConnettivitaState();
}

class _DetailsConnettivitaState extends State<DetailsConnettivita> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

     ScrollController _controller = ScrollController();

    _scrollListener() {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
        });
      }
    }

    void initState() {
      _controller = ScrollController();
      _controller.addListener(_scrollListener);//the listener for up and down. 
      super.initState();
    }

    return Template(
      appBarTitle: 'Yacht on Cloud',
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              backgroundColor1,
              backgroundColor2,
            ],
            begin: const FractionalOffset(0.0, 2.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: SingleChildScrollView(
      child: Column(children:[ Padding(
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 5.0),
        child: Column(children:[
        Padding(
                padding: EdgeInsets.only(bottom: 10),
                child:Align( alignment: Alignment.centerLeft, child: Text(
                            "YachtZ25",
                            style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                  ))),
                  Align( alignment: Alignment.centerLeft, child:Padding( padding: EdgeInsets.only(bottom: 7), 
                            child: Text(
                              'Status rete',
                              style: TextStyle(
                                    color: textColor,
                                    letterSpacing: 1.0,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                            ),
                          )), 
                  Container(
          height: 100,
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
              child: Column(
          children: [ 
            
           Padding( padding:  EdgeInsets.only(top: 20, left: 20, right: 20), 
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Expanded(child: Image.asset(
                      isSwitched ? 'assets/wifiON.png' : 'assets/wifiOFF.png',
                      height: 50,
                      width: 50,
                    )),
                    
                    Expanded( child: Column(children: [
                      Center( child: Text(
                            "Status: " + (isSwitched ? "Attivo" : "Disattivo"),
                            style: TextStyle(
                                    color: textColor,
                                    letterSpacing: 1.0,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                  )),
                      Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                print(isSwitched);
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
                    ]))
                  ]))])),
                  SizedBox(
              height: 15,
          ), 
          Align( alignment: Alignment.centerLeft, child:Padding( padding: EdgeInsets.only(bottom: 7), 
                            child: Text(
                              'Nome e password',
                              style: TextStyle(
                                    color: textColor,
                                    letterSpacing: 1.0,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                            ),
                          )), 
          Container(
          height: 160,
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
              child:Column( children: [ 
                Padding( padding:  EdgeInsets.only(top: 20, left: 20, right: 20), child: Container(
                      //width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextFormField(
                        //initialValue: 'Yachtz25',
                        decoration: InputDecoration(
                          hintText: 'Yachtz25',
                          fillColor: listElementColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                      ),
                    )),
             SizedBox(
              height: 20,
          ), 
            Padding( padding:  EdgeInsets.only(left: 20, right: 20), child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextFormField(
                            autocorrect: false,
                            obscureText: _obscureText,
                            initialValue: 'Password',
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                            onPressed: ()  {
                              setState(() {
                                debugPrint('prechange: '+ _obscureText.toString());
                              _obscureText = !_obscureText;
                             debugPrint('postchange: '+ _obscureText.toString());
                            
                            });}),
                          hintText: 'Password',
                          fillColor: listElementColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                      ),
                    )),      
          ],
        ),
        )])),
      TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(18.0),
                         side: BorderSide(color: buttonColor)))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsConnettivita()),
                );
              },
              child: Text(
                'Conferma modifiche',
                style: TextStyle(color: textColor),
              ),
          ),]),
      ));
  }
}

class Connettivita extends StatefulWidget {
  @override
  _ConnettivitaState createState() => _ConnettivitaState();
}

class _ConnettivitaState extends State<Connettivita> {

  // This widget is the root of your application.
  @override
    Widget build(BuildContext context) {
    return getBody(context);
  }


Widget getBody(BuildContext context) {

   final List<Color> gradientColors = [
      chartColor1,
      chartColor2,
    ];

    final List<ChartData> chartData = [
            ChartData('Consumati', 75, chartColor1),
            ChartData('Restanti', 125, chartColor2),
        ];
    final _myList = List.generate(5, (index) => 'dispositivo num. $index');
    ScrollController _controller = ScrollController();

    _scrollListener() {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
        });
      }
    }

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
              backgroundColor1,
              backgroundColor2,
            ],
            begin: const FractionalOffset(0.0, 2.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: /*Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [*/SingleChildScrollView(
      child: Column(
        children: [
          Padding(
                padding: EdgeInsets.only(left: 10),
                child: Align( alignment: Alignment.centerLeft, child: Text(
                            "YachtZ25",
                            style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                  )),
          ),
          SizedBox(
              height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: Container(
              width: double.infinity,
              height: 250,
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
                                getTextStyles: (value) =>  const TextStyle(color: textColor, fontSize: 12),
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
                                getTextStyles: (value) => const TextStyle(color: textColor, fontSize: 12,),
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
            height: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align( alignment: Alignment.centerLeft, child:Padding( padding: EdgeInsets.only(left: 10, bottom: 7), 
                            child: Text(
                              'Dispositivi connessi',
                              style: TextStyle(
                                    color: textColor,
                                    letterSpacing: 1.0,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                            ),
                          )), 
                Container(
                  margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  width: (size.width - 40),
                  height: 160,
                  decoration: BoxDecoration(
                      color: cardsColor1,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: shadowCard.withOpacity(0.01),
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
                                             Container(padding: const EdgeInsets.all(0.0), child: Icon(Icons.smartphone, size: 19.0, color: textColor)),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0)),
                                        tileColor: listElementColor,
                                        title: Text(
                                          _myList[index],
                                          style: TextStyle(
                                    color: textColor,
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
                height: 10,
              ),
              Align( alignment: Alignment.centerLeft, child:Padding( padding: EdgeInsets.only(left: 10, bottom: 7), 
                            child: Text(
                              'Consumi',
                              style: TextStyle(
                                    color: textColor,
                                    letterSpacing: 1.0,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                            ),
                          )),
            Container(
                  margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  width: (size.width - 40),
                  height: 150,
                  decoration: BoxDecoration(
                      color: cardsColor1,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: shadowCard.withOpacity(0.01),
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
                            SizedBox( height: 140,
                            width: (size.width - 40),
                              child: SfCircularChart(
                                legend: Legend(
                                  toggleSeriesVisibility: false,
                                  isVisible: true,
                                  textStyle: TextStyle(
                                    fontSize: 10.2,
                                    letterSpacing: 1.0,
                                    color: textColor,
                                  )),
                                series: <CircularSeries>[
                                // Renders doughnut chart
                                DoughnutSeries<ChartData, String>(
                                dataSource: chartData,
                                pointColorMapper:(ChartData data,  _) => data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    textStyle: TextStyle(
                                      fontSize: 10,
                                      letterSpacing: 1.0,
                                      color: textColor,
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
              backgroundColor: MaterialStateProperty.all(buttonColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(18.0),
                         side: BorderSide(color: buttonColor)))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsConnettivita()),
                );
              },
              child: Text(
                'Impostazioni connettività',
                style: TextStyle(color: textColor),
              ),
          ),
        ],
      ),
    /*)]*/)));
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

