import 'package:flutter/material.dart';

import 'package:yachtoncloud/navigation_provider.dart';
import 'package:yachtoncloud/template.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const storicoReg());
}

class storicoReg extends StatelessWidget {
  const storicoReg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => NavigationProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: const mainStoricoReg(title: 'Flutter Demo Home Page'),
        ),
      );
}

class mainStoricoReg extends StatefulWidget {
  const mainStoricoReg({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _mainVideoState createState() => _mainVideoState();
}

class _mainVideoState extends State<mainStoricoReg> {
  final names = [
    "Videocamera1_13_12_2021",
    "Videocamera2_13_12_2021",
    "Videocamera3_13_12_2021",
    "Videocamera4_13_12_2021",
    "Videocamera5_13_12_2021",
  ];
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Template(
        boxDecoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color(0xFF00CCFF),
                const Color(0XFF2193b0),
              ],
              begin: const FractionalOffset(0.0, 2.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              new Container(
                color: Colors.transparent,
                child: new Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: new Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: new ListTile(
                      leading: new Icon(Icons.search),
                      title: new TextField(
                        controller: controller,
                        decoration: new InputDecoration(
                            hintText: 'Inserisci la data ',
                            border: InputBorder.none),
                        onChanged: onSearchTextChanged,
                      ),
                      trailing: new IconButton(
                        icon: new Icon(Icons.cancel),
                        onPressed: () {
                          controller.clear();
                          onSearchTextChanged('');
                        },
                      ),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(45, 30, 170, 0),
                            child: Text(
                              names[index].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(35.0, 0, 35.0, 0),
                            width: double.infinity,
                            height: 150,
                            child: Card(
                              child: Container(
                                height: 150,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/Webinar-pana.png'))),
                              ),
                              margin: EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 15.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        appBarTitle: "Yacht on Cloud");
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _userDetails.forEach((userDetail) {
      if (userDetail.firstName.contains(text) ||
          userDetail.lastName.contains(text)) _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

List<UserDetails> _searchResult = [];

List<UserDetails> _userDetails = [];

final String url = 'https://jsonplaceholder.typicode.com/users';

class UserDetails {
  final int id;
  final String firstName, lastName, profileUrl;

  UserDetails(
      {required this.id,
      required this.firstName,
      required this.lastName,
      this.profileUrl =
          'https://i.amz.mshcdn.com/3NbrfEiECotKyhcUhgPJHbrL7zM=/950x534/filters:quality(90)/2014%2F06%2F02%2Fc0%2Fzuckheadsho.a33d0.jpg'});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      id: json['id'],
      firstName: json['name'],
      lastName: json['username'],
    );
  }
}
