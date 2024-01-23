import 'package:get/get.dart';

import '../controllers/edit_product_item_controller.dart';

class EditProductItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProductItemController>(
      () => EditProductItemController(),
    );
  }
}
