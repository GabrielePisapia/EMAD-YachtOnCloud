import 'package:flutter/material.dart';

import 'package:yachtoncloud/navdrawer.dart';

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
        //backgroundColor: const Color(0xFF005B96),
        drawer: navdrawerTest(),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(this.appBarTitle),
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
                    const Color(0xFF00CCFF),
                    const Color(0xFF3366FF),
                  ],
                  begin: const FractionalOffset(0.0, 2.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ), //const Color(0xFF005B96),
          elevation: 0.0,
        ),
        //Qua c'era solo body: child, nel caso succedano guai
        body: child,
      ),
    );
  }
}
