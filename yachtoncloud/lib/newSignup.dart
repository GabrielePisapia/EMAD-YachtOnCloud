import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yachtoncloud/theme/colors.dart';
import 'Widget/bezierContainer.dart';
import 'Widget/customClipper.dart';
import 'package:google_fonts/google_fonts.dart';

import 'newLoginpage.dart';
import 'package:yachtoncloud/paginaIniziale.dart';
import 'userSetup.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, this.title, this.error2}) : super(key: key);

  final String? title;
  String? error2;

  @override
  _SignUpPageState createState() => _SignUpPageState('');
}

class _SignUpPageState extends State<SignUpPage> {
  String error2;
  _SignUpPageState(this.error2);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController cognomeController = TextEditingController();
  TextEditingController confpwd = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String validate(String nome, String cognome, String pass) {
    RegExp regExp = new RegExp("^([A-Za-z][A-Za-z ,.'`-]{2,30})\$",
        caseSensitive: false, multiLine: false);
    print("DEBUG: " + nome + " " + cognome + " " + pass);
    String temp = "";
    if (nome == "") {
      temp = "Il nome non può essere vuoto";
      return temp;
    }
    if (cognome == "") {
      temp = "Il cognome non può essere vuoto";
      return temp;
    }
    if (pass == "") {
      temp = "La password non può essere vuota";
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

  static Future<void> setUpPreferences(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
  }

  Future<String> SignUp(
    String email,
    String pass,
    String nome,
    String cognome,
  ) async {
    String esito = "";
    try {
      String isValid = "";
      isValid = validate(nome, cognome, pass);
      print("PRINT DI IS VALID: " + isValid);
      if (isValid == "Ok") {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass);
        var firebaseUser = FirebaseAuth.instance.currentUser;
        UserSetup(uid: firebaseUser!.uid).updateUserData(nome, cognome);
        setUpPreferences(firebaseUser.uid);
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
      } else if (e.code == "weak-password") {
        print("Password debole");
        esito = "Password debole";
        return esito;
      } else {
        esito = "Ok";
        print(e.code.toString());
        print("ELSE DI SIGN UP, VALORE DI ESITO: " + esito);
        return esito;
      }
    }
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  fillColor: boxVideoColor.withOpacity(0.7), //fieldtext
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 1),
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: buttonColor)))),
        onPressed: () {
          String esito = "";
          SignUp(
            emailController.text,
            passwordController.text,
            nomeController.text,
            cognomeController.text,
          ).then((val) {
            print(val);
            esito = val;
            print("Esito in then: " + esito);

            if (esito == "Ok") {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AssociaBox(creaGrid: 0)));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SignUpPage(
                        error2: esito,
                      )));
            }
          });
        },
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                child: Text('Registrati',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hai già un account?',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal))),
            SizedBox(
              width: 10,
            ),
            Text('Accedi',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Yach',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: textColor, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          children: [
            TextSpan(
                text: 'tOnC',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
            TextSpan(
                text: 'loud',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: textColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
          ]),
    );
  }

  Widget _logo() {
    return Center(
      child: Image.asset(
        "assets/logo.png",
        height: 120,
        width: 200,
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Nome", nomeController),
        _entryField("Cognome", cognomeController),
        _entryField("Email", emailController),
        _entryField("Password", passwordController, isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [backgroundColor2, backgroundColor1])),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .1),
                    //_title(),
                    _logo(),
                    SizedBox(
                      height: 30,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    SizedBox(height: height * .09), //era .14
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
