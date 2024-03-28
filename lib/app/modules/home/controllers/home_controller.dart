import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:genmak_ecom/app/data/database/product_db.dart';
import 'package:genmak_ecom/app/data/database/profile_db.dart';
import 'package:genmak_ecom/app/data/database/receiving_db.dart';
import 'package:genmak_ecom/app/data/database/sell_db.dart';
import 'package:genmak_ecom/app/data/database/vendor_db.dart';
import 'package:genmak_ecom/app/data/models/product_model.dart';
import 'package:genmak_ecom/app/data/models/profile_model.dart';
import 'package:genmak_ecom/app/data/models/vendor_model.dart';
import 'package:genmak_ecom/app/utils/extensions/app_extensions.dart';
import 'package:genmak_ecom/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
//
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  //
  final box = GetStorage();

  final ProductDB productDB = ProductDB();
  final SellDB sellDB = SellDB();
  final VendorDB vendorDB = VendorDB();
  final ProfileDB profileDB = ProfileDB();
  final ReceivingDB receivingDB = ReceivingDB();

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

// final wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66

  String localIp = '';
  List<String> devices = [];
  bool isDiscovering = false;
  int found = -1;
  TextEditingController portController = TextEditingController(text: '8883');

  // final PaperSize paper = PaperSize.mm80;
