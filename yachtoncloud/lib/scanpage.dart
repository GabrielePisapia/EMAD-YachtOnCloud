import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:yachtoncloud/dashboard.dart';
import 'package:yachtoncloud/theme/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scan QR Code - Flutter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScanPage(),
    );
  }
}

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  var newBox = 0;
  final GlobalKey qrKey = GlobalKey();
  late QRViewController controller;
  String result = "";
//in order to get hot reload to work.

  checkPermission() async {
    var status = await Permission.photos.status;
    if (status.isGranted) {
      debugPrint("granted");
    } else {
      debugPrint("sto nell'else");
      await showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text('Camera Permission'),
                content: Text('This app needs camera'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('Deny'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                      child: Text('Settings'),
                      onPressed: () async {
                        await openAppSettings().then((value) {
                          if (status.isGranted) {
                            debugPrint("tutt appost o bro");
                          }
                        });
                      }),
                ],
              ));
      //await Permission.camera.request().isGranted;
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: checkPermission(),
        builder: (BuildContext context, AsyncSnapshot<void> snap) {
          if (snap.connectionState != ConnectionState.done) {
            debugPrint(snap.toString());
            return Center(
              child: CircularProgressIndicator(color: appBarColor1),
            );
          } else if (snap.connectionState == ConnectionState.done) {
            debugPrint("Non devo pi?? aspettare");
            return Scaffold(
              //appBar: AppBar(
              //title: Text('Scan QR Code - Flutter Example'),
              //),
              body: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Stack(
                      children: [
                        QRView(
                          key: qrKey,
                          onQRViewCreated: onQRViewCreated,
                          overlay: QrScannerOverlayShape(
//customizing scan area
                            borderWidth: 10,
                            borderColor: listElementColor,
                            borderLength: 20,
                            borderRadius: 10,
                            cutOutSize: MediaQuery.of(context).size.width * 0.8,
                          ),
                        ),
                        Positioned(
                          left: 0.0,
                          right: 0.0,
                          bottom: 0.0,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.flip_camera_ios,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      await controller.flipCamera();
                                    }),
                                IconButton(
                                    icon: Icon(
                                      Icons.flash_on,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      await controller.toggleFlash();
                                    })
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
                child: Text("Non so perch??: ${snap.error}",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold))));
          }
        });
  }

  void onQRViewCreated(QRViewController p1) {
//called when View gets created.
    this.controller = p1;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      setState(() {
        result = scanData.code ?? '';
        ;
      });
      debugPrint("QUESTO FUNZIONA " + result);
      bool resu  = await addBox(jsonDecode(result));
      debugPrint("Vediamo se mi ricordo ancora come si fa " + resu.toString());
      //Navigator.pop(context, res);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardBox(indice : newBox, scan : true, res : resu)),
       );
    });
  }

  Future<bool> addBox(Map<String, dynamic> result) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Utenti');
    return FirebaseFirestore.instance.collection('Utenti').doc(uid).get().then((querySnapshot) {
      if (!querySnapshot.data()!.containsKey("boxes")) {
        debugPrint("ok, non c'?? proprio il campo box " + uid);
        users.doc(uid).update({
          'boxes': [result]
        });
        return true;
      } else {
        debugPrint("ok, c'?? almeno una box " + uid);
        var val = false;
        List<dynamic> boxes = querySnapshot.data()!['boxes'];
        boxes.forEach((element) {
          if (element['box']['idBox'] == result['box']['idBox']) {
            debugPrint("SONO UGUALI");
            val = true;
          }
        });
        if (val == true) {
          debugPrint("NO ADD");
          return false;
        }
        users.doc(uid).update({
          "boxes": FieldValue.arrayUnion([result])
        }).then((res) {
          debugPrint("Success!");
          //a quanto pare se metti lo stesso oggetto, ti d?? successo a prescindere lmao
          newBox = result['box']['idBox'];
          return true;
        }).catchError((error) {
          debugPrint("Error!" + error.toString());
          return false;
        });
      }
      return false;
    });
    //return false;
    //debugPrint("inserisco la box " + uid);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
