import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/order_details_controller.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.blackColor,
          size: MediaQuery.of(Get.context!).size.width > 650 ? 40 : 20,
        ),
        title: Text(
          'Order Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(Get.context!).size.width > 650
                ? AppDimens.font30
                : AppDimens.font18,
          ),
        ),
        centerTitle: true,
      ),
      body: Align(
        alignment: AlignmentDirectional.center,
        child: Container(
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.blackColor,
            ),
            borderRadius: BorderRadius.circular(20),
            color: AppColors.bgColor,
          ),
          width: Get.width / 1.3,
          height: Get.height / 1.3,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Invoice No.:",
                    style: TextStyle(
                      fontSize: MediaQuery.of(Get.context!).size.width > 650
                          ? AppDimens.font22
                          : AppDimens.font16,
                      color: AppColors.blackColor,
                    ),
                  ),
                  Text(
                    controller.receive.invoiceId ?? "",
                    style: TextStyle(
                      fontSize: MediaQuery.of(Get.context!).size.width > 650
                          ? AppDimens.font22
                          : AppDimens.font16,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date:",
                    style: TextStyle(
                      fontSize: MediaQuery.of(Get.context!).size.width > 650
                          ? AppDimens.font22
                          : AppDimens.font16,
                      color: AppColors.blackColor,
                    ),
                  ),
                  Text(
                    DateFormat("dd/MM/yyyy").format(DateTime.parse(
                            controller.receive.receivingDate!)) ??
                        "",
                    style: TextStyle(
                      fontSize: MediaQuery.of(Get.context!).size.width > 650
                          ? AppDimens.font22
                          : AppDimens.font16,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Vendor:",
                    style: TextStyle(
                      fontSize: MediaQuery.of(Get.context!).size.width > 650
                          ? AppDimens.font22
                          : AppDimens.font16,
                      color: AppColors.blackColor,
                    ),
                  ),
                  Text(
                    controller.receive.vendorName ?? "",
                    style: TextStyle(
                      fontSize: MediaQuery.of(Get.context!).size.width > 650
                          ? AppDimens.font22
                          : AppDimens.font16,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total amount:",
                    style: TextStyle(
                      fontSize: MediaQuery.of(Get.context!).size.width > 650
                          ? AppDimens.font22
                          : AppDimens.font16,
                      color: AppColors.blackColor,
                    ),
                  ),
                  Text(
                    controller.receive.totalAmount ?? "",
                    style: TextStyle(
                      fontSize: MediaQuery.of(Get.context!).size.width > 650
                          ? AppDimens.font22
                          : AppDimens.font16,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Product List: ",
                style: TextStyle(
                  fontSize: MediaQuery.of(Get.context!).size.width > 650
                      ? AppDimens.font22
                      : AppDimens.font18,
                  color: AppColors.blackColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.blackColor,
                  decorationStyle: TextDecorationStyle.solid,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                // color: Colors.white,
                height: MediaQuery.of(Get.context!).size.width > 650
                    ? Get.height * 0.5
                    : Get.height * 0.4,
                // color: AppColors.whiteColor,
                child: Obx(() => controller.receiveProduct.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.receiveProduct.length,
                        itemBuilder: (ctx, index) {
                          final data = controller.receiveProduct[index];

                          return Container(
                            height: MediaQuery.of(Get.context!).size.width > 650
                                ? 200
                                : 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.blackColor,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.bgColor1,
                            ),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Product:",
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(Get.context!)
                                                    .size
                                                    .width >
                                                650
                                            ? AppDimens.font16
                                            : AppDimens.font14,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    Text(
                                      data.productName ?? "",
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(Get.context!)
                                                    .size
                                                    .width >
                                                650
                                            ? AppDimens.font18
                                            : AppDimens.font14,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Quantity:",
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(Get.context!)
                                                    .size
                                                    .width >
                                                650
                                            ? AppDimens.font18
                                            : AppDimens.font14,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    Text(
                                      data.productQuantity ?? "0",
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(Get.context!)
                                                    .size
                                                    .width >
                                                650
                                            ? AppDimens.font18
                                            : AppDimens.font14,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : SizedBox(
                        child: Center(
                            child: Text(
                          "No data found...",
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: AppDimens.font30,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
