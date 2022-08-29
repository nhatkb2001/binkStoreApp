import 'package:binkstoreap/assets/constants/colors.dart';
import 'package:binkstoreap/assets/constants/images.dart';
import 'package:binkstoreap/models/productModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:iconsax/iconsax.dart';

class productWidget extends StatefulWidget {
  String id;
  int index;
  int count;
  int price;
  int total;

  productWidget(
      {Key? key,
      required this.index,
      required this.count,
      required this.price,
      required this.total,
      required this.id})
      : super(key: key);
  @override
  _productWidget createState() =>
      _productWidget(this.index, this.count, this.price, this.total, this.id);
}

class _productWidget extends State<productWidget>
    with SingleTickerProviderStateMixin {
  String id = '';
  int index = 0;
  _productWidget(this.index, this.count, this.total, this.price, this.id);
  int count = 1;
  int price = 0;
  int total = 0;

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
        .where('id', isEqualTo: widget.id)
        .snapshots()
        .listen((value) {
      setState(() {
        product = productModel.fromDocument(value.docs.first.data());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    total = price;
    getProductInfor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (widget.index == 0)
          ? BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            )
          : BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
      width: 319 + 14,
      height: 48 + 8 + 17,
      padding: EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: blueLight,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                )),
            height: 30,
            width: 30,
            child: Center(
              child: Text(
                '${widget.index + 1}',
                style: TextStyle(
                  fontFamily: "BeVietnamPro",
                  fontSize: 16,
                  color: black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 319 - 144 - 2 - 4,
                  child: Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: "BeVietnamPro",
                        fontSize: 12,
                        color: black,
                        fontWeight: FontWeight.w600,
                        height: 1.4),
                  ),
                ),
                SizedBox(height: 2),
                Container(
                  child: Text(
                    'Quantity: ' + product.quantity,
                    style: TextStyle(
                        fontFamily: "BeVietnamPro",
                        fontSize: 12,
                        color: black,
                        fontWeight: FontWeight.w600,
                        height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 8),
            child: Text(
              (widget.total).toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'BeVietnamPro',
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.count = widget.count + 1;
                    widget.total = widget.price * widget.count;
                  });
                },
                child: Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                      color: pp,
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                  child: Icon(Icons.add, size: 10, color: white),
                ),
              ),
              SizedBox(height: 2),
              Container(
                child: Text(
                  widget.count.toString(),
                  style: TextStyle(
                      fontFamily: "BeVietnamPro",
                      fontSize: 12,
                      color: black,
                      fontWeight: FontWeight.w600,
                      height: 1.4),
                ),
              ),
              SizedBox(height: 2),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (widget.count > 1) {
                      widget.count = widget.count - 1;
                      widget.total = widget.price * widget.count;
                    } else {
                      widget.count = 1;
                    }
                  });
                },
                child: Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                      color: gray,
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                  child: Icon(Iconsax.minus, size: 10, color: white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
