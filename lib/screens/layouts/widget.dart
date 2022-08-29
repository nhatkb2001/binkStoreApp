import 'package:binkstoreap/assets/constants/colors.dart';
import 'package:binkstoreap/models/orderDetail.dart';
import 'package:binkstoreap/models/productModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

datePickerDialog(BuildContext context, selectDate, category) {
  return showRoundedDatePicker(
      height: 320,
      context: context,
      fontFamily: "Urbanist",
      initialDate: selectDate,
      firstDate: DateTime(1900),
      lastDate: (category == "dob") ? DateTime.now() : DateTime(2050),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        //Section 1
        paddingDateYearHeader: EdgeInsets.all(8),
        backgroundHeader: pp,
        textStyleDayButton: TextStyle(
            fontFamily: "Urbanist",
            fontSize: 16,
            color: white,
            fontWeight: FontWeight.w500,
            height: 1.0),
        textStyleYearButton: TextStyle(
          fontFamily: "Urbanist",
          fontSize: 24,
          color: white,
          fontWeight: FontWeight.w500,
        ),

        //Section 2
        textStyleMonthYearHeader: TextStyle(
          fontFamily: "Urbanist",
          fontSize: 16,
          color: white,
          fontWeight: FontWeight.w600,
        ),
        backgroundHeaderMonth: pp,
        paddingMonthHeader: EdgeInsets.only(top: 12, bottom: 12),
        sizeArrow: 24,
        colorArrowNext: white,
        colorArrowPrevious: white,
        // marginLeftArrowPrevious: 8,
        // marginTopArrowPrevious: 0,
        // marginTopArrowNext: 0,
        // marginRightArrowNext: 8,

        //Section 3
        paddingDatePicker: EdgeInsets.all(0),
        backgroundPicker: pp,
        textStyleDayHeader: TextStyle(
          fontFamily: "Urbanist",
          fontSize: 16,
          color: white,
          fontWeight: FontWeight.w600,
        ),
        textStyleDayOnCalendar: TextStyle(
          fontFamily: "Urbanist",
          fontSize: 16,
          color: white,
          fontWeight: FontWeight.w400,
        ),
        textStyleDayOnCalendarSelected: TextStyle(
          fontFamily: "Urbanist",
          fontSize: 16,
          color: black,
          fontWeight: FontWeight.w600,
        ),

        decorationDateSelected: BoxDecoration(
          color: white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.10),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),

        textStyleDayOnCalendarDisabled:
            TextStyle(fontSize: 20, color: white.withOpacity(0.1)),

        textStyleCurrentDayOnCalendar: TextStyle(
          fontFamily: "Urbanist",
          fontSize: 20,
          color: black,
          fontWeight: FontWeight.w700,
        ),

        //Section 4
        paddingActionBar: EdgeInsets.all(8),
        backgroundActionBar: pp,
        textStyleButtonAction: TextStyle(
          fontFamily: "Urbanist",
          fontSize: 16,
          color: white,
          fontWeight: FontWeight.w600,
        ),
        textStyleButtonPositive: TextStyle(
          fontFamily: "Urbanist",
          fontSize: 16,
          color: white,
          fontWeight: FontWeight.w600,
        ),
        textStyleButtonNegative: TextStyle(
          fontFamily: "Urbanist",
          fontSize: 16,
          color: white,
          fontWeight: FontWeight.w600,
        ),
      ),
      styleYearPicker: MaterialRoundedYearPickerStyle(
        textStyleYear: TextStyle(
            fontFamily: "Urbanist",
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w400),
        textStyleYearSelected: TextStyle(
            fontFamily: "Urbanist",
            fontSize: 48,
            color: Colors.white,
            fontWeight: FontWeight.w600),
        heightYearRow: 80,
        backgroundPicker: gray,
      ));
}
// Future searchCaption() async {
//     FirebaseFirestore.instance.collection("product").snapshots().listen((value) {
//       setState(() {
//         postListCaption.clear();
//         postList.clear();
//         value.docs.forEach((element) {
//           postListCaption.add(postModel.fromDocument(element.data()));
//         });

