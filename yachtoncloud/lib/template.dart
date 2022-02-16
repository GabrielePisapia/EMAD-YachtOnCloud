import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yachtoncloud/navdrawer.dart';
import 'package:yachtoncloud/theme/colors.dart';

class Template extends StatelessWidget {
  final Widget child;
  final String appBarTitle;
  final BoxDecoration boxDecoration;

  const Template({
    Key? key,
    required this.child,
    required this.appBarTitle,
    required this.boxDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: this.boxDecoration,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset:
            false, //risolto problema bottom overflow setalert
        drawer: navdrawerTest(),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(this.appBarTitle,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: textColor,
                      fontSize: 19,
                      fontWeight: FontWeight.bold))),
          centerTitle: true,
          flexibleSpace: Container(
            height: 400,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 10.0)],
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width, 40.0)),
              gradient: LinearGradient(
                  colors: [
                    appBarColor1,
                    //Color(0Xff7cdedc),
                    //Color(0Xfff1d302),
                    appBarColor2,
                  ],
                  begin: const FractionalOffset(0.0, 2.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          elevation: 0.0,
        ),
        //Qua c'era solo body: child, nel caso succedano guai
        body: child,
      ),
    );
  }
}
