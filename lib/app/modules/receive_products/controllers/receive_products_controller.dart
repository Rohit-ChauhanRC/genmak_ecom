import 'package:genmak_ecom/app/data/database/receiving_db.dart';
import 'package:genmak_ecom/app/data/database/vendor_db.dart';
import 'package:genmak_ecom/app/data/models/product_model.dart';
import 'package:genmak_ecom/app/data/models/receiving_model.dart';
import 'package:genmak_ecom/app/data/models/vendor_model.dart';
import 'package:genmak_ecom/app/modules/home/controllers/home_controller.dart';
import 'package:genmak_ecom/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ReceiveProductsController extends GetxController {
  //

  // final ProductDB productDB = ProductDB();
  final VendorDB vendorDB = VendorDB();
  final ReceivingDB receivingDB = ReceivingDB();

  final HomeController homeController = Get.find();

  GlobalKey<FormState>? receiveFormKey = GlobalKey<FormState>();

  final RxList<ProductModel> _products = RxList<ProductModel>();
  List<ProductModel> get products => _products;
  set products(List<ProductModel> lt) => _products.assignAll(lt);

  final Rx<ProductModel> _pmodel =
      Rx(ProductModel(name: "", weight: "", price: ""));
  ProductModel get pmodel => _pmodel.value;
  set pmodel(ProductModel m) => _pmodel.value = m;

  final RxList<VendorModel> _vendors = RxList<VendorModel>();
  List<VendorModel> get vendors => _vendors;
  set vendors(List<VendorModel> lt) => _vendors.assignAll(lt);

  final Rx<VendorModel> _vendorModel = Rx(VendorModel());
  VendorModel get vendorModel => _vendorModel.value;
  set vendorModel(VendorModel v) => _vendorModel.value = v;

  final RxInt _id = RxInt(0);
  int get id => _id.value;
  set id(int i) => _id.value = i;

  final RxString _inputProduct = "Select Product".obs;
  String get inputProduct => _inputProduct.value;
  set inputProduct(String str) => _inputProduct.value = str;

  final RxString _inputVendor = "Select Vendor".obs;
  String get inputVendor => _inputVendor.value;
  set inputVendor(String str) => _inputVendor.value = str;

  final RxString _vendorId = "".obs;
  String get vendorId => _vendorId.value;
  set vendorId(String str) => _vendorId.value = str;

  final RxString _quantity = ''.obs;
  String get quantity => _quantity.value;
  set quantity(String str) => _quantity.value = str;

  final RxString _invoiceId = ''.obs;
  String get invoiceId => _invoiceId.value;
  set invoiceId(String str) => _invoiceId.value = str;

  final RxDouble _totalAmount = 0.0.obs;
  double get totalAmount => _totalAmount.value;
  set totalAmount(double str) => _totalAmount.value = str;

  final RxDouble _totalAmountP = 0.0.obs;
  double get totalAmountP => _totalAmountP.value;
  set totalAmountP(double str) => _totalAmountP.value = str;

  final RxList<ReceivingModel> _productListModel = RxList([ReceivingModel()]);
  List<ReceivingModel> get productListModel => _productListModel;
  set productListModel(List<ReceivingModel> pr) => _productListModel.addAll(pr);

  final Rx<String> _receivingDate = Rx<String>("");
  String get receivingDate => _receivingDate.value;
  set receivingDate(String ti) => _receivingDate.value = ti;

  @override
  void onInit() async {
    super.onInit();
    await fetchProduct();
    await fetchVendor();
    // await fetchAll();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    _id.close();
    _inputProduct.close();
    _inputVendor.close();
    _invoiceId.close();
    _pmodel.close();
    _productListModel.close();
    _products.close();
    _quantity.close();
    _receivingDate.close();
    _totalAmount.close();
    _vendorId.close();
    _vendorModel.close();
    _vendors.close();
  }

  void setSelected(String value) {
    _inputVendor.value = value;
  }

  void setSelectedProduct(String value) {
    _inputProduct.value = value;
  }

  Future<void> fetchProduct() async {
    products.assignAll(await homeController.productDB.fetchAll());
    if (products.isNotEmpty) pmodel = products[0];
  }

  Future<void> fetchVendor() async {
    vendors.assignAll(await vendorDB.fetchAll());
    if (vendors.isNotEmpty) {
      vendorModel = vendors[0];
      vendorId = vendors[0].id.toString();
      inputVendor = vendors[0].name.toString();
    }
  }

  void addProductList(index) {
    // print(receivingDate);
    productListModel.insert(
        index + 1,
        ReceivingModel(
          vendorId: vendorId,
          invoiceId: invoiceId,
          receivingDate: receivingDate,
          totalAmount: totalAmount.toString(),
          vendorName: inputVendor,
          productId: "",
          productName: "",
          productQuantity: "",
        ));
  }

  void removeProductList(int index, ReceivingModel product) {
    if (productListModel.length > 1) {
      productListModel.removeAt(index);
    }
  }

  calGrandTotal() {
    final amt = productListModel.first.productQuantity!.isNotEmpty
        ? productListModel
            .map((e) {
              totalAmountP = totalAmountP +
                  double.tryParse(e.productModel!.price!)!.toDouble() *
                      double.tryParse(e.productQuantity!)!;

              return totalAmountP;
            })
            .toString()
            .replaceAll("(", "")
            .replaceAll(")", "")
        : "0.0";
    return amt;
  }

  Future onSumit() async {
    // totalAmountP = 0.0;
    // final amt = productListModel
    //     .map((e) {
    //       totalAmountP = totalAmountP +
    //           double.tryParse(e.productModel!.price!)!.toDouble() *
    //               double.tryParse(e.productQuantity!)!;

    //       return totalAmountP;
    //     })
    //     .toString()
    //     .replaceAll("(", "")
    //     .replaceAll(")", "");
    // print("totalAmountP: $totalAmountP");
    // print("amt: ${double.tryParse(amt)}");
    print("totalAmount: $totalAmount");
    if (totalAmountP != totalAmount) {
      Utils.showDialog("Total amount is not same to total product amount!");

      // return null;
    } else if (invoiceId.isEmpty) {
      Utils.showDialog("Invoice number is empty!");
    } else if (totalAmount < 1.0) {
      Utils.showDialog("Total amount cannot be zero!");
    } else {
      for (var i = 0; i < productListModel.length; i++) {
        await homeController.productDB
            .update(
                id: productListModel[i].productModel!.id!,
                quantity:
                    (int.tryParse(productListModel[i].productModel!.quantity!)!
                                .toInt() +
                            int.tryParse(
                                    productListModel[i].productQuantity ?? "0")!
                                .toInt())
                        .toString())
            .then((value) async {
          await receivingDB.create(
              vendorName: productListModel[i].vendorName.toString(),
              totalAmount: totalAmountP.toString(),
              productName: productListModel[i].productName.toString(),
              invoiceId: productListModel[i].invoiceId,
              productId: productListModel[i].productId,
              productQuantity: productListModel[i].productQuantity.toString(),
              receivingDate: productListModel[i].receivingDate,
              vendorId: productListModel[i].vendorId);
        }).then((value) async {
          //  homeController. products.assignAll(await homeController.productDB.fetchAll());
          await homeController.productDB.fetchAll().then((value) {
            homeController.products.assignAll(value);
            Get.back();
          });
        });
      }
    }
    // print(receivingDate);
  }

  fetchAll() async {
    await receivingDB.fetchAll();
  }
}
