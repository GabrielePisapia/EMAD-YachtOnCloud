import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yachtoncloud/SetAlert.dart';
import 'package:yachtoncloud/connettivita.dart';
import 'package:yachtoncloud/dashboard.dart';
import 'package:yachtoncloud/data/drawer_items.dart';
import 'package:yachtoncloud/newLoginpage.dart';
import 'package:yachtoncloud/main.dart';
import 'package:yachtoncloud/newWelcomePage.dart';
import 'package:yachtoncloud/paginaIniziale.dart';
import 'package:yachtoncloud/realTimeVideo.dart';
import 'package:yachtoncloud/theme/colors.dart';
import 'package:yachtoncloud/trackingpage.dart';
import 'package:yachtoncloud/videoscreenbydate.dart';
import 'package:yachtoncloud/videosorveglianza.dart';
import 'package:provider/provider.dart';
import 'package:yachtoncloud/vlc_screen.dart';
import 'videosorveglianza.dart';
import 'drawer_item.dart';
import 'navigation_provider.dart';

class navdrawerTest extends StatelessWidget {
  const navdrawerTest({Key? key}) : super(key: key);

  final isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);
    final provider = Provider.of<NavigationProvider>(context);
    final isCollapsed = provider.isCollapsed;
    return Container(
        width: isCollapsed ? MediaQuery.of(context).size.width * 0.2 : null,
        child: Drawer(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                //Color(0Xff7cdedc),
                appBarColor1,
                appBarColor2,
              ],
            )),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 24).add(safeArea),
                  width: double.infinity,
                  color: Colors.white12,
                  child: buildHeader(isCollapsed),
                ),
                const SizedBox(height: 24),
                buildList(items: itemFirst, isCollapsed: isCollapsed),
                const SizedBox(height: 24),
                Divider(color: Colors.white70),
                const SizedBox(height: 24),
                buildList(
                    indexOffset: itemFirst.length,
                    items: itemSecond,
                    isCollapsed: isCollapsed),
                Spacer(),
                buildCollapseIcon(context, isCollapsed),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ));
  }

  Widget buildHeader(bool isCollapsed) => isCollapsed
      ? Image.asset("assets/logo.png", width: 100, height: 59)
      : Row(
          children: [
            const SizedBox(width: 24),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Image.asset("assets/logo.png", width: 150, height: 59),
            ),
            const SizedBox(width: 16),
          ],
        );

  Widget buildCollapseIcon(BuildContext context, bool isCollapsed) {
    final double size = 52;
    final icon = isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    final alignment = isCollapsed ? Alignment.center : Alignment.centerRight;
    final margin = isCollapsed ? null : EdgeInsets.only(right: 16);
    final width = isCollapsed ? double.infinity : size;
    return Container(
      alignment: alignment,
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            width: width,
            height: size,
            child: Icon(icon, color: textColor),
          ),
          onTap: () {
            final provider =
                Provider.of<NavigationProvider>(context, listen: false);
            provider.toggleIsCollapsed();
          },
        ),
      ),
    );
  }

  Widget buildList({
    required bool isCollapsed,
    required List<DrawerItem> items,
    int indexOffset = 0,
  }) =>
      ListView.separated(
        padding: isCollapsed
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(horizontal: 20),
        shrinkWrap: true,
        primary: false,
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = items[index];
          return buildMenuItem(
            isCollapsed: isCollapsed,
            text: item.title,
            icon: item.icon,
            onClicked: () => selectItem(context, index + indexOffset),
          );
        },
      );

  Widget buildMenuItem({
    required bool isCollapsed,
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = textColor;
    final leading = Icon(icon, color: color);
    return Material(
      color: Colors.transparent,
      child: isCollapsed
          ? ListTile(
              title: leading,
              onTap: onClicked,
            )
          : ListTile(
              leading: leading,
              title: Text(
                text,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: textColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold)),
              ),
              onTap: onClicked,
            ),
    );
  }

  Future<void> selectItem(BuildContext context, int index) async {
    final navigateTo = (page) => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => page,
        ));

    switch (index) {
      case 0:
        navigateTo(Connettivita());
        break;
      case 1:
        navigateTo(RealTimeVideo());
        break;
      case 2:
        navigateTo(TrackingPage());
        break;
      case 3:
        navigateTo(
            PaginaIniziale()); //Rimandare l'utente al menu box per cambiarla
        break;
      case 4:
        //navigateTo(AssociaBox(creaGrid: 1));
        //Navigator.push(context,
        //    MaterialPageRoute(builder: (context) => AssociaBox(creaGrid: 1)));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Dashboard()),
            ModalRoute.withName('/'));
        break;
      case 5:
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        Get.offAll(WelcomePage());
        //Nel caso torniamo come prima
        /*Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginPage(
                      title: "Login",
                    )),
            ModalRoute.withName('/'));*/
        break;
    }
  }
}
