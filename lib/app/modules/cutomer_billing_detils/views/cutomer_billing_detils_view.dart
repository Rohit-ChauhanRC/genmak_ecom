import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';

import 'package:get/get.dart';

import '../controllers/cutomer_billing_detils_controller.dart';

class CutomerBillingDetilsView extends GetView<CutomerBillingDetilsController> {
  const CutomerBillingDetilsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cutomer Billing Detials'),
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
                    "Invoice Id:",
                    style: TextStyle(
                      fontSize: AppDimens.font22,
                      color: AppColors.reddishColor,
                    ),
                  ),
                  Text(
                    controller.receive.invoiceId ?? "",
                    style: TextStyle(
                      fontSize: AppDimens.font22,
                      color: AppColors.brownColor,
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
                      fontSize: AppDimens.font22,
                      color: AppColors.reddishColor,
                    ),
                  ),
                  Text(
                    controller.receive.receivingDate ?? "",
                    style: TextStyle(
                      fontSize: AppDimens.font22,
                      color: AppColors.brownColor,
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
                    "Product:",
                    style: TextStyle(
                      fontSize: AppDimens.font22,
                      color: AppColors.reddishColor,
                    ),
                  ),
                  Text(
                    controller.receive.productName ?? "",
                    style: TextStyle(
                      fontSize: AppDimens.font22,
                      color: AppColors.brownColor,
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
                      fontSize: AppDimens.font22,
                      color: AppColors.reddishColor,
                    ),
                  ),
                  Obx(() => Text(
                        "₹${controller.totalAmounnt}/-" ?? "0.0",
                        style: TextStyle(
                          fontSize: AppDimens.font22,
                          color: AppColors.brownColor,
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
                  fontSize: AppDimens.font22,
                  color: AppColors.reddishColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.reddishColor,
                  decorationStyle: TextDecorationStyle.solid,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: Get.height / 2,
                // color: AppColors.brownColor,
                child: Obx(() => controller.receiveProduct.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
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
                              color: AppColors.bgColor,
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
                                        fontSize: AppDimens.font18,
                                        color: AppColors.reddishColor,
                                      ),
                                    ),
                                    Text(
                                      data.productName ?? "",
                                      style: TextStyle(
                                        fontSize: AppDimens.font18,
                                        color: AppColors.brownColor,
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
                                        fontSize: AppDimens.font18,
                                        color: AppColors.reddishColor,
                                      ),
                                    ),
                                    Text(
                                      data.productQuantity ?? "0",
                                      style: TextStyle(
                                        fontSize: AppDimens.font18,
                                        color: AppColors.brownColor,
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
                                      "Price:",
                                      style: TextStyle(
                                        fontSize: AppDimens.font18,
                                        color: AppColors.reddishColor,
                                      ),
                                    ),
                                    Text(
                                      "₹${data.price}/-" ?? "0",
                                      style: TextStyle(
                                        fontSize: AppDimens.font18,
                                        color: AppColors.brownColor,
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
                            color: AppColors.brownColor,
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
