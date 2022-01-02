import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yachtoncloud/login.dart';
import 'package:yachtoncloud/main.dart';
import 'package:yachtoncloud/paginaIniziale.dart';
import 'package:yachtoncloud/tempstateloginReg.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yachtoncloud/userSetup.dart';
import 'navigation_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class registrationPage extends StatefulWidget {
  //const registrationPage ({Key? key,error, required this.error2}): super(key:key);
  String error2;
  registrationPage({required this.error2});

  @override
  _RegistrationPageState createState() => _RegistrationPageState(error2);
}

class _RegistrationPageState extends State<registrationPage> {
  String error2;
  _RegistrationPageState(this.error2);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController cognomeController = TextEditingController();
  TextEditingController confpwd = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String validate(String nome, String cognome, String confpass, String pass) {
    RegExp regExp = new RegExp("^([A-Za-z][A-Za-z ,.'`-]{2,30})\$",
        caseSensitive: false, multiLine: false);

    String temp = "";
    if (pass != confpass) {
      temp = "Le password non corrispondono";
      return temp;
    }
    if (!regExp.hasMatch(nome)) {
      temp = "Nome non ammissibile";
      return temp;
    }
    if (!regExp.hasMatch(cognome)) {
      temp = "Cognome non ammissibile";
      return temp;
    }

    return "Ok";
  }

  Future<String> SignUp(String email, String pass, String nome, String cognome,
      String confpass) async {
    String esito = "";
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);

      var firebaseUser = FirebaseAuth.instance.currentUser;
      String isValid = "";
      isValid = validate(nome, cognome, confpass, pass);

      if (isValid == "Ok") {
        UserSetup(uid: firebaseUser!.uid).updateUserData(nome, cognome);
        print(firebaseUser.uid + " " + nome + " " + cognome);
        esito = "Ok";
        print("TRY RIUSCITO, VALORE DI ESITO: " + esito);

        return esito;
      } else {
        esito = isValid;
        return esito;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        print("Account esistente");
        esito = "Account esistente";
        return esito;
      } else {
        esito = "Ok";
        print("ELSE DI SIGN UP, VALORE DI ESITO: " + esito);
        return esito;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplateLogReg(
      appBarTitle: "Yacht on Cloud",
      child: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                'Per registrarti, per favore compila i seguenti campi',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            Container(
              //height: 500.0,
              width: 300.0,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Form(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      ),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: TextFormField(
                          controller: nomeController,
                          decoration: InputDecoration(
                            //hintStyle: TextStyle(color: Colors.white),
                            hintText: 'Nome',
                            fillColor: Colors.orange[400],
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: TextFormField(
                          controller: cognomeController,
                          decoration: InputDecoration(
                            hintText: 'Cognome',
                            fillColor: Colors.orange[400],
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      ),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            fillColor: Colors.orange[400],
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      ),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            fillColor: Colors.orange[400],
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      ),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: TextFormField(
                          controller: confpwd,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Conferma password',
                            fillColor: Colors.orange[400],
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: OutlinedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.red))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange),
                          ),
                          onPressed: () {
                            String esito = "";
                            SignUp(
                              emailController.text,
                              passwordController.text,
                              nomeController.text,
                              cognomeController.text,
                              confpwd.text,
                            ).then((val) {
                              print(val);
                              esito = val;
                              print("Esito in then: " + esito);

                              if (esito == "Ok") {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AssociaBox(title: '')));
                              } else {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => registrationPage(
                                              error2: esito,
                                            )));
                              }
                            });
                          },
                          child: Text(
                            "Registrati",
                            style: TextStyle(fontSize: 19, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(error2,
                          style: TextStyle(fontSize: 15, color: Colors.red)),
                      Container(
                          width: 250,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text("Oppure accedi con:")),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: 250,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.google,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(FontAwesomeIcons.facebook,
                                    color: Colors.blue),
                              ]))
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xFF00CCFF),
              Colors.white,
            ],
            begin: const FractionalOffset(0.0, 2.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
