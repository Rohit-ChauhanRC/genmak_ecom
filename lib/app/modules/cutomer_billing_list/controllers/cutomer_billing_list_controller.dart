import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:genmak_ecom/app/data/models/sell_model.dart';
import 'package:genmak_ecom/app/modules/home/controllers/home_controller.dart';
import 'package:genmak_ecom/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CutomerBillingListController extends GetxController {
  //SellModel
  final HomeController homeController = Get.find();

  final box = GetStorage();

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

  final RxString _fromDate = "".obs;
  String get fromDate => _fromDate.value;
  set fromDate(String str) => _fromDate.value = str;

  final RxString _toDate = "".obs;
  String get toDate => _toDate.value;
  set toDate(String str) => _toDate.value = str;

  final RxString _ip = "".obs;
  String get ip => _ip.value;
  set ip(String str) => _ip.value = str;

  final RxList<SellModel> _receiveProduct = RxList([SellModel()]);
  List<SellModel> get receiveProduct => _receiveProduct;
  set receiveProduct(List<SellModel> model) => _receiveProduct.assignAll(model);

  final RxDouble _totalAmounnt = 0.0.obs;
  double get totalAmounnt => _totalAmounnt.value;
  set totalAmounnt(double str) => _totalAmounnt.value = str;

  @override
  void onInit() async {
    super.onInit();
    await fetchAll();
    // await filterDaateWise();
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
    // if (fromDate.isNotEmpty && toDate.isNotEmpty) {
    searchV = true;
    print(fromDate);
    print(toDate);
    receiveListSearch
        .assignAll(await homeController.sellDB.fetchByDate(fromDate, toDate));
    final ids = receiveListSearch.map((e) => e.invoiceId).toSet();
    for (var i = 0; i < receiveListSearch.length; i++) {
      totalAmounnt =
          totalAmounnt + double.tryParse(receiveListSearch[i].price!)!;
    }
    print(totalAmounnt);
    receiveListSearch.retainWhere((x) => ids.remove(x.invoiceId));

    print(receiveListSearch.first.productName);
    update();

    // } else {
    //   Utils.showDialog("Please select date!");
    // }
  }

  fetchAll() async {
    searchV = false;
    // fromDate = "";
    // toDate = "";
    // if (fromDate.isNotEmpty && toDate.isNotEmpty) {
    receiveList.assignAll(await homeController.sellDB.fetchAll());
    final ids = receiveList.map((e) => e.invoiceId).toSet();
    for (var i = 0; i < receiveList.length; i++) {
      totalAmounnt = totalAmounnt + double.tryParse(receiveList[i].price!)!;
    }
    print(totalAmounnt);
    receiveList.retainWhere((x) => ids.remove(x.invoiceId));

    update();
    FocusScope.of(Get.context!).unfocus();
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
    // textController!.clear();
    fromDate = "";
    toDate = "";
    searchV = false;
    update();
  }

  Future<List<SellModel>> fetchDataByInvoiceId(invoiceId) async {
    receiveProduct
        .assignAll(await homeController.sellDB.fetchByInvoiceId(invoiceId));

    // for (var i = 0; i < receiveProduct.length; i++) {
    //   totalAmounnt = totalAmounnt + double.tryParse(receiveProduct[i].price!)!;
    // }
    return receiveProduct;
  }

  Future<void> printBtn(data) async {
    await fetchDataByInvoiceId(data.invoiceId).then((value) async {
      if (value.isNotEmpty) {
        // print(value[0].);
        await checkIp(data.invoiceId);
      }
    });
  }

  Future<void> checkIp(
    String invoice,
  ) async {
    for (var interface in await NetworkInterface.list()) {
      print(interface);
      for (var addr in interface.addresses) {
        print("addr: $addr");
        if (addr.type == InternetAddressType.IPv4 &&
            addr.address.startsWith('192') &&
            Platform.isAndroid) {
          ip = addr.address.split(".").getRange(0, 3).join(".");
          print(receiveProduct);

          for (var i = 0; i < 255; i++) {
            apiLopp(i, invoice, receiveProduct);
          }
        } else if (addr.type == InternetAddressType.IPv4 &&
            addr.address.startsWith('172') &&
            Platform.isIOS) {
          ip = addr.address.split(".").getRange(0, 3).join(".");
          print("receiveProduct: $receiveProduct");

          for (var i = 0; i < 255; i++) {
            apiLopp(i, invoice, receiveProduct);
          }
        }
        // else if (addr.type == InternetAddressType.IPv4 &&
        //     addr.address.startsWith('10')) {
        //   ip = addr.address.split(".").getRange(0, 3).join(".");
        //   print(receiveProduct);

        //   for (var i = 0; i < 255; i++) {
        //     apiLopp(i, invoice, receiveProduct);
        //   }
        // } else if (addr.type == InternetAddressType.IPv4 &&
        //     addr.address.startsWith('100')) {
        //   ip = addr.address.split(".").getRange(0, 3).join(".");
        //   print(receiveProduct);

        //   for (var i = 0; i < 255; i++) {
        //     apiLopp(i, invoice, receiveProduct);
        //   }
        // }
      }
    }
  }

  apiLopp(int i, String invoice, orders) async {
    try {
      var res = await http.post(Uri.parse("http://$ip.$i/status"), body: {
        "print": """
  ${homeController.appTitle}
  ${homeController.profile.address}
  GSTIN:${homeController.profile.gst}
  PH:${homeController.profile.contact}
  DATE: ${DateFormat("dd/MM/yyyy").add_Hms().format(DateTime.now())}
  BILL NO.: $invoice""",
      });
      if (res.statusCode == 200) {
        // apiUrl = "http://$ip.$i/status";
        print(res.statusCode);
        // print("http://$ip.$i/status");
        setStatus("http://$ip.$i/status", orders);
      }
    } catch (e) {
      // apiLopp(i);
    }
  }

  List<Map<double, double>> calulateGST(orders) {
    final gst = orders.toSet().map((e) => (
          double.parse(e.gst!),
          (double.parse(e.price!) -
              (double.parse(e.price!) * 100 / (100 + double.parse(e.gst!))))
        ));

    final lis1 = [];

    final listOFMAp = gst.toList().map((e) {
      lis1.add(e.$1);
      return {e.$1: e.$2};
    });
    var mergedMap = <double, List<double>>{};

    for (var map in listOFMAp.toList()) {
      for (var e in map.entries) {
        (mergedMap[e.key] ??= []).add(e.value);
      }
    }
    final List<Map<double, double>> c1 = [];
    for (var e in mergedMap.entries) {
      c1.add(e.value.length > 1
          ? {e.key: e.value.reduce((a, b) => a + b).toPrecision(2)}
          : {
              e.key: double.parse(e.value
                      .toString()
                      .replaceAll("[", "")
                      .replaceAll("]", ""))
                  .toPrecision(2)
            });
    }
    if (kDebugMode) {
      print(c1);
    }

    return c1;
  }

  void setStatus(String apiUrl, orders) async {
    // final basemrp =
    final subtotalPrice = orders
        .toSet()
        .map((e) =>
            (double.parse(e.price!) * 100 / (100 + double.parse(e.gst!))) *
            e.count!)
        .fold(
            0.0,
            (previousValue, element) =>
                double.parse(previousValue.toString()) + element);
    final count = orders.toSet().map((e) => e.count).fold(
        0,
        (previousValue, element) =>
            int.parse(previousValue.toString()) + element!);
    List<Map<double, double>> gstList = calulateGST(orders);
    late int count1 = 0;

    // orders.toSet().map((e) => count1 += 1);
    final li = orders
        .toSet()
        .map((e) =>
            """${count1 = count1 + 1}.  ${e.productName!.length > 20 ? e.productName!.substring(0, 20) : e.productName} \n     Rs.${(double.parse(e.price!) * 100 / (100 + double.parse(e.gst!))).toPrecision(2)}   ${e.count}   Rs.${((double.parse(e.price!) * 100 / (100 + double.parse(e.gst!))) * e.count!).toPrecision(2)}\n """)
        .toString()
        .replaceAll("(", "")
        .replaceAll(",", "")
        .replaceAll(")", "");

    late double az = 0.0;
    final gstli = gstList
        .map((e) {
          az = (az + e.values.first / 2).toPrecision(2);
          return """${e.keys.first}   ${((e.values.first) / 2).toPrecision(2)}        ${((e.values.first) / 2).toPrecision(2)}\n """;
        })
        .toString()
        .replaceAll("(", "")
        .replaceAll(",", "")
        .replaceAll(")", "");

    try {
      var res = await http.post(Uri.parse(apiUrl), body: {
        "print": """
  - - - - - - - - - - - - - - -
  SR. RATE       QTY   AMOUNT
  $li
  - - - - - - - - - - - - - - -
  Subtotal   $count   Rs.${subtotalPrice.toStringAsFixed(2)}
  - - - - - - - - - - - - - - -
  %     CGST        SGST
  $gstli
  - - - - - - - - - - - - - - -
  Rs.${az.toStringAsFixed(2)}/-   Rs.${az.toStringAsFixed(2)}
  - - - - - - - - - - - - - - -
  Total   Rs.${(double.parse(subtotalPrice.toStringAsFixed(2)) + 2 * double.parse(az.toStringAsFixed(2))).toPrecision(2)}/-
  - - - - - - - - - - - - - - -
      Thank You
    
 """,
      });
      if (res.statusCode == 200) {
        print("print");
      }
    } catch (e) {
      // apiLopp(i);
    }
  }
}
