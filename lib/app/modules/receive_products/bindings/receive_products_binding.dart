import 'package:get/get.dart';

import '../controllers/receive_products_controller.dart';

class ReceiveProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiveProductsController>(
      () => ReceiveProductsController(),
    );
  }
}
