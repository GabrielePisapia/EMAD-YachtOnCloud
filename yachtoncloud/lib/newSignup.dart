import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  _SignUpPageState createState() => _SignUpPageState(error2!);
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

  Future<String> SignUp(
    String email,
    String pass,
    String nome,
    String cognome,
  ) async {
    String esito = "";
    try {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      String isValid = "";
      isValid = validate(nome, cognome, pass);
      print("PRINT DI IS VALID: " + isValid);
      if (isValid == "Ok") {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass);
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
      margin: EdgeInsets.symmetric(vertical: 0),
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
                  fillColor: Color(0xfff3f3f4),
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
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.white)))),
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => AssociaBox(title: '')));
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
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
                            color: Colors.black,
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
                        fontWeight: FontWeight.normal))),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Ya',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
          children: [
            TextSpan(
              text: 'chtOn',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'Cloud',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
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
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    SizedBox(height: height * .14),
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
