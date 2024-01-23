import 'package:get/get.dart';

import '../controllers/vendor_list_controller.dart';

class VendorListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorListController>(
      () => VendorListController(),
    );
  }
}