// final profile = await CapabilityProfile.load();
// final printer = NetworkPrinter(paper, profile);

  final RxList<VendorModel> _vendors = RxList<VendorModel>();
  List<VendorModel> get vendors => _vendors;
  set vendors(List<VendorModel> lt) => _vendors.assignAll(lt);

  final RxList<ProductModel> _products = RxList<ProductModel>();
  List<ProductModel> get products => _products;
  set products(List<ProductModel> lt) => _products.assignAll(lt);

  final RxList<ProductModel> _productSearch = RxList<ProductModel>();
  List<ProductModel> get productSearch => _productSearch;
  set productSearch(List<ProductModel> lt) => _productSearch.assignAll(lt);

  final RxBool _searchP = RxBool(false);
  bool get searchP => _searchP.value;
  set searchP(bool b) => _searchP.value = b;

  final RxList<ProductModel> _orders = RxList<ProductModel>();
  List<ProductModel> get orders => _orders;
  set orders(List<ProductModel> lt) => _orders.assignAll(lt);

  final Rx<XFile> _personPic = Rx<XFile>(XFile(''));
  XFile get personPic => _personPic.value;
  set personPic(XFile v) => _personPic.value = v;

  final Rx<Uint8List> _personPicM = Rx<Uint8List>(Uint8List(0));
  Uint8List get personPicM => _personPicM.value;
  set personPicM(Uint8List pic) => _personPicM.value = pic;

  final RxBool _memoryImg = RxBool(true);
  bool get memoryImg => _memoryImg.value;
  set memoryImg(bool b) => _memoryImg.value = b;

  final RxDouble _totalAmount = 0.0.obs;
  double get totalAmount => _totalAmount.value;
  set totalAmount(double str) => _totalAmount.value = str;

  final RxInt _invoiceNo = RxInt(0);
  int get invoiceNo => _invoiceNo.value;
  set invoiceNo(int i) => _invoiceNo.value = i;

  final Rx<ProfileModel> _profile = Rx(ProfileModel());
  ProfileModel get profile => _profile.value;
  set profile(ProfileModel v) => _profile.value = v;

  // final Rx<ClientModel> _clientModel = Rx(ProfileModel());
  // ProfileModel get profile => _profile.value;
  // set profile(ProfileModel v) => _profile.value = v;

  final RxString _search = "".obs;
  String get search => _search.value;
  set search(String str) => _search.value = str;
  final TextEditingController? textController = TextEditingController();

  final RxString _ssid = "".obs;
  String get ssid => _ssid.value;
  set ssid(String str) => _ssid.value = str;

  final RxString _bssid = "".obs;
  String get bssid => _bssid.value;
  set bssid(String str) => _bssid.value = str;

  final RxString _ip = "".obs;
  String get ip => _ip.value;
  set ip(String str) => _ip.value = str;

  // late final Socket sock;

  final RxString _appTitle = "".obs;
  String get appTitle => _appTitle.value;
  set appTitle(String str) => _appTitle.value = str;

  final RxString _customerId = ''.obs;
  String get customerId => _customerId.value;
  set customerId(String str) => _customerId.value = str;

  final RxString _profileId = ''.obs;
  String get profileId => _profileId.value;
  set profileId(String str) => _profileId.value = str;

  @override
  void onInit() async {
    super.onInit();
    getDatabasesPath().then((value) => print("db pthj : $value"));
    await fetchProduct();
    await sellDB.fetchAll();
    fetchInvoiceNo();
    await fetchProfile();
    await permissionCheck();

    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      // Got a new connectivity status!
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.vpn) {
        // await apiCallOnceInADay();
      }
    });
  }

  @override
  void onReady() async {
    super.onReady();
    await fetchProduct();
    // final ByteData bytes = await rootBundle.load('assets/images/store.png');
    // print(
    //     "bytes.buffer.asUint8List(): ${bytes.buffer.asUint8List().toString()}");
  }

  @override
  void onClose() {
    super.onClose();
    _orders.close();
    _invoiceNo.close();
    _personPic.close();
    _totalAmount.close();
    _products.close();
    textController!.clear();
    productSearch.clear();
    searchP = false;
    _connectivitySubscription.cancel();
  }

  Future<void> permissionCheck() async {
    await Permission.camera.request();
    await Permission.mediaLibrary.request();
    await Permission.storage.request();
  }

  Future<void> checkUserStatus() async {
    try {
      var res = await http.get(
        Uri.parse(
            "http://182.78.13.18:8090/api/ClientFlag?clientId=${box.read("login")}"),
      );
      if (res.statusCode == 200) {
        print(res.statusCode);
        print(res.body);
        if (jsonDecode(res.body) == "A" || jsonDecode(res.body) == "Z") {
          box.write("status", jsonDecode(res.body));
        }
      }
    } catch (e) {
      // apiLopp(i);
    }
  }

  Future<void> createProfile() async {
    // final ByteData bytes = await rootBundle.load('assets/images/store.png');

    // box.write("login", res[0]["ClientId"]);
    await profileDB.update(
      id: int.parse(profileId),
      name: profile.name,
      address: profile.address,
      contact: profile.contact,
      customerId: profile.customerId,
      gst: profile.gst,
      city: profile.city,
      email: profile.email,
      panNo: profile.panNo,
      state: profile.state,
      pin: profile.pin,
    );
  }

  Future<void> apiCallOnceInADay() async {
    String lastVisitDate = box.read('day');
    String toDayDate = DateTime.now().day.toString();

    if (toDayDate == lastVisitDate) {
      print("hello will display once");
    } else {
      await createProfile();
      await checkUserStatus();
      box.write('day', toDayDate);
    }
  }

  fetchInvoiceNo() {
    if (box.read("invoiceNo") != null && box.read("invoiceNo") != "") {
      invoiceNo = box.read("invoiceNo");
    } else {
      box.write("invoiceNo", 1000001);
    }
  }

  Future<void> fetchProduct() async {
    products.assignAll(await productDB.fetchAll());
  }

  Future<void> searchProduct(String name) async {
    productSearch.assignAll([]);

    for (var i = 0; i < products.length; i++) {
      searchP = true;

      if (products[i].name.toString().toLowerCase().contains(name)) {
        productSearch.add(products[i]);

        update();
        print(products[i].name);
      }
    }
    FocusScope.of(Get.context!).unfocus();
  }

  Future<void> all() async {
    textController!.clear();
    searchP = false;
    // productSearch = products;
    update();
  }

  double totalAmountCal() {
    totalAmount = 0.0;
    if (orders.toSet().toList().isNotEmpty) {
      for (var i = 0; i < orders.toSet().toList().length; i++) {
        totalAmount +=
            (double.tryParse(orders.toSet().toList()[i].price.toString())! *
                    orders.toSet().toList()[i].count!)
                .toDouble();
        print(totalAmount);
      }
    }
    return totalAmount;
  }

  Future<void> onSave() async {
    // if (box.read("status") == "A") {
    for (var i = 0; i < orders.toSet().toList().length; i++) {
      final index = products
          .indexWhere((element) => element.id == orders.toSet().toList()[i].id);
      if (orders.toSet().toList()[i].count! >= 1) {
        await productDB.update(
            id: products[index].id!,
            quantity: "${int.tryParse(products[index].quantity!)!}");
        await sellDB.create(
          invoiceId: "${box.read("invoiceNo") ?? invoiceNo}",
          productName: orders.toSet().toList()[i].name!,
          productWeight: orders.toSet().toList()[i].weight!,
          price:
              (double.tryParse(orders.toSet().toList()[i].price!)!).toString(),
          productId: orders.toSet().toList()[i].id.toString(),
          productQuantity: orders.toSet().toList()[i].count.toString(),
          receivingDate: DateTime.now()
              .copyWith(
                  hour: 0, microsecond: 0, minute: 0, second: 0, millisecond: 0)
              .toIso8601String(),
          count: orders.toSet().toList()[i].count!,
          gst: orders.toSet().toList()[i].gst,
          unit: orders.toSet().toList()[i].unit,
        );
      }
    }

    await fetchProduct();

    if (orders.isNotEmpty) {
      await checkIp(
        "${box.read("invoiceNo")}",
      );
    }
    Future.delayed(const Duration(seconds: 3), () {
      for (var i = 0; i < products.length; i++) {
        products[i].count = 0;
      }
      box.write("invoiceNo", box.read("invoiceNo") + 1);

      orders.assignAll([]);
      totalAmount = 0.0;
    });
    // }
    // else if (box.read("status") == "Z") {
    //   Utils.showDialog("Your subscription is expired!");
    // }
  }

  Future<void> printBtn() async {
    await checkIp(
      "${box.read("invoiceNo")}",
    );
  }

  handleProductQuantity(int i) {
    if (int.tryParse(products[i].quantity!)! >= 1) {
      products[i].count = products[i].count! + 1;
      products[i].quantity =
          (int.tryParse(products[i].quantity.toString())! - 1).toString();
      orders.add(products[i]);

      totalAmountCal();
      update();
    }
  }

  itemAdd(int i) {
    if (orders.toSet().toList()[i].count! >= 1 &&
        orders.toSet().toList()[i].count! <=
            int.tryParse(orders.toSet().toList()[i].quantity.toString())!) {
      orders.toSet().toList()[i].count = orders.toSet().toList()[i].count! + 1;
      orders.add(orders.toSet().toList()[i]);
      final index = products
          .indexWhere((element) => element.id == orders.toSet().toList()[i].id);
      if (int.tryParse(products[index].quantity!)! >= 1) {
        products[index].quantity =
            (int.tryParse(products[index].quantity.toString())! - 1).toString();

        totalAmountCal();
        update();
      }
    }
  }

  itemSub(int i) {
    if (orders.toSet().toList()[i].count! >= 1) {
      orders.toSet().toList()[i].count = orders.toSet().toList()[i].count! - 1;
      // orders.add(orders.toSet().toList()[i]);
      orders.toSet().toList().addIf(
          !orders.contains(orders.toSet().toList()[i]),
          orders.toSet().toList()[i]);
      final index = products
          .indexWhere((element) => element.id == orders.toSet().toList()[i].id);

      if (int.tryParse(products[index].quantity!)! >= 1) {
        products[index].quantity =
            (int.tryParse(products[index].quantity.toString())! + 1).toString();

        totalAmountCal();
        if (orders.toSet().toList()[i].count! == 0) {
          orders.removeWhere(
              (element) => element.id == orders.toSet().toList()[i].id);
        }
      }
      update();

      print(orders.length);
    } else {
      orders.remove(orders.toSet().toList()[i]);
    }
  }

  void getImage1() {
    Utils.showImagePicker(onGetImage: (image) {
      if (image != null) {
        personPic = image;
        memoryImg = false;
      }
    });
  }

  Future<void> fetchProfile() async {
    await profileDB.fetchAll().then((v) {
      if (v.isNotEmpty) {
        profile = v[0];
        personPicM = v[0].picture!;
        memoryImg = true;
        appTitle = v[0].name!;
        customerId = v[0].customerId!;
        print("v: ${v[0].name}");
        profileId = v[0].id.toString();
      }
    });
  }

  Future<void> checkIp(String invoice) async {
    // if (box.read("status") == "A") {
    // if(orders.)
    for (var interface in await NetworkInterface.list()) {
      // print(interface);
      for (var addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4 &&
            addr.address.startsWith('192') &&
            Platform.isAndroid &&
            (interface.name.startsWith("swlan") ||
                interface.name.startsWith("ap"))) {
          ip = addr.address.split(".").getRange(0, 3).join(".");
          for (var i = 0; i < 255; i++) {
            apiLopp(i, invoice);
          }
        } else if (addr.type == InternetAddressType.IPv4 &&
            addr.address.startsWith('172') &&
            Platform.isIOS) {
          ip = addr.address.split(".").getRange(0, 3).join(".");
          for (var i = 0; i < 255; i++) {
            apiLopp(i, invoice);
          }
        }
        // else {
        //   Utils.showDialog("Printer not connected!");
        // orders.assignAll([]);
        // totalAmount = 0.0;
        // }
        // }
      }
    }
    // else if (box.read("status") == "Z") {
    //   Utils.showDialog("Your Subscription is expired!");
    // }
  }

  apiLopp(int i, String invoice) async {
    try {
      await http.post(Uri.parse("http://$ip.$i/status"), body: {
        "print": """
  $appTitle
  ${profile.address}
  GSTIN:${profile.gst}
  PH:${profile.contact}
  DATE: ${DateFormat("dd/MM/yyyy").add_Hms().format(DateTime.now())}
  BILL NO.: $invoice""",
      }).then((res) {
        print(res);
        if (res.statusCode == 200) {
          setStatus("http://$ip.$i/status");
        } else {
          print(res.body);
        }
      });
    } catch (e) {
      // apiLopp(i);
      print("e: ${e.toString()}");
    }
  }

  List<Map<double, double>> calulateGST() {
    // final v = 0.0;
    final gst = orders.map((e) => (
          double.parse(e.gst!),
          double.parse(e.price!) -
              (double.parse(e.price!) * 100 / (100 + double.parse(e.gst!)))
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

    return c1;
  }

  void setStatus(String apiUrl) async {
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
    final count = orders
        .toSet()
        .toList()
        .map((e) => e.count)
        .fold(0, (previousValue, element) => previousValue + element!);
    List<Map<double, double>> gstList = calulateGST();
    late int count1 = 0;

    late String strp = "";
    for (var e in orders.toSet().toList()) {
      if (e.count! >= 1) {
        strp =
            """$strp${count1 = count1 + 1}.  ${"${e.name!}-${(e.weight.toString() + e.unit.toString()).toString().padRight(6, " ")}"} \n      ${(double.parse(e.price!) * 100 / (100 + double.parse(e.gst!))).toPrecision(2).toString().padRight(11, " ")}${e.count.toString().padRight(4, " ")}${((double.parse(e.price!) * 100 / (100 + double.parse(e.gst!))) * e.count!).toPrecision(2)}\n  """;
      }
    }
    late String strpgst = "";
    late double az = 0.0;

    for (var e in gstList) {
      az = (az + e.values.first / 2).toPrecision(2);
      strpgst =
          """$strpgst${e.keys.first.toString().padRight(9, " ")}${((e.values.first) / 2).toPrecision(2).toString().padRight(10, " ")}${((e.values.first) / 2).toPrecision(2)}\n  """;
    }

    try {
      var res = await http.post(Uri.parse(apiUrl), body: {
        "print": """
  - - - - - - - - - - - - - - -
  SR. ${"RATE(Rs.)".toString().padRight(10, " ")}${"QTY".toString().padRight(4, " ")}${"AMOUNT(Rs.)".toString().padRight(8, " ")}
  $strp
  - - - - - - - - - - - - - - -
  Subtotal:  | $count | ${subtotalPrice.toStringAsFixed(2)} |
  - - - - - - - - - - - - - - -
  %        CGST      SGST
  $strpgst
  - - - - - - - - - - - - - - -
      | ${az.toStringAsFixed(2)} | ${az.toStringAsFixed(2)} |
  - - - - - - - - - - - - - - -
  Total   Rs.${(double.parse(subtotalPrice.toStringAsFixed(2)) + 2 * double.parse(az.toStringAsFixed(2))).toPrecision(2)}/-
  - - - - - - - - - - - - - - -
      Thank You

 """,
      });

      if (res.statusCode == 200) {
        for (var i = 0; i < products.length; i++) {
          products[i].count = 0;
        }

        orders = [];
        orders.assignAll([]);
        orders.clear();
        totalAmount = 0.0;
        update();
        print("send");
      }
    } catch (e) {
      //
    }
  }
}
