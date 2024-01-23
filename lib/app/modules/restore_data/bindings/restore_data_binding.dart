import 'package:get/get.dart';

import '../controllers/restore_data_controller.dart';

class RestoreDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestoreDataController>(
      () => RestoreDataController(),
    );
  }
}
