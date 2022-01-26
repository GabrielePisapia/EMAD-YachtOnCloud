import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          home: const TrackingPage_(),
        ),
      );
}

class TrackingPage_ extends StatefulWidget {
  const TrackingPage_({Key? key}) : super(key: key);

  @override
  State<TrackingPage_> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TrackingPage_> {
  late LatLng currentPos;
  late LatLng visionPos;

  Future<DocumentSnapshot<Map<String, dynamic>>> getLatLong() async {
    debugPrint("Ma almeno ci arrivo qua?");
    final uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Utenti');
    return await FirebaseFirestore.instance.collection('Utenti').doc(uid).get();
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
      child: new Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Positioned( child: Container(
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
              width: double.infinity,
              height: double.infinity,
              child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: getLatLong(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snap) {
                if(snap.connectionState == ConnectionState.waiting) {
                  return Center( child: CircularProgressIndicator(color: appBarColor1), );
                } else {
                    debugPrint("Non devo più aspettare");
                    currentPos = LatLng(snap.data?.data()!['boxes'][0]['box']['gps']['currentPosition']['lat'], 
                      snap.data?.data()!['boxes'][0]['box']['gps']['currentPosition']['long']);
                    visionPos = currentPos;
                  return FlutterMap(
                        options: MapOptions(
                          center: visionPos,
                          zoom: 16,
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
                                point: currentPos,
                                builder: (ctx) =>
                                Container(
                                  child: Image.asset(
                                    'assets/yacht.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );}}),
                    )),
                    // ),
                    //),
            Positioned( top: size.height - 100, child: Center(
              child: Container(
                     width: 250,
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 1),
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: buttonColor)))),
        onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SetAlertPage()),
                );
              },
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Imposta notifica',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    ))),
          ],
        ),
      //),
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

