import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

    Widget buildGif({
    required double size,
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
              colors: [backgroundColor2, backgroundColor1]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(urlImage,
                height: size/2.4, fit: BoxFit.contain, width: double.infinity),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: textColor,
                            fontSize: 23,
                            fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                subtitle,
                style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
              ),
            )
          ],
        ),
      );

  Widget buildPage({
    required double size,
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
              colors: [backgroundColor2, backgroundColor1]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(urlImage,
                height: size/3, fit: BoxFit.contain, width: double.infinity),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: textColor,
                            fontSize: 23,
                            fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                subtitle,
                style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
double height = MediaQuery. of(context). size. height;

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
                size: height,
                color: appBarColor1,
                urlImage: 'assets/qrscan1.json',
                title: "Associa il box ",
                subtitle:
                    "Collega in modo semplice il box scansionando il codice qr cosi da poter utilizzare subito l'applicazione e collegare tutti i dispositivi e sensori!"),
            buildGif(
               size: height,
                color: Colors.amber,
                urlImage: 'assets/videos.gif',
                title: "Visualizza video real-time",
                subtitle:
                    "Utilizza le videocamere di sorveglianza per poter controllare la tua imbarcazione da remoto e in tempo reale oppure utilizza lo storico per visualizzare video dei giorni precedenti."),
            buildPage(
               size: height/1.4,
                color: Colors.amber,
                urlImage: 'assets/track.json',
                title: "Tracciamento real-time",
                subtitle:
                    "Utilizza il tracking gps per poter essere sempre aggiornato sulla posizione della tua imbarcazione oppure imposta una notifica per poter essere avvisato in tempo reale su eventuali spostamenti."),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Container( color: backgroundColor1, child: Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 10.0)],
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(
                      MediaQuery.of(context).size.width, 40.0)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [appBarColor1, appBarColor2]),
              ),
              child: /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [*/
                  Center(
                    child: TextButton(
                      child: Text("Inizia ad usare l'app",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))),
                      onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => PaginaIniziale()))),
                  )
               /* ],
              ),*/
            ))
          : Container( color: backgroundColor1, child: Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 10.0)],
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(
                      MediaQuery.of(context).size.width, 40.0)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [appBarColor1, appBarColor2]),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      child: Text(
                        "SALTA ",
                        style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: textColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold))
                      ),
                      onPressed: () => controller.jumpToPage(2)),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                          spacing: 16,
                          dotColor: backgroundColor1,
                          activeDotColor: backgroundColor2),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                  TextButton(
                      child: Text("AVANTI",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: textColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold))),
                      onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut)),
                ],
              ),
            )),
    );
  }
}
