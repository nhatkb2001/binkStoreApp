import 'package:binkstoreap/assets/constants/colors.dart';
import 'package:binkstoreap/assets/constants/images.dart';
import 'package:binkstoreap/models/productModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:iconsax/iconsax.dart';

class atProductDetail extends StatefulWidget {
  String idProduct;
  atProductDetail({Key? key, required this.idProduct}) : super(key: key);
  @override
  _atProductDetail createState() => _atProductDetail(this.idProduct);
}

class _atProductDetail extends State<atProductDetail>
    with SingleTickerProviderStateMixin {
  String idProduct = '';
  _atProductDetail(this.idProduct);

  @override
  void initState() {
    super.initState();
    getProductInfor();
  }

  productModel product = productModel(
      id: '',
      description: '',
      code: '',
      importPrice: '',
      price: '',
      type: '',
      link: '',
      name: '',
      images: [],
      quantity: '');

  Future getProductInfor() async {
    FirebaseFirestore.instance
        .collection('products')
        .where('id', isEqualTo: widget.idProduct)
        .snapshots()
        .listen((value) {
      setState(() {
        product = productModel.fromDocument(value.docs.first.data());
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
          Container(
              height: 400,
              width: 400,
              child: PageView.builder(
                  itemCount: product.images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 400,
                      width: 400,
                      child: Image(
                        image: NetworkImage(product.images[index]),
                        fit: BoxFit.cover,
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
                    );
                  })),
          Container(
            height: 28,
            width: 28,
            margin: EdgeInsets.only(left: 24, top: 24),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 28,
                color: black,
              ),
            ),
          ),
          Container(
            height: 450 + 50,
            width: 400,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            margin: EdgeInsets.only(top: 350),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin: EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32),
                    Container(
                        child: Text(
                      product.name,
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w600,
                          color: black),
                    )),
                    SizedBox(height: 8),
                    Container(
                        child: Text(
                      'Type: ' + product.type,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w400,
                          color: gray),
                    )),
                    SizedBox(height: 8),
                    Container(
                        child: Text(
                      'Product Code: ' + product.code,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'BeVietnamPro',
                          fontWeight: FontWeight.w400,
                          color: gray),
                    )),
                    SizedBox(height: 16),
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
                    SizedBox(height: 16),
                    Container(
                      child: Text(
                        "Price: "
                                "\$ " +
                            product.price +
                            ' VND',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'BeVietnamPro',
                          color: Colors.orange,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      child: Text(
                        'Import Price: ' "\$ " + product.importPrice + ' VND',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'BeVietnamPro',
                          color: pp,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      child: Text(
                        'Quantity: ' + product.quantity,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'BeVietnamPro',
                          color: black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 60, left: 70),
                      height: 48,
                      width: 200,
                      alignment: Alignment.center,
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
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: pp),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Edit Product",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'BeVietnamPro',
                              color: white,
                              height: 1.4),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, left: 70),
                      height: 48,
                      width: 200,
                      alignment: Alignment.center,
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
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: pp),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Delete Product",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'BeVietnamPro',
                              color: white,
                              height: 1.4),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
