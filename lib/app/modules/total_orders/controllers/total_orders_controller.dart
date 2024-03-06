import 'package:genmak_ecom/app/data/database/receiving_db.dart';
import 'package:genmak_ecom/app/data/database/vendor_db.dart';
import 'package:genmak_ecom/app/data/models/receiving_model.dart';
import 'package:genmak_ecom/app/data/models/vendor_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TotalOrdersController extends GetxController {
  //
  final ReceivingDB receivingDB = ReceivingDB();
  final VendorDB vendorDB = VendorDB();

  final RxList<ReceivingModel> _receiveList = RxList();
  List<ReceivingModel> get receiveList => _receiveList;
  set receiveList(List<ReceivingModel> lt) => _receiveList.assignAll(lt);

  final RxList<ReceivingModel> _receiveListSearch = RxList();
  List<ReceivingModel> get receiveListSearch => _receiveListSearch;
  set receiveListSearch(List<ReceivingModel> lt) =>
      _receiveListSearch.assignAll(lt);

  final RxBool _searchV = RxBool(false);
  bool get searchV => _searchV.value;
  set searchV(bool b) => _searchV.value = b;

  final TextEditingController? textController = TextEditingController();

  final RxString _fromDate = "".obs;
  String get fromDate => _fromDate.value;
  set fromDate(String str) => _fromDate.value = str;

  final RxString _toDate = "".obs;
  String get toDate => _toDate.value;
  set toDate(String str) => _toDate.value = str;

  final RxString _inputVendor = "Select Vendor".obs;
  String get inputVendor => _inputVendor.value;
  set inputVendor(String str) => _inputVendor.value = str;

  final RxList<VendorModel> _vendors = RxList<VendorModel>();
  List<VendorModel> get vendors => _vendors;
  set vendors(List<VendorModel> lt) => _vendors.assignAll(lt);

  final Rx<VendorModel> _vendorModel = Rx(VendorModel());
  VendorModel get vendorModel => _vendorModel.value;
  set vendorModel(VendorModel v) => _vendorModel.value = v;

  @override
  void onInit() async {
    super.onInit();
    await fetchAll();
    await fetchVendor();
    // await receivingDB.fetchByDate("01/01/2024", "05/03/2024");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    receiveList.clear();
    receiveListSearch.clear();
    searchV = false;
    textController!.clear();
  }

  Future<void> fetchVendor() async {
    vendors.assignAll(await vendorDB.fetchAll());
    if (vendors.isNotEmpty) {
      vendorModel = vendors[0];
      inputVendor = vendors[0].name.toString();
    }
  }

  void setSelected(String value) {
    _inputVendor.value = value;
  }

  filterDaateWise() async {
    // if (fromDate.isNotEmpty && toDate.isNotEmpty) {
    searchV = true;

    receiveListSearch.assignAll(
        await receivingDB.fetchByDate(fromDate, toDate, inputVendor));
    print(receiveList.first.productName);
    update();

    // } else {
    //   Utils.showDialog("Please select date!");
    // }
  }

  Future<void> searchProduct(String name) async {
    receiveListSearch.assignAll([]);

    for (var i = 0; i < receiveList.length; i++) {
      searchV = true;

      if (receiveList[i].invoiceId.toString().toLowerCase().contains(name)) {
        receiveListSearch.add(receiveList[i]);

        update();
        print(name);
      }
    }
    FocusScope.of(Get.context!).unfocus();
  }

  Future<void> all() async {
    textController!.clear();
    searchV = false;
    update();
  }

  fetchAll() async {
    searchV = false;
    receiveListSearch.assignAll([]);
    receiveList.assignAll(await receivingDB.fetchAll());
    final ids = receiveList.map((e) => e.invoiceId).toSet();
    receiveList.retainWhere((x) => ids.remove(x.invoiceId));
  }
}
