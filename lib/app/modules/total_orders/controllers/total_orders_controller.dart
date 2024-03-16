import 'package:genmak_ecom/app/data/database/receiving_db.dart';
import 'package:genmak_ecom/app/data/database/vendor_db.dart';
import 'package:genmak_ecom/app/data/models/receiving_model.dart';
import 'package:genmak_ecom/app/data/models/vendor_model.dart';
import 'package:genmak_ecom/app/utils/utils.dart';
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

  final RxDouble _totalAmounnt = 0.0.obs;
  double get totalAmounnt => _totalAmounnt.value;
  set totalAmounnt(double str) => _totalAmounnt.value = str;

  final RxDouble _totalAmounntS = 0.0.obs;
  double get totalAmounntS => _totalAmounntS.value;
  set totalAmounntS(double str) => _totalAmounntS.value = str;

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

  int compareOnlyByDate(DateTime other) {
    return DateTime(DateTime.parse(fromDate).year,
            DateTime.parse(fromDate).month, DateTime.parse(fromDate).day)
        .compareTo(
      DateTime(other.year, other.month, other.day),
    );
  }

  filterDaateWise() async {
//
    searchV = true;

    final result = DateTime.parse(toDate).compareTo(DateTime.parse(fromDate));
    // print(result);
    if (result == 1) {
      receiveListSearch.assignAll(
          await receivingDB.fetchByDate(fromDate, toDate, inputVendor));
    } else if (result == 0) {
      receiveListSearch
          .assignAll(await receivingDB.fetchByDateEqual(fromDate, inputVendor));
    } else {
      Utils.showDialog("To date should not be greater than from date!");
    }

    final ids = receiveListSearch.map((e) => e.invoiceId).toSet();
    receiveListSearch.retainWhere((x) => ids.remove(x.invoiceId));
    totalAmounntS = 0.0;
    for (var i = 0; i < receiveListSearch.length; i++) {
      totalAmounntS =
          totalAmounntS + double.tryParse(receiveListSearch[i].totalAmount!)!;
    }
    update();
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
    totalAmounnt = 0.0;
    for (var i = 0; i < receiveList.length; i++) {
      totalAmounnt =
          totalAmounnt + double.tryParse(receiveList[i].totalAmount!)!;
    }
  }
}
