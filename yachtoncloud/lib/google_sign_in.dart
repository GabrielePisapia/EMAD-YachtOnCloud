import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yachtoncloud/userSetup.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future<String> googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return "";
    _user = googleUser;

    print(_user?.email);
    final names = _user?.displayName!.split(' ');
    final nome = names![0];
    final cognome = names[1];
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    
    await FirebaseAuth.instance.signInWithCredential(credential);
    var firebaseUser =  FirebaseAuth.instance.currentUser;
    UserSetup(uid: firebaseUser!.uid).updateUserData(nome, cognome);

    notifyListeners();
    return "ok";
  }
}
