import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:binkstoreap/helps/responsiveness.dart';
import 'package:flutter/material.dart';

import '../../assets/constants/colors.dart';

const colorizeColors = [
  pp,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

const colorizeTextStyle = TextStyle(
  fontSize: 24.0,
  fontFamily: 'Recoleta',
);

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !responsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Container(
                    height: 56,
                    width: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 7,
                        offset: Offset(-2, 3), // changes position of shadow
                      ),
                    ], borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child:
                            Image.network("https://i.imgur.com/gAT0ph1.jpg"))),
                SizedBox(width: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: AnimatedTextKit(animatedTexts: [
                        ColorizeAnimatedText('Welcome to Bink Store!',
                            textStyle: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Recoleta',
                              fontWeight: FontWeight.w500,
                            ),
                            colors: colorizeColors),
                      ]),
                    ),
                    Container(
                        child: Text(
                      'The World  Of  Stickers!',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Recoleta',
                          fontWeight: FontWeight.w500,
                          color: gray),
                    ))
                  ],
                )
              ],
            )
          : IconButton(
              onPressed: () {
                key.currentState?.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                size: 24,
              )),
      backgroundColor: blueLight,
      elevation: 0,
    );
