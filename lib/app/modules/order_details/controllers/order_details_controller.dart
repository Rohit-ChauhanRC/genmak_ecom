import 'package:genmak_ecom/app/data/database/receiving_db.dart';
import 'package:genmak_ecom/app/data/models/receiving_model.dart';
import 'package:genmak_ecom/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class OrderDetailsController extends GetxController {
  //
  // final ReceivingDB receivingDB = ReceivingDB();
  final HomeController homeController = Get.find();

  final Rx<ReceivingModel> _receive = Rx(ReceivingModel());
  ReceivingModel get receive => _receive.value;
  set receive(ReceivingModel model) => _receive.value = model;

  final RxList<ReceivingModel> _receiveProduct = RxList([ReceivingModel()]);
  List<ReceivingModel> get receiveProduct => _receiveProduct;
  set receiveProduct(List<ReceivingModel> model) =>
      _receiveProduct.assignAll(model);

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    receive = Get.arguments!;
    await fetchDataByInvoiceId();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchDataByInvoiceId() async {
    receiveProduct.assignAll(await homeController.receivingDB
        .fetchByInvoiceId(Get.arguments!.invoiceId));

    final ids = receiveProduct.map((e) => e.productName).toSet();

    // print(totalAmounnt);
    receiveProduct.retainWhere((x) => ids.remove(x.productName));
  }
}
