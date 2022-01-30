import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Testnotifiche extends StatefulWidget{
  
  Testnotifiche(): super();

  @override
  State<StatefulWidget> createState() => TestnotificheState();    
  
}  

class TestnotificheState extends State <Testnotifiche>{
 
 FirebaseMessaging messaging = FirebaseMessaging.instance;

getToken(){
  messaging.getToken().then((deviceToken){
    print("Device token: $deviceToken" );
  });
}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}