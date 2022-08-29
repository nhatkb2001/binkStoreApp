import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:binkstoreap/assets/constants/colors.dart';
import 'package:binkstoreap/assets/constants/images.dart';
import 'package:binkstoreap/models/productModel.dart';
import 'package:binkstoreap/screens/orders/createOrder.dart';
import 'package:binkstoreap/screens/products/importGood.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class atOptionOrder extends StatefulWidget {
  atOptionOrder({
    Key? key,
  }) : super(key: key);
  @override
  _atOptionOrder createState() => _atOptionOrder();
}

class _atOptionOrder extends State<atOptionOrder>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  static const colorizeColors = [
    pp,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: white,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Container(
                    child: AnimatedTextKit(animatedTexts: [
                      ColorizeAnimatedText('Choose your option',
                          textStyle: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Recoleta',
                            fontWeight: FontWeight.w500,
                          ),
                          colors: colorizeColors),
                    ]),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Lottie.network(
                      'https://assets1.lottiefiles.com/packages/lf20_agyhastz.json'),
                ),
                SizedBox(
                  height: 64,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => atCreateOrder()));
                  },
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 319,
                      height: 48,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF5FAAEF),
                                Color(0xFF979DFA),
                              ],
                              stops: [
                                0.0,
                                1.0,
                              ]),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 21),
                          Container(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center,
                              child: Icon(Iconsax.add, size: 20, color: white)),
                          SizedBox(width: 21),
                          Text(
                            "Create Invoice",
                            style: TextStyle(
                              color: white,
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => atImportGoods()));
                  },
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 319,
                      height: 48,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromARGB(255, 244, 91, 99),
                                Color.fromARGB(255, 255, 34, 34),
                              ],
                              stops: [
                                0.0,
                                1.0,
                              ]),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 21),
                          Container(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center,
                              child:
                                  Icon(Iconsax.minus, size: 20, color: white)),
                          SizedBox(width: 21),
                          Text(
                            "Import Goods",
                            style: TextStyle(
                              color: white,
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
