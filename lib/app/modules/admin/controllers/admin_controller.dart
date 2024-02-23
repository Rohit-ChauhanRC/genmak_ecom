import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AdminController extends GetxController {
  //
  final List gridList = [
    {
      "icon": Icons.manage_accounts_outlined,
      "title": "Add products",
      "onTap": () {
        Get.toNamed(Routes.ADD_PRODUCT);
      },
    },
    {
      "icon": Icons.local_shipping_rounded,
      "title": "Add Vendor",
      "onTap": () {
        Get.toNamed(Routes.ADD_VENDOR);
      },
    },
    {
      "icon": Icons.list,
      "title": "Product List",
      "onTap": () {
        Get.toNamed(Routes.PRODUCT_LIST);
      },
    },
    {
      "icon": Icons.local_shipping_rounded,
      "title": "Vendor List",
      "onTap": () {
        Get.toNamed(Routes.VENDOR_LIST);
      },
    },
    {
      "icon": Icons.receipt_long_rounded,
      "title": "Receive products",
      "onTap": () {
        Get.toNamed(Routes.RECEIVE_PRODUCTS);
      },
    },
    {
      "icon": Icons.shopping_cart_rounded,
      "title": "Total Order",
      "onTap": () {
        Get.toNamed(Routes.TOTAL_ORDERS);
      },
    },
    {
      "icon": Icons.list,
      "title": MediaQuery.of(Get.context!).size.width > 650
          ? "Customer Billing List"
          : "Customer \nBilling List",
      "onTap": () {
        Get.toNamed(Routes.CUTOMER_BILLING_LIST);
      },
    },
    {
      "icon": Icons.restore,
      "title": "Restore Data",
      "onTap": () {
        Get.toNamed(Routes.RESTORE_DATA);
      },
    },
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
