import 'package:binkstoreap/models/orderDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class orderModel {
  final String id;
  final String note;
  final String code;
  final String receiver;
  final String date;
  final String discount;
  final String total;
  final String type;
  final String timeDetail;
  List orderDetails;

  orderModel(
      {required this.id,
      required this.note,
      required this.code,
      required this.receiver,
      required this.date,
      required this.discount,
      required this.type,
      required this.total,
      required this.timeDetail,
      required this.orderDetails});

  factory orderModel.fromDocument(Map<String, dynamic> doc) {
    return orderModel(
      id: doc['id'],
      note: doc['note'],
      code: doc['code'],
      receiver: doc['receiver'],
      date: doc['date'],
      discount: doc['discount'],
      total: doc['total'],
      type: doc['type'],
      timeDetail: doc['timeDetail'],
      orderDetails: doc['orderDetails'],
    );
  }
}
