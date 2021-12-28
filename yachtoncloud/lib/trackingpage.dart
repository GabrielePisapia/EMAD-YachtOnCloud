import 'package:flutter/material.dart';
import 'package:yachtoncloud/SetAlert.dart';
import 'package:yachtoncloud/template.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:yachtoncloud/theme/colors.dart';
import 'navigation_provider.dart';

void main() {
  runApp(const TrackingPage());
}

class TrackingPage extends StatelessWidget {
  const TrackingPage({Key? key}) : super(key: key);

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
          home: const TrackingPage_(title: 'Flutter Demo Home Page'),
        ),
      );
}

class TrackingPage_ extends StatefulWidget {
  const TrackingPage_({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TrackingPage_> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TrackingPage_> {
  // ignore: unused_field
  int _counter = 0;
  int crnLevel = 0;

  // ignore: unused_element
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    TileLayerOptions openStreetMap = TileLayerOptions(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    attributionBuilder: (_) {
                      return Text("© OpenSeaMap and OpenStreetMap");
                    },
                  );

    TileLayerOptions openSeaMarks = TileLayerOptions(
                    urlTemplate: "http://tiles.openseamap.org/seamark/{z}/{x}/{y}.png",
                    backgroundColor: Colors.transparent
                  );

    return Template(
      appBarTitle: "Yacht on Cloud",
      child: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Attualmente ti trovi qui:',
                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
              child: Center(
                child: Container(
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
              width: size.width - 20,
              height: size.height - 250,
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(40.55, 14.216667),
                  zoom: 11,
                ),
                layers: [
                  //openSeaMarks,
                  openStreetMap,
                  openSeaMarks,
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 20.0,
                        height: 20.0,
                        point: LatLng(40.55, 14.216667),
                        builder: (ctx) =>
                        Container(
                          child: FlutterLogo(),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ),
              ),
            ),
            Center(
              child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(18.0),
                         side: BorderSide(color: buttonColor)))),
              onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SetAlertPage(),
                    ));
                    // Respond to button press
                  },
              child: Text(
                'Imposta notifica di movimento',
                style: TextStyle(color: textColor),
              ),
          )),
          ],
        ),
      ),
      boxDecoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0XFF6dd5ed),
              Color(0XFF2193b0),
            ],
            begin: FractionalOffset(0.0, 2.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
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
