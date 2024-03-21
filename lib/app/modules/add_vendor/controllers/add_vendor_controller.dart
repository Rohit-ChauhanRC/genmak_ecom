import 'package:genmak_ecom/app/modules/home/controllers/home_controller.dart';
import 'package:genmak_ecom/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddVendorController extends GetxController {
  //
  GlobalKey<FormState>? vendorFormKey = GlobalKey<FormState>();

  // final VendorDB vendorDB = VendorDB();
  final HomeController homeController = Get.find();

  final RxString _mobileNumber = ''.obs;
  String get mobileNumber => _mobileNumber.value;
  set mobileNumber(String mobileNumber) => _mobileNumber.value = mobileNumber;

  final RxString _name = ''.obs;
  String get name => _name.value;
  set name(String str) => _name.value = str;

  final RxString _gst = ''.obs;
  String get gst => _gst.value;
  set gst(String str) => _gst.value = str;

  final RxString _address = ''.obs;
  String get address => _address.value;
  set address(String str) => _address.value = str;

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

  bool checkvendorsExist() {
    bool b = true;
    // homeController.products;
    for (var i = 0; i < homeController.vendors.length; i++) {
      if (homeController.vendors.isNotEmpty) {
        if (homeController.vendors[i].name!.trim().toLowerCase().toString() !=
                name.toLowerCase().toString() &&
            homeController.vendors[i].mobileNo!
                    .toString()
                    .trim()
                    .toLowerCase()
                    .toString() !=
                mobileNumber.toLowerCase().toString() &&
            homeController.vendors[i].gst!.trim().toLowerCase().toString() !=
                gst.toLowerCase().toString()) {
          b = true;
        } else if (homeController.vendors[i].name!
                    .trim()
                    .toLowerCase()
                    .toString() ==
                name.toLowerCase().toString() &&
            homeController.vendors[i].mobileNo!
                    .toString()
                    .trim()
                    .toLowerCase()
                    .toString() ==
                mobileNumber.toLowerCase().toString() &&
            homeController.vendors[i].gst!.trim().toLowerCase().toString() ==
                gst.toLowerCase().toString()) {
          Utils.showDialog("This Vendor already exit!");
          b = false;
        }
      }
    }
    return b;
  }

  void checkValidate() async {
    if (!vendorFormKey!.currentState!.validate()) {
      return null;
    }
    checkvendorsExist();
    await createVendorTable().then((value) => Get.back());
  }

  Future<void> createVendorTable() async {
    await homeController.vendorDB
        .create(
      name: name.trim().toUpperCase(),
      address: address.trim(),
      gst: gst.trim(),
      mobileNo: int.tryParse(mobileNumber.trim()),
    )
        .then((value) async {
      homeController.vendors
          .assignAll(await homeController.vendorDB.fetchAll());
    });
  }
}
