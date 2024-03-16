import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/cutomer_billing_detils_controller.dart';

class CutomerBillingDetilsView extends GetView<CutomerBillingDetilsController> {
  const CutomerBillingDetilsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.whiteColor,
          size: MediaQuery.of(Get.context!).size.width > 650 ? 40 : 20,
        ),
        title: Text(
          'Cutomer Billing Details',
          style: TextStyle(
            color: Colors.white,
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
            color: AppColors.whiteColor,
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    controller.receive.invoiceId ?? "",
                    style: TextStyle(
                      fontSize: MediaQuery.of(Get.context!).size.width > 650
                          ? AppDimens.font22
                          : AppDimens.font16,
                      color: AppColors.blackColor,
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat("dd/MM/yyyy").format(DateTime.parse(
                            (controller.receive.receivingDate.toString()))) ??
                        "",
                    style: TextStyle(
                      fontSize: MediaQuery.of(Get.context!).size.width > 650
                          ? AppDimens.font22
                          : AppDimens.font16,
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Product:",
              //       style: TextStyle(
              //         fontSize: MediaQuery.of(Get.context!).size.width > 650
              //             ? AppDimens.font22
              //             : AppDimens.font16,
              //         color: AppColors.blackColor,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     Text(
              //       controller.receive.productName ?? "",
              //       style: TextStyle(
              //         fontSize: MediaQuery.of(Get.context!).size.width > 650
              //             ? AppDimens.font22
              //             : AppDimens.font16,
              //         color: AppColors.blackColor,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(() => Text(
                        "₹${controller.totalAmounnt}/-" ?? "0.0",
                        style: TextStyle(
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
                              ? AppDimens.font22
                              : AppDimens.font16,
                          color: AppColors.blackColor,
                        ),
                      )),
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: Get.height * 0.45,
                // color: AppColors.brownColor,
                child: Obx(() => controller.receiveProduct.isNotEmpty
                    ? GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(Get.context!).size.width > 650
                                  ? 3
                                  : 1,
                          mainAxisExtent:
                              MediaQuery.of(Get.context!).size.width > 650
                                  ? 250
                                  : 200,
                        ),
                        itemCount: controller.receiveProduct.length,
                        itemBuilder: (ctx, index) {
                          final data = controller.receiveProduct[index];

                          return Container(
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.blackColor,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.whiteColor,
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
                                            ? AppDimens.font18
                                            : AppDimens.font16,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.4,
                                      child: Text(
                                        data.productName ?? "",
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
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  color: Colors.black,
                                  thickness: 2,
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
                                            ? AppDimens.font16
                                            : AppDimens.font14,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      data.productQuantity ?? "0",
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
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Price:",
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(Get.context!)
                                                    .size
                                                    .width >
                                                650
                                            ? AppDimens.font16
                                            : AppDimens.font14,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "₹${data.price}/-" ?? "0",
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
