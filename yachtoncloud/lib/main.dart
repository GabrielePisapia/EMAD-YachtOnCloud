// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:math';

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
import 'package:yachtoncloud/trackingpage.dart';

import 'NotificationApi.dart';

const myTask = "syncWithTheBackEnd";
const task2 = "task";
Workmanager wm = Workmanager();
Widget homepage = WelcomePage();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('A Background message just showed up :  ${message.messageId}');
}

void callNotification() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

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
  });
  print('ok');
}

void listenNotification() =>
    NotificationApi.onNotifications.stream.listen(onClickedNotification);
void onClickedNotification(String? payload) => Get.to(() => TrackingPage());
void callbackDispatcher() {
// this method will be called every hour
  NotificationApi.init();
  listenNotification();

  wm.executeTask((task, inputdata) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    NotificationApi.init();
    listenNotification();

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

        var lastPos = LatLng(
            snap.data()!['boxes'][0]['box']['gps']['positionAlert']['lat'],
            snap.data()!['boxes'][0]['box']['gps']['positionAlert']['long']);
        var currentPos = LatLng(
            snap.data()!['boxes'][0]['box']['gps']['currentPosition']['lat'],
            snap.data()!['boxes'][0]['box']['gps']['currentPosition']
                ['long']); //positionAlert posizione precedente
        var migliaAlert = snap.data()!['boxes'][0]['box']['gps']['migliaAlert'];

        print('MIGLIA ALERT: ' + migliaAlert.toString());
        print('LATITUDINEYYY: ' +
            currentPos.latitude.toString() +
            ' LONGITUDINE:  ' +
            currentPos.longitude.toString());
        print('LATITUDINEXXXX: ' +
            lastPos.latitude.toString() +
            ' LONGITUDINE:  ' +
            lastPos.longitude.toString());

        var miglia_To_Km = migliaAlert * 1.852;
        // funzione di calcolo
        currentPos.longitude = 14.949012;
        currentPos.latitude = 41.752122;
        var p = 0.017453292519943295;
        var c = cos;
        var a = 0.5 -
            c((currentPos.latitude - lastPos.latitude) * p) / 2 +
            c(lastPos.latitude * p) *
                c(currentPos.latitude * p) *
                (1 - c((currentPos.longitude - lastPos.longitude) * p)) /
                2;
        var result = 12742 * asin(sqrt(a));
        print('ATTESO 1138, RISULTATO: ' + result.toString());
        if (result >= migliaAlert) {
          //callNotification();
          listenNotification();
          NotificationApi.showNotification(
              title: 'ATTENZIONE', body: "L'imbarcazione ha superato il limite selezionato!", payload: 'Payload');
        } else {
          print('tuttok ok');
        }
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
  NotificationApi.init();

  await Firebase.initializeApp();
  wm.initialize(callbackDispatcher);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? uid = prefs.getString("uid");
  print("######### prima dell'if" + uid.toString());
  if (uid != null) {
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
