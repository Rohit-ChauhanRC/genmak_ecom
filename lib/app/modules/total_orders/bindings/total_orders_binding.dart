import 'package:get/get.dart';

import '../controllers/total_orders_controller.dart';

class TotalOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TotalOrdersController>(
      () => TotalOrdersController(),
    );
  }
}
