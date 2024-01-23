import 'package:get/get.dart';

import '../controllers/cutomer_billing_detils_controller.dart';

class CutomerBillingDetilsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CutomerBillingDetilsController>(
      () => CutomerBillingDetilsController(),
    );
  }
}
