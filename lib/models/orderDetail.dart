import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class orderDetailModel {
  String id;
  int count;
  int quantity;
  int total;
  int price;

  orderDetailModel({
    this.id = "",
    this.count = 0,
    this.total = 0,
    this.quantity = 0,
    this.price = 0,
  });
}
