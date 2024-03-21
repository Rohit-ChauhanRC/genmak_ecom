import 'dart:io';

import 'package:genmak_ecom/app/data/database/product_db.dart';
import 'package:genmak_ecom/app/modules/home/controllers/home_controller.dart';
import 'package:genmak_ecom/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddProductController extends GetxController {
  //

  GlobalKey<FormState> productsFormKey = GlobalKey<FormState>();

  final ProductDB productDB = ProductDB();

  final HomeController homeController = Get.find();

  final RxString _decription = ''.obs;
  String get decription => _decription.value;
  set decription(String des) => _decription.value = des;

  final RxString _name = ''.obs;
  String get name => _name.value;
  set name(String str) => _name.value = str;

  final RxString _weight = ''.obs;
  String get weight => _weight.value;
  set weight(String w) => _weight.value = w;

  final RxString _quantity = '0'.obs;
  String get quantity => _quantity.value;
  set quantity(String q) => _quantity.value = q;

  final RxString _price = '0.0'.obs;
  String get price => _price.value;
  set price(String p) => _price.value = p;

  final Rx<XFile> _personPic = Rx<XFile>(XFile(''));
  XFile get personPic => _personPic.value;
  set personPic(XFile v) => _personPic.value = v;

  final RxString _gst = ''.obs;
  String get gst => _gst.value;
  set gst(String g) => _gst.value = g;

  final RxString _discount = '0.0'.obs;
  String get discount => _discount.value;
  set discount(String d) => _discount.value = d;

  final RxString _hsnCode = ''.obs;
  String get hsnCode => _hsnCode.value;
  set hsnCode(String h) => _hsnCode.value = h;

  final RxInt _check = 0.obs;
  int get check => _check.value;
  set check(int i) => _check.value = i;

  final RxString _unit = 'NOS'.obs;
  String get unit => _unit.value;
  set unit(String str) => _unit.value = str;

  final listOfMea = ["KG", "GM", "ML", "NOS", "LTR"];

  @override
  void onInit() async {
    super.onInit();
    await permissionCheck();
    await homeController.fetchProduct();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> permissionCheck() async {
    await Permission.camera.request();
    await Permission.mediaLibrary.request();
  }

  void getImage1() {
    Utils.showImagePicker(onGetImage: (image) {
      if (image != null) {
        personPic = image;
      }
    });
  }

  bool checkProductsExist() {
    bool b = true;
    // homeController.products;
    for (var i = 0; i < homeController.products.length; i++) {
      if (homeController.products.isNotEmpty) {
        if (homeController.products[i].name!.trim().toLowerCase().toString() !=
                name.toLowerCase().toString() &&
            homeController.products[i].unit!.trim().toLowerCase().toString() !=
                unit.toLowerCase().toString() &&
            homeController.products[i].price!.trim().toLowerCase().toString() !=
                price.toLowerCase().toString()) {
          b = true;
        } else if (homeController.products[i].name!
                    .trim()
                    .toLowerCase()
                    .toString() ==
                name.toLowerCase().toString() &&
            homeController.products[i].unit!.trim().toLowerCase().toString() ==
                unit.toLowerCase().toString() &&
            homeController.products[i].price!.trim().toLowerCase().toString() ==
                price.toLowerCase().toString()) {
          print(
              "homeController.products[i].name:${homeController.products[i].name}");
          print("name:$name, weight:$weight, unit:$unit");
          Utils.showDialog("This Product already exit!");
          b = false;
        }
      }
    }
    return b;
  }

  void checkValidate() async {
    if (!productsFormKey.currentState!.validate()) {
      return null;
    }
    checkProductsExist();
    // if (checkProductsExist() != true) {
    //   return null;
    // }
    if (personPic.path.isNotEmpty && unit.isNotEmpty) {
      await createproductTable();
    } else {
      Utils.showDialog("Please upload product image!");
    }
  }

  Future<void> createproductTable() async {
    await productDB
        .create(
      name: name.trim().toUpperCase(),
      weight: weight.trim(),
      price: price.trim(),
      quantity: quantity.trim(),
      active: check,
      gst: gst.trim(),
      discount: discount.trim(),
      hsnCode: hsnCode,
      unit: unit,
      description: decription.trim(),
      picture: File(personPic.path.toString()).readAsBytesSync(),
    )
        .then((value) async {
      await homeController.fetchProduct().then((value) => {Get.back()});
    });
  }
}
