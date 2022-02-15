import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yachtoncloud/paginaIniziale.dart';
import 'package:yachtoncloud/theme/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scan QR Code - Flutter Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
  }) =>
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [appBarColor2, appBarColor1]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(urlImage,
                fit: BoxFit.scaleDown, width: double.infinity, repeat: false),
            /*Image.asset(
              urlImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),*/
            const SizedBox(
              height: 30,
            ),
            Text(
              title,
              style: TextStyle(
                  color: textColor, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                subtitle,
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          controller: controller,
          children: [
            buildPage(
                color: appBarColor1,
                urlImage: 'assets/qrscan.json',
                title: "Associa il box ",
                subtitle:
                    "Collega in modo semplice il box scansionando il codice qr cosi da poter utilizzare subito l'applicazione e collegare tutti i dispositivi e sensori!"),
            buildPage(
                color: Colors.amber,
                urlImage: 'assets/videos.json',
                title: "Visualizza video real time",
                subtitle:
                    "Utilizza le videocamere di sorveglianza per poter controllare la tua imbarcazione da remoto e in tempo reale oppure utilizza lo storico per visualizzare video dei giorni precedenti"),
            buildPage(
                color: Colors.amber,
                urlImage: 'assets/track.json',
                title: "Tracciamento real time",
                subtitle:
                    "Utilizza il tracking gps per poter essere sempre aggiornato sulla posizione della tua imbarcazione oppure imposta una notifica per poter essere avvisato in tempo reale su eventuali spostamenti"),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1)),
                  primary: Colors.white,
                  backgroundColor: backgroundColor1,
                  minimumSize: Size.fromHeight(80)),
              onPressed: () async {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => PaginaIniziale()));
              },
              child: Text(
                "Inizia ad usare l'app",
                style: TextStyle(fontSize: 24),
              ))
          : Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      child: Text(
                        "SKIP",
                      ),
                      onPressed: () => controller.jumpToPage(2)),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                          spacing: 16,
                          dotColor: appBarColor1,
                          activeDotColor: appBarColor2),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                      child: Text("NEXT"),
                      onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut)),
                ],
              ),
            ),
    );
  }
}
