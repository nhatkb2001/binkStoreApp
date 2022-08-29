import 'package:binkstoreap/assets/constants/colors.dart';
import 'package:binkstoreap/assets/constants/images.dart';
import 'package:binkstoreap/models/orderDetail.dart';
import 'package:binkstoreap/models/productModel.dart';
import 'package:binkstoreap/screens/products/productWidget.dart';
import 'package:binkstoreap/screens/layouts/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class atImportGoods extends StatefulWidget {
  atImportGoods({Key? key}) : super(key: key);
  @override
  _atImportGoods createState() => _atImportGoods();
}

class _atImportGoods extends State<atImportGoods>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  double totalOrder = 0.0;

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

  List<orderDetailModel> ordersDetail = [];
  List<orderDetailModel> importDetail = [];

  late DateTime selectDate = DateTime.now();
  TextEditingController receiverController = TextEditingController();
  final GlobalKey<FormState> receiverFormKey = GlobalKey<FormState>();

  TextEditingController noteController = TextEditingController();
  final GlobalKey<FormState> noteFormKey = GlobalKey<FormState>();

  TextEditingController discountController = TextEditingController();
  final GlobalKey<FormState> discountFormKey = GlobalKey<FormState>();
  int orderCode = 0;

  Future createOrder() async {
    FirebaseFirestore.instance.collection('orders').snapshots().listen((value) {
      orderCode = value.docs.length;
      print(orderCode);
    });
    List orderDetailsList = [];
    for (int i = 0; i < ordersDetail.length; i++)
      orderDetailsList.add({
        'id': ordersDetail.toList()[i].id,
        'count': ordersDetail.toList()[i].count,
        'price': ordersDetail.toList()[i].price,
        'quantity': ordersDetail.toList()[i].quantity,
        'total': ordersDetail.toList()[i].total,
      });

    ordersDetail.forEach((element) {
      FirebaseFirestore.instance
          .collection('products')
          .doc(element.id)
          .update({'quantity': (element.quantity + element.count).toString()});
    });

    FirebaseFirestore.instance.collection('orders').add({
      'id': '',
      'receiver': receiverController.text,
      'code': '#000' + orderCode.toString(),
      'note': noteController.text,
      'type': 'Import',
      'date': "${DateFormat('y MMMM d').format(selectDate)}",
      'timeDetail':
          "${DateFormat('y MMMM d, hh:mm:ss').format(DateTime.now())}",
      'discount': '',
      'total': totalOrder.toStringAsFixed(0).toString(),
      'orderDetails': FieldValue.arrayUnion(orderDetailsList)
    }).then((value) {
      FirebaseFirestore.instance
          .collection('orders')
          .doc(value.id)
          .update({'id': value.id});
    }).then((value) => Navigator.pop(context));
  }

  List idList = [];

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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Iconsax.back_square,
                          size: 28,
                          color: pp,
                        ),
                      ),
                      SizedBox(width: 16),
                      Container(
                          child: Text(
                        'Import Goods',
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Recoleta',
                            fontWeight: FontWeight.w500,
                            color: pp),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Lottie.network(
                          'https://assets3.lottiefiles.com/packages/lf20_kp4phlgj.json'),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Title',
                      style: TextStyle(
                        fontFamily: "Recoleta",
                        fontSize: 20.0,
                        color: black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Form(
                    key: receiverFormKey,
                    child: Container(
                      width: 327 + 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.topCenter,
                      child: TextFormField(
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontSize: 14,
                              color: black,
                              fontWeight: FontWeight.w400),
                          //validator
                          validator: (email) {},
                          controller: receiverController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 16, right: 16),
                            hintStyle: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: black.withOpacity(0.5)),
                            hintText: "Write the title ",
                            filled: true,
                            fillColor: blueLight,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorStyle: TextStyle(
                              color: Colors.transparent,
                              fontSize: 0,
                              height: 0,
                            ),
                          )),
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    child: Text(
                      'Datetime',
                      style: TextStyle(
                        fontFamily: "Recoleta",
                        fontSize: 20.0,
                        color: black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () async {
                        String category = "dob";
                        DateTime? dt = await datePickerDialog(
                            context, selectDate, category);
                        if (dt != null) {
                          selectDate = dt;
                          setState(() {
                            selectDate != selectDate;
                          });
                        }
                        print(selectDate);
                      },
                      child: AnimatedContainer(
                          alignment: Alignment.center,
                          duration: Duration(milliseconds: 300),
                          height: 48,
                          width: 180,
                          decoration: BoxDecoration(
                            color: blueLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 12),
                              Container(
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Iconsax.calendar_1,
                                    size: 16,
                                    color: black,
                                  )),
                              SizedBox(width: 8),
                              Text(
                                "${DateFormat('yMMMMd').format(selectDate)}",
                                style: TextStyle(
                                  color: gray,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 4),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    child: Text(
                      'Note',
                      style: TextStyle(
                        fontFamily: "Recoleta",
                        fontSize: 20.0,
                        color: black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Form(
                      key: noteFormKey,
                      child: Container(
                        width: 319,
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: blueLight),
                        alignment: Alignment.topCenter,
                        child: TextFormField(
                            style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontSize: 14,
                                color: black,
                                fontWeight: FontWeight.w400),
                            controller: noteController,
                            keyboardType: TextInputType.text,
                            //validator
                            validator: (note) {},
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 20, right: 12),
                              hintStyle: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: gray),
                              hintText: "What's the note?",
                              filled: true,
                              fillColor: blueLight,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorStyle: TextStyle(
                                color: Colors.transparent,
                                fontSize: 0,
                                height: 0,
                              ),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    child: Text(
                      'Details of goods',
                      style: TextStyle(
                        fontFamily: "Recoleta",
                        fontSize: 20.0,
                        color: black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: ordersDetail.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          height: 1,
                          child: Divider(color: gray, thickness: 0.2),
                        ),
                        itemBuilder: (context, index) {
                          return productWidget(
                            index: index,
                            count: ordersDetail[index].count,
                            id: ordersDetail[index].id,
                            price: ordersDetail[index].price,
                            total: ordersDetail[index].total,
                          );
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          addProductDialog(context, listProduct).then((value) {
                            if (idList.isEmpty == true) {
                              setState(() {
                                idList.add(value.id);
                                ordersDetail.add(value);
                              });
                            } else {
                              if (idList.contains(value.id) == false) {
                                setState(() {
                                  idList.add(value.id);
                                  ordersDetail.add(value);
                                });
                              }
                            }
                          });
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
                              borderRadius: (ordersDetail.length == 0)
                                  ? BorderRadius.all(Radius.circular(8))
                                  : BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 21),
                                Container(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.center,
                                    child: Icon(Iconsax.add,
                                        size: 20, color: white)),
                                SizedBox(width: 21),
                                Text(
                                  "New Goods",
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
                      SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                totalOrder = 0.0;
                                ordersDetail.forEach((element) {
                                  totalOrder = totalOrder + element.total;
                                });
                              });
                            },
                            child: Text(
                              'Total Money:',
                              style: TextStyle(
                                fontFamily: "Recoleta",
                                fontSize: 20,
                                color: black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Text(
                              '-' + totalOrder.toStringAsFixed(0) + ' VND',
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: Color.fromARGB(255, 244, 91, 99),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'BeVietnamPro',
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            createOrder();
                          },
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: 200,
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
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Create",
                                  style: TextStyle(
                                    color: white,
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