//         postListCaption.forEach((element) {
//           print((element.caption
//                   .toUpperCase()
//                   .contains(search.toUpperCase().trim())) ==
//               true);
//           if (((element.caption + " ")
//                   .toUpperCase()
//                   .contains(search.toUpperCase().trim())) ==
//               true) {
//             postList.add(element);
//             print(postList.length);
//           }
//         });
//       });
//     });
//   }
TextEditingController searchController = TextEditingController();
List<productModel> productsChoice = [];
orderDetailModel orderDetail = orderDetailModel();
addProductDialog(BuildContext mContext, List<productModel> products) {
  productsChoice = products;
  return showDialog(
      context: mContext,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.all(28),
          backgroundColor: white,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: 319,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 28, left: 28),
                          alignment: Alignment.center,
                          child: Form(
                            // key: searchFormKey,
                            child: Container(
                              width: 230,
                              height: 36,
                              padding: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: white),
                              alignment: Alignment.topCenter,
                              child: TextFormField(
                                  controller: searchController,
                                  onEditingComplete: () {
                                    setState(() {
                                      print(products.length);
                                      productsChoice.clear();
                                      products.forEach((element) {
                                        print(element.name
                                            .toUpperCase()
                                            .contains((searchController.text)
                                                .toUpperCase()));
                                        if ((element.name
                                                .toUpperCase()
                                                .contains(
                                                    (searchController.text)
                                                        .toUpperCase())) ==
                                            true) {
                                          productsChoice.add(element);
                                        }
                                        // ;
                                        // if (((element.code + " ")
                                        //         .toUpperCase()
                                        //         .contains((searchController.text)
                                        //             .toUpperCase()
                                        //             .trim())) ==
                                        //     true) {
                                        //   productsChoice.add(element);
                                        // }
                                      }); //
                                    });
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      productsChoice.clear();

                                      products.forEach((element) {
                                        print(element.name
                                            .toUpperCase()
                                            .contains((searchController.text)
                                                .toUpperCase()));
                                        if ((element.name
                                                .toUpperCase()
                                                .contains(
                                                    (searchController.text)
                                                        .toUpperCase())) ==
                                            true) {
                                          productsChoice.add(element);
                                        }
                                        // ;
                                        // if (((element.code + " ")
                                        //         .toUpperCase()
                                        //         .contains((searchController.text)
                                        //             .toUpperCase()
                                        //             .trim())) ==
                                        //     true) {
                                        //   productsChoice.add(element);
                                        // }
                                      }); //
                                    });
                                  },
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontSize: 12,
                                      color: black,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5),
                                  // controller: searchController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    prefixIcon: Container(
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                          Icon(Iconsax.search_normal_1,
                                              size: 16, color: black)
                                        ])),
                                    border: InputBorder.none,
                                    hintText:
                                        "Search by entering name or code of product",
                                    hintStyle: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontSize: 12,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.w400,
                                        height: 1.6),
                                  )),
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.only(top: 28),
                          onPressed: () {
                            searchController.clear();
                            Navigator.pop(
                              context,
                            );
                          },
                          icon: Icon(Iconsax.close_square,
                              size: 20, color: black),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(left: 28, right: 28),
                      child: Container(
                        width: 263,
                        height: 48 * 4,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  orderDetail = orderDetailModel(
                                      id: products[index].id,
                                      count: int.parse('1'),
                                      total: int.parse(products[index].price),
                                      quantity:
                                          int.parse(products[index].quantity),
                                      price: int.parse(products[index].price));
                                });
                                Navigator.of(context).pop(orderDetail);
                              },
                              child: Container(
                                width: 263,
                                height: 48 + 10,
                                decoration: BoxDecoration(
                                  color: white,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(width: 16),
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    // '${projects[index]!["background"]}'),
                                                    productsChoice[index]
                                                        .images[0]),
                                                fit: BoxFit.cover),
                                            shape: BoxShape.rectangle,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  productsChoice[index].name,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily:
                                                          'BeVietnamPro',
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1.2),
                                                )),
                                            Container(
                                              width: 263 - 40 - 32,
                                              child: Row(
                                                children: [
                                                  Container(
                                                      // alignment: Alignment.topLeft,
                                                      child: Text(
                                                          productsChoice[index]
                                                              .code,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'BeVietnamPro',
                                                            color: gray,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ))),
                                                  Spacer(),
                                                  Container(
                                                      // alignment: Alignment.topLeft,
                                                      child: Text(
                                                          productsChoice[index]
                                                              .type,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'BeVietnamPro',
                                                            color: gray,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ))),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 0.5,
                                      color: gray,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
        );
      });
}
