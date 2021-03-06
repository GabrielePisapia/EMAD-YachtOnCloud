import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yachtoncloud/paginaIniziale.dart';
import 'package:yachtoncloud/theme/colors.dart';
import 'newSignup.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Widget/bezierContainer.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static Future<void> setUpPreferences(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<String> SignIn(String email, String pass) async {
    String esito = "";
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      esito = "Ok";

      var user = FirebaseAuth.instance.currentUser;
      print("USER UID: " + user!.uid.toString());
      setUpPreferences(user.uid);
      print("TRY RIUSCITO, VALORE DI ESITO: " + esito);
      return esito;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("Account inesistente");
        esito = "Account inesistente";
        return esito;
      } else if (e.code == "wrong-password") {
        esito = "Password sbagliata";
        return esito;
      } else {
        return "Errore generico di login";
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
              child: Icon(Icons.keyboard_arrow_left, color: textColor),
            ),
            Text('Back',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.normal)),
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
                  fillColor: fieldTextColor,
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
          SignIn(emailController.text, passwordController.text).then((val) {
            esito = val;
            print(esito);
            if (esito == "Ok") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => AssociaBox(creaGrid: 1)));
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginPage(title: "titolo")));
            }
          });

          // Respond to button press
        },
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SignUpPage(
                      error2: '',
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Non sei registrato?',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal))),
            SizedBox(
              width: 5,
            ),
            Text('Registrati',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: textColor,
                        fontSize: 16,
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
                      color: textColor,
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
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .1),
                  //_title(),
                  SizedBox(height: 25),
                  _logo(),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  _submitButton(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Text(' Password dimenticata?',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.normal))),
                  ),
                  SizedBox(height: height * .045), //.055
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
}
