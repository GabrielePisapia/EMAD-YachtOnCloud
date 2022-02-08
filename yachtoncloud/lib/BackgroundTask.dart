import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:latlong2/latlong.dart';

class BackgroundTask{
  Workmanager wm = Workmanager();
  static const task2="task";
  

  Future<void> execute() async {
    //wm.registerPeriodicTask("Tester", taskName, frequency: Duration(minutes:1 ),inputData:{"data1":"hello"} );
  WidgetsFlutterBinding.ensureInitialized();
  print('kkkkkkk');

  await Firebase.initializeApp();
void callbackDispatcher() {
// this method will be called every hour

  wm.executeTask((task, inputdata) async {
    switch (task) {
     

      case Workmanager.iOSBackgroundTask:
        print("iOS background fetch delegate ran");
        break;

      case task2:
        String uidUser = inputdata!['uid'];
        var snap = await FirebaseFirestore.instance.collection('Utenti').doc(uidUser).get();
        var currentPos = LatLng(snap.data()!['boxes'][0]['box']['gps']['currentPosition']['lat'], 
                      snap.data()!['boxes'][0]['box']['gps']['currentPosition']['long']);
        print('%%%%%%%%%%%%%%%%%%%%'+currentPos.toString());
        
        break;
    }

    //Return true when the task executed successfully or not
    return Future.value(true);
  });
}

          wm.initialize(callbackDispatcher);

          await Firebase.initializeApp();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? uid = prefs.getString("uid");
            if(uid!= null){
              print('############'+uid);
              wm.registerOneOffTask("1", task2, initialDelay: Duration(seconds: 1),inputData: {'string':uid.toString()});
            }
        }
  }
