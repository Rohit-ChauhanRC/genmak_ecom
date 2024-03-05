import 'package:genmak_ecom/app/data/database/receiving_db.dart';
import 'package:genmak_ecom/app/data/models/receiving_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TotalOrdersController extends GetxController {
  //
  final ReceivingDB receivingDB = ReceivingDB();

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

  @override
  void onInit() async {
    super.onInit();
    await fetchAll();
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
    receiveList.assignAll(await receivingDB.fetchAll());
    final ids = receiveList.map((e) => e.invoiceId).toSet();
    receiveList.retainWhere((x) => ids.remove(x.invoiceId));
  }
}
