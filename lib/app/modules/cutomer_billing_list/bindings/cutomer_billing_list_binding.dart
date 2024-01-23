import 'package:get/get.dart';

import '../controllers/cutomer_billing_list_controller.dart';

class CutomerBillingListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CutomerBillingListController>(
      () => CutomerBillingListController(),
    );
  }
}
