import 'package:binkstoreap/assets/constants/colors.dart';
import 'package:binkstoreap/screens/orders/createOrder.dart';
import 'package:binkstoreap/screens/dashboard/dashboard.dart';
import 'package:binkstoreap/screens/orders/historyOrder.dart';
import 'package:binkstoreap/screens/orders/optionOrder.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class navigationBar extends StatefulWidget {
  navigationBar({
    Key? key,
  }) : super(key: key);
  @override
  _navigationBar createState() => _navigationBar();
}

class _navigationBar extends State<navigationBar>
    with SingleTickerProviderStateMixin {
  _navigationBar();
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: pp,
        bottomNavigationBar: CurvedNavigationBar(
          height: 32 + 24,
          buttonBackgroundColor: pp,
          backgroundColor: Colors.white,
          color: pp,
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              _page = index;
              print(index);
            });
          },
          letIndexChange: (index) => true,
          items: [
            Icon(
              Icons.home,
              size: 24,
              color: white,
            ),
            Icon(
              Icons.create,
              size: 24,
              color: white,
            ),
            Icon(
              Icons.history,
              size: 24,
              color: white,
            ),
          ],
        ),
        body: (_page == 0)
            ? atDashboardScreen()
            : (_page == 1)
                ? atOptionOrder()
                : atHistoryOrder());
  }
}
