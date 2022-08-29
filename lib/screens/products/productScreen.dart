import 'package:binkstoreap/assets/constants/colors.dart';
import 'package:binkstoreap/assets/constants/images.dart';
import 'package:binkstoreap/models/productModel.dart';
import 'package:binkstoreap/screens/products/createProduct.dart';
import 'package:binkstoreap/screens/products/productDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class atProductScreen extends StatefulWidget {
  atProductScreen({Key? key}) : super(key: key);
  @override
  _atProductScreen createState() => _atProductScreen();
}

class _atProductScreen extends State<atProductScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();
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
              margin: EdgeInsets.only(left: 14, right: 14, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.pop(context);
                          Get.back();
                        },
                        child: Icon(
                          Iconsax.back_square,
                          size: 28,
                          color: pp,
                        ),
                      ),
                      SizedBox(width: 16),
                      Form(
                        key: searchFormKey,
                        child: Container(
                          width: 200 + 100 + 24 - 3,
                          height: 32,
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
                              controller: searchController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 16, right: 16),
                                hintStyle: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: black.withOpacity(0.5)),
                                hintText: "Write the name or code of product ",
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
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                          child: Text(
                        'Products',
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Recoleta',
                            fontWeight: FontWeight.w500,
                            color: pp),
                      )),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => atCreateProduct())));
                        },
                        child: Icon(
                          Iconsax.add_square,
                          size: 28,
                          color: pp,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 400 + 320,
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
                                listviewProduct(listSticker),
                                listviewProduct(listWashiTape),
                                listviewProduct(listNotebook),
                                listviewProduct(listPen),
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

  listviewProduct(List<productModel> productList) {
    return Container(
      height: 400 + 320 + 7,
      margin: EdgeInsets.only(bottom: 32),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => atProductDetail(
                            idProduct: productList[index].id))));
              },
              child: Container(
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
                  borderRadius: BorderRadius.circular(8.0),
                  // image: DecorationImage(
                  //     image: AssetImage(atReexCard), fit: BoxFit.cover),
                  color: white,
                ),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          child: Image(
                            image: NetworkImage(productList[index].images[0]),
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
                          borderRadius: BorderRadius.circular(8.0),
                          // image: DecorationImage(
                          //     image: AssetImage(atReexCard), fit: BoxFit.cover),
                          color: white,
                        ),
                      ),
                      SizedBox(width: 24),
                      Container(
                        width: 300 - 75,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                productList[index].name,
                                maxLines: 1,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'BeVietnamPro',
                                    color: black,
                                    height: 1.4),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  child: Container(
                                    width: 100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Code: ' + productList[index].code,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: 'BeVietnamPro',
                                              color: black,
                                              height: 1.4),
                                          textAlign: TextAlign.left,
                                        ),
                                        Container(
                                          child: Text(
                                            'Quantity: ' +
                                                productList[index].quantity,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                fontFamily: 'BeVietnamPro',
                                                color: black,
                                                height: 1.4),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  // height: 48,
                                  // width: 100,
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
                                      "\$ " +
                                          productList[index].price +
                                          '0 VND',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'BeVietnamPro',
                                          color: white,
                                          height: 1.4),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
