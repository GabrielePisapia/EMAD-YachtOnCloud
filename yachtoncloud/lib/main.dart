// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yachtoncloud/PushNotification.dart';

import 'package:yachtoncloud/dashboard.dart';
import 'package:yachtoncloud/drawer.dart';
import 'package:yachtoncloud/google_sign_in.dart';
import 'package:latlong2/latlong.dart';

import 'package:yachtoncloud/navigation_provider.dart';
import 'package:yachtoncloud/newSignup.dart';
import 'package:yachtoncloud/newWelcomePage.dart';
import 'package:yachtoncloud/paginaIniziale.dart';
import 'package:yachtoncloud/statovideocamere.dart';
import 'package:yachtoncloud/template.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:workmanager/workmanager.dart';

const myTask = "syncWithTheBackEnd";
const task2 = "task";
Workmanager wm = Workmanager();
Widget homepage = WelcomePage();

void callbackDispatcher() {
// this method will be called every hour

  wm.executeTask((task, inputdata) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    print('Execute task');
    print('TASK: ' + task);
    switch (task) {
      case myTask:
        print('TASK 1');
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp();
        String uidUser = inputdata!['string'];
        print('UID NEL TASK: ' + uidUser);
        var snap = await FirebaseFirestore.instance
            .collection('Utenti')
            .doc(uidUser)
            .get();
        print('SNAP: ' + snap.toString());
        var currentPos = LatLng(
            snap.data()!['boxes'][0]['box']['gps']['currentPosition']['lat'],
            snap.data()!['boxes'][0]['box']['gps']['currentPosition']['long']);
        print('%%%%%%%%%%%%%%%%%%%%' + currentPos.toString());

        break;

      case Workmanager.iOSBackgroundTask:
        print("iOS background fetch delegate ran");
        break;

      case task2:
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp();
        print('CASO 2');
        print(inputdata);
        String uidUser = inputdata!['string'];
        print('UID NEL TASK: ' + uidUser);
        var snap = await FirebaseFirestore.instance
            .collection('Utenti')
            .doc(uidUser)
            .get();
        print('SNAP: ' + snap.toString());
        var currentPos = LatLng(
            snap.data()!['boxes'][0]['box']['gps']['currentPosition']['lat'],
            snap.data()!['boxes'][0]['box']['gps']['currentPosition']['long']);
        print('%%%%%%%%%%%%%%%%%%%%' + currentPos.toString());

        break;
    }

    //Return true when the task executed successfully or not
    return Future.value(true);
  });
}

Future<void> main() async {
  print('qua eseguo main');
  DateTime now = DateTime.now();
  print(now.hour.toString() +
      ":" +
      now.minute.toString() +
      ":" +
      now.second.toString());
  //wm.registerPeriodicTask("Tester", taskName, frequency: Duration(minutes:1 ),inputData:{"data1":"hello"} );
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  wm.initialize(callbackDispatcher);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? uid = prefs.getString("uid");
  print("######### prima dell'if" + uid.toString());
  if (uid != null) {
    print('############' + uid);
    wm.registerOneOffTask("1", myTask,
        initialDelay: Duration(seconds: 1),
        inputData: {'string': uid.toString()});
    //wm.registerPeriodicTask("2",task2,inputData: {'string':uid.toString()},);
    homepage = AssociaBox(creaGrid: 0);
    print("Homepage  ${homepage}");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final storage = new FlutterSecureStorage();

  // This widget is the root of your application.
  /*
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => NavigationProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: registrationPage(error2: ""),
        ),
      );
}*/

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(
          create: (_) => GoogleSignInProvider(),
        )
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: homepage,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  var title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    print('qua eseguo myapp extends statless widget');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_lancher',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new messageopen app event was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("${notification.title}"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("${notification.body}")],
                  ),
                ),
              );
            });
      }
    });

    print('ok');
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing ",
        "This is an Flutter Push Notification",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YachtOnCloud',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
    );
  }
}
