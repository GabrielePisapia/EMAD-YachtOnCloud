// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      child: MaterialApp(
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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YachtOnCloud',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
    );
  }
}
