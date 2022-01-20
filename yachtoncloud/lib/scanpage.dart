/*import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late String qrCodeResult = "";

  bool backCamera = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Scan using:" + (backCamera ? "Front Cam" : "Back Cam")),
          actions: <Widget>[
            IconButton(
              icon: backCamera
                  ? Icon(Ionicons.ios_camera_reverse)
                  : Icon(Icons.camera),
              onPressed: () {
                setState(() {
                  backCamera = !backCamera;
                  camera = backCamera ? 1 : -1;
                });
              },
            ),
            IconButton(
              icon: Icon(MaterialCommunityIcons.qrcode_scan),
              onPressed: () async {
                ScanResult codeSanner = await BarcodeScanner.scan(
                  options: ScanOptions(
                    useCamera: camera,
                  ),
                ); //barcode scnner
                setState(() {
                  qrCodeResult = codeSanner.rawContent;
                });
              },
            )
          ],
        ),
        body: Center(
          child: Text(
            (qrCodeResult == null)||(qrCodeResult == "")
                ? "Please Scan to show some result"
                : "Result:" + qrCodeResult,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
          ),
        ));
  }
}

int camera = 1;*/

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
                    borderColor: Colors.teal,
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

  void onQRViewCreated(QRViewController p1) 
{
//called when View gets created. 
    this.controller = p1;
    controller.scannedDataStream.listen((scanData) async {
       controller.pauseCamera();
      setState(() {
        result = scanData.code ?? '';;
      });
      debugPrint("QUESTO FUNZIONA " + result);
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
