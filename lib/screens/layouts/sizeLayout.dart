import 'package:binkstoreap/assets/constants/colors.dart';
import 'package:binkstoreap/helps/responsiveness.dart';
import 'package:binkstoreap/screens/dashboard/dashboard.dart';
import 'package:binkstoreap/screens/dashboard/dashboardResponsive.dart';
import 'package:binkstoreap/screens/navigations/navigationbar.dart';
import 'package:binkstoreap/screens/navigations/top_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class sizeLayout extends StatelessWidget {
  sizeLayout({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: topNavigationBar(context, scaffoldkey),
      body: responsiveWidget(
        largeScreen: atDashboardScreen(),
        smallScreen: atDashboardScreen(),
        mediumScreen: atDashboardScreen(),
      ),
    );
  }
}
