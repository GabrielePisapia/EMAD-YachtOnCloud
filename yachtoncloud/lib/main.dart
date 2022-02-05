// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yachtoncloud/PushNotification.dart';
import 'package:yachtoncloud/drawer.dart';
import 'package:yachtoncloud/google_sign_in.dart';

import 'package:yachtoncloud/navigation_provider.dart';
import 'package:yachtoncloud/newWelcomePage.dart';
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

void callbackDispatcher() {
// this method will be called every hour

  wm.executeTask((task, inputdata) async {
    switch (task) {
      case myTask:
        print("this method was called from native!");

        break;

      case Workmanager.iOSBackgroundTask:
        print("iOS background fetch delegate ran");
        break;

      case task2:
        if (100 < 101) {
          print('yes it is');
        }
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

  //Firebase messaging

  wm.initialize(callbackDispatcher);

  await Firebase.initializeApp();

  wm.registerOneOffTask("1", task2, initialDelay: Duration(seconds: 10));

  /*
  wm.registerPeriodicTask(
      "2",
      // use the same task name used in callbackDispatcher function for identifying the task
      // Each task must have a unique name if you want to add multiple tasks;
      myTask,
      // When no frequency is provided the default 15 minutes is set.
      // Minimum frequency is 15 min. 
      // Android will automatically change your frequency to 15 min if you have configured a lower frequency than 15 minutes.
       // change duration according to your needs
  );*/

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        home: WelcomePage(),
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
