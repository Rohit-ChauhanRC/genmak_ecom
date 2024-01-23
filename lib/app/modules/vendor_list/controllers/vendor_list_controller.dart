import 'package:genmak_ecom/app/data/models/vendor_model.dart';
import 'package:genmak_ecom/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class VendorListController extends GetxController {
  //
  // final VendorDB vendorDB = VendorDB();
  final HomeController homeController = Get.find();

  final RxList<VendorModel> _vendors = RxList<VendorModel>();
  List<VendorModel> get vendors => _vendors;
  set vendors(List<VendorModel> lt) => _vendors.assignAll(lt);

  final RxList<VendorModel> _vendorsSearch = RxList<VendorModel>();
  List<VendorModel> get vendorsSearch => _vendorsSearch;
  set vendorsSearch(List<VendorModel> lt) => _vendorsSearch.assignAll(lt);

  final RxBool _searchV = RxBool(false);
  bool get searchV => _searchV.value;
  set searchV(bool b) => _searchV.value = b;

  final TextEditingController? textController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    await fetchAll();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    vendorsSearch.clear();
    searchV = false;
    textController!.clear();
  }

  Future<void> searchProduct(String name) async {
    vendorsSearch.assignAll([]);

    for (var i = 0; i < vendors.length; i++) {
      searchV = true;

      if (vendors[i].name.toString().toLowerCase().contains(name)) {
        vendorsSearch.add(vendors[i]);

        update();
        print(vendors[i].name);
      }
    }
    FocusScope.of(Get.context!).unfocus();
  }

  Future<void> all() async {
    textController!.clear();
    searchV = false;
    update();
  }

  Future<void> fetchAll() async {
    vendors.assignAll(await homeController.vendorDB.fetchAll());
  }
}
