import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menu_page/main.dart';
import 'package:menu_page/registration.dart';
import 'package:menu_page/template.dart';
import 'package:menu_page/tempstateloginReg.dart';
import 'package:provider/provider.dart';

import 'navigation_provider.dart';

void main() {
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return TemplateLogReg(
      appBarTitle: "Yacht on Cloud",
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
      child: Center(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          ),
          Container(
            height: 400.0,
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
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextFormField(
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
                    SizedBox(
                      height: 30,
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
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MyApp(),
                            ));
                            // Respond to button press
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 19, color: Colors.black),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
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
          Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Non sei ancora registrato? ",
                      style: new TextStyle(fontSize: 14)),
                  RichText(
                      text: TextSpan(
                    text: " Clicca qui!",
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => registrationPage(),
                            ));
                      },
                  ))
                ],
              ))
        ]),
      ),
    );
  }
}
