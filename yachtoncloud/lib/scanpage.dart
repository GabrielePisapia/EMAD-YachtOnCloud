import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
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
  final GlobalKey qrKey = GlobalKey();
  late QRViewController controller;
  String result = "";
//in order to get hot reload to work.
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
      await addBox(jsonDecode(result));
      Navigator.pop(context);
    });
  }

  Future addBox(Map<String, dynamic> result) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('Utenti');
    FirebaseFirestore.instance
        .collection('Utenti')
        .doc(uid)
        .get()
        .then((querySnapshot) {
      if (!querySnapshot.data()!.containsKey("boxes")) {
        //debugPrint("ok, non c'è proprio il campo box " + uid);
        return users.doc(uid).update({
          'boxes': [result]
        });
      } else {
        debugPrint("ok, c'è almeno una box " + uid);
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
          //a quanto pare se metti lo stesso oggetto, ti dà successo a prescindere lmao
          return true;
        }).catchError((error) {
          debugPrint("Error!" + error.toString());
          return false;
        });
      }
    });
    //debugPrint("inserisco la box " + uid);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
