import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSetup {
  final String uid;
  UserSetup({required this.uid});
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  Future updateUserData(String nome, String cognome) async {
    print("metodo di inserimento");
    return await users.doc(uid).set({
      'nome': nome,
      'cognome': cognome,
    });
  }
}
