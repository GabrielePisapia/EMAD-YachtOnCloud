import 'package:flutter/material.dart';
import 'package:yachtoncloud/SetAlert.dart';
import 'package:yachtoncloud/connettivita.dart';
import 'package:yachtoncloud/data/drawer_items.dart';
import 'package:yachtoncloud/login.dart';
import 'package:yachtoncloud/main.dart';
import 'package:yachtoncloud/trackingpage.dart';
import 'package:yachtoncloud/videosorveglianza.dart';
import 'package:provider/provider.dart';

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
                Color(0xff20BDFF),
                Color(0xff5433FF),
                //Color(0xffA5FECB),
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
      ? FlutterLogo(size: 48)
      : Row(
          children: [
            const SizedBox(width: 24),
            FlutterLogo(size: 48),
            const SizedBox(width: 16),
            Text(
              'Flutter',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
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
            child: Icon(icon, color: Colors.white),
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
    final color = Colors.white;
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
              title: Text(text, style: TextStyle(color: color, fontSize: 16)),
              onTap: onClicked,
            ),
    );
  }

  void selectItem(BuildContext context, int index) {
    final navigateTo = (page) => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => page,
        ));
    switch (index) {
      case 0:
        navigateTo(Connettivita());
        break;
      case 1:
        navigateTo(mainVideo(
          title: "Videosorveglianza",
        ));
        break;
      case 2:
        navigateTo(TrackingPage());
        break;
      case 3:
        navigateTo(SetAlertPage());
        break;
      case 4:
        navigateTo(TrackingPage());
        break;
      case 5:
        navigateTo(LoginPage(
          title: 'Login',
        ));
        break;
    }
  }
}
