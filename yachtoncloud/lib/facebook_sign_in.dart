import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yachtoncloud/userSetup.dart';

 class FacebookSignIn{

  

  static bool insert_user(String nome,String cognome){
    
    var firebaseUser = FirebaseAuth.instance.currentUser;   
    final res = UserSetup(uid: firebaseUser!.uid).updateUserData(nome, cognome);
    if(res == null){
      return false;
    }
    else{
      return true;
    }
  }

}