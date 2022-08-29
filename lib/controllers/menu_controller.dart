import 'package:binkstoreap/assets/constants/colors.dart';
import 'package:binkstoreap/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = DashboardRoute.obs;
  var hoverItem = ''.obs;
  changeActiveItem(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;
  isHover(String itemName) => hoverItem.value == itemName;
  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case DashboardRoute:
        return customIcon(Icons.home, itemName);
      case ProductRoute:
        return customIcon(Icons.create, itemName);
      case OrderRoute:
        return customIcon(Icons.history, itemName);
      default:
        return customIcon(Icons.home, itemName);
    }
  }

  Widget customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) return Icon(icon, size: 24, color: black);
    return Icon(icon, color: isHover(itemName) ? black : pp);
  }
}
