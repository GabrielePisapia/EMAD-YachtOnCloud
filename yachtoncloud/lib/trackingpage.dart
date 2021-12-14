import 'package:flutter/material.dart';
import 'package:yachtoncloud/SetAlert.dart';
import 'package:yachtoncloud/template.dart';
import 'package:provider/provider.dart';

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
    return Template(
      appBarTitle: "Yacht on Cloud",
      child: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Attualmente ti trovi qui:',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
              child: Center(
                child: Container(
                    width: 450,
                    height: 300,
                    child: Image.asset('assets/gpsmap.jpg')),
              ),
            ),
            Center(
              child: Container(
                height: 45,
                width: 230,
                decoration: BoxDecoration(
                    color: Colors.orange[300],
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SetAlertPage(),
                    ));
                    // Respond to button press
                  },
                  child: Text(
                    'Imposta notifica di movimento',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
