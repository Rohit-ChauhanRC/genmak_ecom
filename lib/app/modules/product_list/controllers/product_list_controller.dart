import 'package:flutter/foundation.dart';
import 'package:genmak_ecom/app/data/database/product_db.dart';
import 'package:genmak_ecom/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {
  //
  final ProductDB productDB = ProductDB();

  final HomeController homeController = Get.find();

  // final RxList<ProductModel> _products = RxList<ProductModel>();
  // List<ProductModel> get products => _products;
  // set products(List<ProductModel> lt) => _products.assignAll(lt);

  @override
  void onInit() async {
    super.onInit();
    // if (homeController.textController!.text.isNotEmpty) {
    //   homeController.textController!.clear();
    //   homeController.productSearch.clear();
    //   homeController.searchP = false;
    // }

    if (kDebugMode) {
      print("121212");
    }

    await homeController.fetchProduct();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    homeController.textController!.clear();
    homeController.productSearch.clear();
    homeController.searchP = false;
  }
}
