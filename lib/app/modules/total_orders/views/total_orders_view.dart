import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/data/models/receiving_model.dart';
import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';

import 'package:get/get.dart';

import '../controllers/total_orders_controller.dart';

class TotalOrdersView extends GetView<TotalOrdersController> {
  const TotalOrdersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Total Orders'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Obx(() => controller.receiveList.isNotEmpty
            ? ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.width / 2,
                          child: TextFormWidget(
                            textController: controller.textController,
                            label: "Search...",
                            onChanged: (v) =>
                                controller.textController!.text = v.toString(),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blackColor,
                          ),
                          onPressed: () async {
                            if (controller.textController!.text
                                .toString()
                                .isNotEmpty) {
                              controller.searchProduct(
                                  controller.textController!.text);
                            }
                          },
                          child: Text(
                            "Search",
                            style: TextStyle(color: AppColors.blackColor),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blackColor,
                            ),
                            onPressed: () async {
                              // controller.textController!.clear();
                              // controller.searchP = false;
                              await controller.all();
                            },
                            child: Text(
                              "All",
                              style: TextStyle(color: AppColors.blackColor),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: Get.height / 1.2,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 150,
                      ),
                      itemCount: controller.receiveList.length,
                      itemBuilder: (context, index) {
                        ReceivingModel data = controller.receiveList[index];

                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.ORDER_DETAILS, arguments: data);
                          },
                          child: Container(
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
                                      "Invoice No.:",
                                      style: TextStyle(
                                        fontSize: AppDimens.font18,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    Text(
                                      data.invoiceId ?? "",
                                      style: TextStyle(
                                        fontSize: AppDimens.font18,
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
                                      "Date:",
                                      style: TextStyle(
                                        fontSize: AppDimens.font18,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    Text(
                                      data.receivingDate ?? "",
                                      style: TextStyle(
                                        fontSize: AppDimens.font18,
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
                                      "Vendor",
                                      style: TextStyle(
                                        fontSize: AppDimens.font18,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    Text(
                                      data.vendorName ?? "",
                                      style: TextStyle(
                                        fontSize: AppDimens.font18,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
    );
  }
}
