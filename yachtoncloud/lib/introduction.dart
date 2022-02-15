import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yachtoncloud/paginaIniziale.dart';

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
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              urlImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(
              height: 64,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.teal.shade700,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Text(
                subtitle,
                style: const TextStyle(color: Colors.black),
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
                color: Colors.amber,
                urlImage: 'assets/qrcodes.png',
                title: "Scansiona il qr code",
                subtitle:
                    "Collega in modo semplice il box scansionando il codice qr cosi da poter utilizzare subito l'applicazione!"),
            buildPage(
                color: Colors.amber,
                urlImage: 'assets/qrcodes.png',
                title: "Scansiona il qr code",
                subtitle:
                    "Collega in modo semplice il box scansionando il codice qr cosi da poter utilizzare subito l'applicazione!"),
            buildPage(
                color: Colors.amber,
                urlImage: 'assets/qrcodes.png',
                title: "Scansiona il qr code",
                subtitle:
                    "Collega in modo semplice il box scansionando il codice qr cosi da poter utilizzare subito l'applicazione!"),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1)),
                  primary: Colors.white,
                  backgroundColor: Colors.teal.shade700,
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
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      child: Text("SKIP"),
                      onPressed: () => controller.jumpToPage(2)),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.amber,
                          activeDotColor: Colors.amber.shade100),
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
