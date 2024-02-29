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

  GlobalKey<FormState>? productsFormKey = GlobalKey<FormState>();

  final ProductDB productDB = ProductDB();

  final HomeController homeController = Get.find();

  final RxString _decription = ''.obs;
  String get decription => _decription.value;
  set decription(String mobileNumber) => _decription.value = decription;

  final RxString _name = ''.obs;
  String get name => _name.value;
  set name(String str) => _name.value = str;

  final RxString _weight = ''.obs;
  String get weight => _weight.value;
  set weight(String str) => _weight.value = str;

  final RxString _quantity = '0'.obs;
  String get quantity => _quantity.value;
  set quantity(String str) => _quantity.value = str;

  final RxString _price = '0.0'.obs;
  String get price => _price.value;
  set price(String str) => _price.value = str;

  final Rx<XFile> _personPic = Rx<XFile>(XFile(''));
  XFile get personPic => _personPic.value;
  set personPic(XFile v) => _personPic.value = v;

  final RxString _gst = ''.obs;
  String get gst => _gst.value;
  set gst(String str) => _gst.value = str;

  final RxString _discount = '0.0'.obs;
  String get discount => _discount.value;
  set discount(String str) => _discount.value = str;

  final RxString _hsnCode = ''.obs;
  String get hsnCode => _hsnCode.value;
  set hsnCode(String str) => _hsnCode.value = str;

  final RxInt _check = 0.obs;
  int get check => _check.value;
  set check(int i) => _check.value = i;

  final RxString _unit = 'NOS'.obs;
  String get unit => _unit.value;
  set unit(String str) => _unit.value = str;

  final listOfMea = ["KG", "GM", "ML", "NOS"];

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

  void checkValidate() async {
    if (!productsFormKey!.currentState!.validate()) {
      return null;
    }
    if (personPic.path.isNotEmpty && unit.isNotEmpty) {
      await createproductTable();
    } else {
      Utils.showDialog("Please upload product image!");
    }
  }

  Future<void> createproductTable() async {
    await productDB
        .create(
      name: name.toUpperCase(),
      weight: weight,
      price: price,
      quantity: quantity,
      active: check,
      gst: gst,
      discount: discount,
      hsnCode: hsnCode,
      unit: unit,
      picture: File(personPic.path.toString()).readAsBytesSync(),
    )
        .then((value) async {
      await homeController.fetchProduct().then((value) => {Get.back()});
    });
  }
}
