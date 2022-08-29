import 'package:binkstoreap/helps/responsiveness.dart';
import 'package:binkstoreap/screens/dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class atDashboardResponsiveScreen extends StatefulWidget {
  atDashboardResponsiveScreen({Key? key}) : super(key: key);
  @override
  _atDashboardResponsiveScreen createState() => _atDashboardResponsiveScreen();
}

class _atDashboardResponsiveScreen extends State<atDashboardResponsiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: responsiveWidget(
        largeScreen: atDashboardScreen(),
        smallScreen: atDashboardScreen(),
        mediumScreen: atDashboardScreen(),
      ),
    );
  }
}
