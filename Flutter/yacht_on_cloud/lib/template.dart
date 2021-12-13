import 'package:flutter/material.dart';
import 'package:menu_page/drawer.dart';
import 'package:menu_page/navdrawer.dart';
import 'package:responsive_framework/responsive_framework.dart';

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

/* Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xff20BDFF),
                      Color(0xff5433FF),
                      //Color(0xffA5FECB),
                    ],
                  ),
                ), 
                child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Table(
                  // give each column in the table a fraction (to adapt to various screen sizes)
                  columnWidths: {
                    0: FractionColumnWidth(.1),
                    1: FractionColumnWidth(.4),
                    2: FractionColumnWidth(.2),
                    3: FractionColumnWidth(.15),
                    4: FractionColumnWidth(.2)
                  },
                  children: [
                    // first table row
                    // space each row
                    rowSpacer,
                    // first table row
                    TableRow(
                      children: [
                        Text(
                          '1',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Videocamera1',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Attivo',
                          style: TextStyle(color: Colors.green[200]),
                        ),
                        RichText(
                            text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.settings,
                                color: Colors.amber,
                              ),
                            )
                          ],
                        )),
                        SizedBox(
                          height: 20,
                          child: Switch(
                            activeColor: Colors.green,
                            inactiveThumbColor: Colors.red,
                            value: switchValue1,
                            onChanged: (val) {
                              setState(() {
                                switchValue1 = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    // space each row
                    rowSpacer,
                    // third table row
                    TableRow(
                      children: [
                        Text(
                          '2',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Videocamera2',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Attivo',
                          style: TextStyle(color: Colors.green[200]),
                        ),
                        RichText(
                            text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.settings,
                                color: Colors.amber,
                              ),
                            )
                          ],
                        )),
                        SizedBox(
                          height: 20,
                          child: Switch(
                            activeColor: Colors.green,
                            inactiveThumbColor: Colors.red,
                            value: switchValue2,
                            onChanged: (val) {
                              setState(() {
                                switchValue2 = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
                
                
                
                */