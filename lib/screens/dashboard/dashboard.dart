import 'package:binkstoreap/assets/constants/colors.dart';
import 'package:binkstoreap/assets/constants/images.dart';
import 'package:binkstoreap/models/orderModel.dart';
import 'package:binkstoreap/models/productModel.dart';
import 'package:binkstoreap/screens/products/productDetail.dart';
import 'package:binkstoreap/screens/products/productScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class atDashboardScreen extends StatefulWidget {
  atDashboardScreen({Key? key}) : super(key: key);
  @override
  _atDashboardScreen createState() => _atDashboardScreen();
}

class _atDashboardScreen extends State<atDashboardScreen>
    with SingleTickerProviderStateMixin {
  static const colorizeColors = [
    pp,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 24.0,
    fontFamily: 'Recoleta',
  );
  late List<productModel> listProduct = [];
  late List<productModel> listSticker = [];
  late List<productModel> listWashiTape = [];
  late List<productModel> listNotebook = [];
  late List<productModel> listPen = [];
  Future getProducts() async {
    FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .listen((products) {
      setState(() {
        listProduct.clear();
        listSticker.clear();
        listWashiTape.clear();
        listNotebook.clear();
        listPen.clear();
        products.docs.forEach((product) {
          listProduct.add(productModel.fromDocument(product.data()));
        });
        listProduct.forEach((element) {
          if (element.type == 'Sticker') {
            listSticker.add(element);
          } else if (element.type == 'Washi Tape') {
            listWashiTape.add(element);
          } else if (element.type == 'Notebook') {
            listNotebook.add(element);
          } else {
            listPen.add(element);
          }
        });
      });
    });
  }

  List<orderModel> orderList = [];
  double revenue = 0;
  Future getOrderList() async {
    FirebaseFirestore.instance.collection('orders').snapshots().listen((value) {
      setState(() {
        orderList.clear();
        value.docs.forEach((element) {
          orderList.add(orderModel.fromDocument(element.data()));
        });
        orderList.forEach((element) {
          if (element.type == 'Invoice') {
            revenue = revenue + double.parse(element.total);
          } else {
            revenue = revenue - double.parse(element.total);
          }
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
    getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: EdgeInsets.only(left: 28, right: 28, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  // Row(
                  //   children: [
                  //     Container(
                  //         height: 56,
                  //         width: 56,
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: Colors.grey.withOpacity(0.5),
                  //                 blurRadius: 7,
                  //                 offset: Offset(
                  //                     -2, 3), // changes position of shadow
                  //               ),
                  //             ],
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(8))),
                  //         child: ClipRRect(
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(8)),
                  //             child: Image.network(
                  //                 "https://i.imgur.com/gAT0ph1.jpg"))),
                  //     SizedBox(width: 32),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Container(
                  //           child: AnimatedTextKit(animatedTexts: [
                  //             ColorizeAnimatedText('Welcome to Bink Store!',
                  //                 textStyle: TextStyle(
                  //                   fontSize: 24,
                  //                   fontFamily: 'Recoleta',
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //                 colors: colorizeColors),
                  //           ]),
                  //         ),
                  //         Container(
                  //             child: Text(
                  //           'The World  Of  Stickers!',
                  //           style: TextStyle(
                  //               fontSize: 16,
                  //               fontFamily: 'Recoleta',
                  //               fontWeight: FontWeight.w500,
                  //               color: gray),
                  //         ))
                  //       ],
                  //     )
                  //   ],
                  // ),
                  SizedBox(height: 32),
                  Stack(
                    children: [
                      Container(
                        width: 319,
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: white
                            // child: Image.asset(atReexCard, scale: 8, fit: BoxFit.cover),
                            ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 16, left: 16, bottom: 8, right: 16),
                        width: 319,
                        height: 140,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: black.withOpacity(0.2),
                                blurRadius: 24,
                                spreadRadius: -1,
                                offset: Offset(0, 4))
                          ],
                          borderRadius: BorderRadius.circular(16.0),
                          image: DecorationImage(
                              image: NetworkImage(
                                'https://i.imgur.com/HVW5FeE.png',
                              ),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Total Revenue',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'BeVietnamPro',
                                    color: black),
                              ),
                            ),
                            SizedBox(height: 24),
                            Container(
                              alignment: Alignment.center,
                              child: Container(
                                width: 276,
                                child: Countup(
                                  begin: 0,
                                  end: revenue,
                                  prefix: "\$ ",
                                  suffix: " VND",
                                  duration: Duration(milliseconds: 1000),
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'BeVietnamPro',
                                    color: black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Container(
                    height: 1,
                    width: 160,
                    color: gray,
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 1,
                    width: 120,
                    color: gray,
                  ),
                  SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Text(
                          'Products',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Recoleta',
                              color: black,
                              height: 1.4),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => atProductScreen()));
                          // Get.to(() => atProductScreen());
                          Get.toNamed('/productScreen');
                        },
                        child: Container(
                          child: Text(
                            'See all',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'BeVietnamPro',
                                color: black,
                                height: 1.4),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 450,
                    margin: EdgeInsets.only(bottom: 32),
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: DefaultTabController(
                          length: 4,
                          child: Scaffold(
                            appBar: AppBar(
                              toolbarHeight: 0,
                              backgroundColor: white,
                              bottom: TabBar(
                                isScrollable: true,
                                labelStyle: TextStyle(
                                  fontFamily: 'Recoleta',
                                  color: pp,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                                unselectedLabelStyle: TextStyle(
                                    fontFamily: 'Recoleta',
                                    color: white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                                padding: EdgeInsets.only(
                                    left: 14, right: 0, top: 0, bottom: 0),
                                tabs: [
                                  Tab(text: 'Sticker'),
                                  Tab(text: 'Washi Tape'),
                                  Tab(text: 'Notebook'),
                                  Tab(text: 'Pen'),
                                ],
                              ),
                            ),
                            body: TabBarView(
                              children: [
                                ListSticker(listSticker),
                                ListSticker(listWashiTape),
                                ListSticker(listNotebook),
                                ListSticker(listPen),
                              ],
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  ListSticker(List<productModel> listProduct) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listProduct.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => atProductDetail(
                            idProduct: listProduct[index].id,
                          ))));
            },
            child: Container(
              width: 200 + 24 + 24,
              margin: EdgeInsets.only(
                  right: 32, top: 12, bottom: 32 + 24, left: 12),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: gray.withOpacity(0.2),
                      blurRadius: 24,
                      spreadRadius: -1,
                      offset: Offset(0, 4))
                ],
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: white,
              ),
              child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        child: Image(
                          image: NetworkImage(listProduct[index].images[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: black.withOpacity(0.2),
                              blurRadius: 24,
                              spreadRadius: -1,
                              offset: Offset(0, 4))
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        // image: DecorationImage(
                        //     image: AssetImage(atReexCard), fit: BoxFit.cover),
                        color: white,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Text(
                        listProduct[index].name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'BeVietnamPro',
                          color: black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      child: Text(
                        'Code: ' + listProduct[index].code,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'BeVietnamPro',
                            color: gray,
                            height: 1.4),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Container(
                          child: Text(
                            'Quantity: ' + listProduct[index].quantity,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'BeVietnamPro',
                                color: black,
                                height: 1.4),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(
                              left: 4, top: 12, bottom: 12, right: 4),
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
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(8)),
                              color: pp),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "\$ " + listProduct[index].price + ' VND',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'BeVietnamPro',
                                  color: white,
                                  height: 1.4),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
