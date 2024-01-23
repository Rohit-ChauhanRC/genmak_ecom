import 'package:genmak_ecom/app/data/database/vendor_db.dart';
import 'package:genmak_ecom/app/modules/vendor_list/controllers/vendor_list_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditVendorController extends GetxController {
  GlobalKey<FormState>? vendorFormKey = GlobalKey<FormState>();

  final VendorDB vendorDB = VendorDB();
  final VendorListController _controller = Get.find();

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

  final RxBool _progresBar = RxBool(true);
  bool get progressBar => _progresBar.value;
  set progressBar(bool b) => _progresBar.value = b;

  @override
  void onInit() async {
    super.onInit();
    await fetchProductById();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void checkValidate() async {
    if (!vendorFormKey!.currentState!.validate()) {
      return null;
    }
    await updateVendorTable();
  }

  Future<void> updateVendorTable() async {
    await vendorDB
        .update(
      id: Get.arguments!,
      name: name,
      address: address,
      gst: gst,
      mobileNo: int.tryParse(mobileNumber),
    )
        .then((value) async {
      await _controller.fetchAll().then((value) => Get.back());
    });
  }

  Future<void> deleteProductTable() async {
    await vendorDB
        .delete(
      id: Get.arguments!,
    )
        .then((value) async {
      await vendorDB.fetchAll().then((value) => Get.back());
    });
  }

  Future<void> fetchProductById() async {
    await vendorDB.fetchById(Get.arguments!).then((value) {
      name = value.name!;
      address = value.address!;
      gst = value.gst.toString();
      mobileNumber = value.mobileNo.toString();
    }).then((value) {
      progressBar = false;
    });
  }
}
