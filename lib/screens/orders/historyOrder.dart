import 'package:binkstoreap/assets/constants/colors.dart';
import 'package:binkstoreap/assets/constants/images.dart';
import 'package:binkstoreap/models/orderModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';

class atHistoryOrder extends StatefulWidget {
  atHistoryOrder({Key? key}) : super(key: key);
  @override
  _atHistoryOrder createState() => _atHistoryOrder();
}

class _atHistoryOrder extends State<atHistoryOrder>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    getOrderList();
  }

  List<orderModel> orderList = [];
  Future getOrderList() async {
    FirebaseFirestore.instance
        .collection('orders')
        .orderBy('timeDetail', descending: false)
        .snapshots()
        .listen((value) {
      setState(() {
        orderList.clear();
        value.docs.forEach((element) {
          orderList.add(orderModel.fromDocument(element.data()));
        });
      });
    });
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                      child: Text(
                    'History Orders',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Recoleta',
                        fontWeight: FontWeight.w500,
                        color: pp),
                  )),
                  SizedBox(height: 16),
                  Container(
                    height: 400 + 320,
                    margin: EdgeInsets.only(bottom: 32),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: orderList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 24),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: gray.withOpacity(0.2),
                                    blurRadius: 24,
                                    spreadRadius: -1,
                                    offset: Offset(0, 4))
                              ],
                              gradient: (orderList[index].type == 'Invoice')
                                  ? LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                          Color(0xFF5FAAEF),
                                          Color(0xFF979DFA),
                                        ],
                                      stops: [
                                          0.0,
                                          1.0,
                                        ])
                                  : LinearGradient(
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
                              borderRadius: BorderRadius.circular(8.0),
                              // image: DecorationImage(
                              //     image: AssetImage(atReexCard), fit: BoxFit.cover),
                              color: white,
                            ),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    child: Text(
                                      orderList[index].receiver,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'BeVietnamPro',
                                          color: white,
                                          height: 1.4),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    child: Text(
                                      'Order Code: ' + orderList[index].code,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'BeVietnamPro',
                                          color: white,
                                          height: 1.4),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: (orderList[index].type ==
                                                'Invoice')
                                            ? Text(
                                                "Total: + "
                                                        "\$ " +
                                                    orderList[index].total +
                                                    ' VND',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'BeVietnamPro',
                                                    color: white,
                                                    height: 1.4),
                                                textAlign: TextAlign.right,
                                              )
                                            : Text(
                                                "Total: - "
                                                        "\$ " +
                                                    orderList[index].total +
                                                    ' VND',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'BeVietnamPro',
                                                    color: white,
                                                    height: 1.4),
                                                textAlign: TextAlign.right,
                                              ),
                                      ),
                                      Spacer(),
                                      Container(
                                        child: Text(
                                          orderList[index].date,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'BeVietnamPro',
                                              color: white,
                                              height: 1.4),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
