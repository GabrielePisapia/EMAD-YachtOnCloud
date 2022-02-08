import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yachtoncloud/userSetup.dart';

 class FacebookSignIn{


static Future <void> setUpPreferences(String uid) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('uid', uid);
}
  

  static bool insert_user(String nome,String cognome){
    
    var firebaseUser = FirebaseAuth.instance.currentUser;   
    final res = UserSetup(uid: firebaseUser!.uid).updateUserData(nome, cognome);
    setUpPreferences(firebaseUser.uid);
    
    if(res == null){
      return false;
    }
    else{
      return true;
    }
  }

}