import 'package:get/get.dart';

import '../controllers/edit_vendor_controller.dart';

class EditVendorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditVendorController>(
      () => EditVendorController(),
    );
  }
}
