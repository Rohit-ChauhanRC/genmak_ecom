import 'package:genmak_ecom/app/data/models/sell_model.dart';
import 'package:genmak_ecom/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CutomerBillingListController extends GetxController {
  //SellModel
  final HomeController homeController = Get.find();

  final RxList<SellModel> _receiveList = RxList();
  List<SellModel> get receiveList => _receiveList;
  set receiveList(List<SellModel> lt) => _receiveList.assignAll(lt);

  final RxList<SellModel> _receiveListSearch = RxList();
  List<SellModel> get receiveListSearch => _receiveListSearch;
  set receiveListSearch(List<SellModel> lt) => _receiveListSearch.assignAll(lt);

  final RxBool _searchV = RxBool(false);
  bool get searchV => _searchV.value;
  set searchV(bool b) => _searchV.value = b;

  final TextEditingController? textController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    await fetchAll();
    await filterDaateWise();
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

  filterDaateWise() async {
    final aw = await homeController.sellDB
        .fetchByDate(DateTime(2024, 3, 5).toString());
    print(aw);
  }

  fetchAll() async {
    receiveList.assignAll(await homeController.sellDB.fetchAll());
    // final amounts = receiveList.map((e) => (int.tryParse(e.price!)! * int.tryParse(e.productQuantity!)!));
    final ids = receiveList.map((e) => e.invoiceId).toSet();
    receiveList.retainWhere((x) => ids.remove(x.invoiceId));
  }

  Future<void> searchProduct(String name) async {
    receiveListSearch.assignAll([]);

    for (var i = 0; i < receiveList.length; i++) {
      searchV = true;

      if (receiveList[i].invoiceId.toString().toLowerCase().contains(name)) {
        receiveListSearch.add(receiveList[i]);

        update();
        print(receiveList[i].invoiceId);
      }
    }
    FocusScope.of(Get.context!).unfocus();
  }

  Future<void> all() async {
    textController!.clear();
    searchV = false;
    update();
  }
}
