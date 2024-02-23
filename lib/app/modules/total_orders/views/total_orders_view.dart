import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genmak_ecom/app/data/models/receiving_model.dart';
import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/total_orders_controller.dart';

class TotalOrdersView extends GetView<TotalOrdersController> {
  const TotalOrdersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.whiteColor,
          size: MediaQuery.of(Get.context!).size.width > 650 ? 40 : 20,
        ),
        title: Text(
          'Total Orders',
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(Get.context!).size.width > 650
                ? AppDimens.font30
                : AppDimens.font18,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        // margin: const EdgeInsets.all(20),
        child: Obx(() => controller.receiveList.isNotEmpty
            ? ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    color: AppColors.buttonColor,
                    height: 35.h,
                    margin: const EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(
                      left:
                          MediaQuery.of(Get.context!).size.width > 650 ? 10 : 3,
                      right:
                          MediaQuery.of(Get.context!).size.width > 650 ? 10 : 3,
                    ),
                    // margin: const EdgeInsets.only(left: 10, right: 10),
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          width: Get.width / 2.4,
                          child: TextFormWidget(
                            suffix: true,
                            textController: controller.textController,
                            label: "Search...",
                            onChanged: (v) =>
                                controller.textController!.text = v.toString(),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.bgColor1,
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
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            padding: const EdgeInsets.all(6),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.bgColor1,
                                ),
                                onPressed: () async {
                                  // controller.textController!.clear();
                                  // controller.searchP = false;
                                  await controller.all();
                                },
                                child: Text(
                                  "All",
                                  style: TextStyle(color: AppColors.blackColor),
                                )))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: Get.height / 1.2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.receiveList.length,
                      itemBuilder: (context, index) {
                        ReceivingModel data = controller.receiveList[index];

                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.ORDER_DETAILS, arguments: data);
                          },
                          child: Container(
                            height: MediaQuery.of(Get.context!).size.width > 650
                                ? 250
                                : 150,
                            width: MediaQuery.of(Get.context!).size.width > 650
                                ? 200
                                : 150,
                            // margin: const EdgeInsets.all(10),

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
                                        fontSize: MediaQuery.of(Get.context!)
                                                    .size
                                                    .width >
                                                650
                                            ? AppDimens.font22
                                            : AppDimens.font16,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      data.invoiceId ?? "",
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(Get.context!)
                                                    .size
                                                    .width >
                                                650
                                            ? AppDimens.font22
                                            : AppDimens.font16,
                                        color: AppColors.blackColor,
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
                                        fontSize: MediaQuery.of(Get.context!)
                                                    .size
                                                    .width >
                                                650
                                            ? AppDimens.font22
                                            : AppDimens.font16,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      DateFormat("dd/MM/yyyy").format(
                                              DateTime.parse(
                                                  data.receivingDate!)) ??
                                          "",
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(Get.context!)
                                                    .size
                                                    .width >
                                                650
                                            ? AppDimens.font22
                                            : AppDimens.font16,
                                        color: AppColors.blackColor,
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
                                        fontSize: MediaQuery.of(Get.context!)
                                                    .size
                                                    .width >
                                                650
                                            ? AppDimens.font22
                                            : AppDimens.font16,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      data.vendorName ?? "",
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(Get.context!)
                                                    .size
                                                    .width >
                                                650
                                            ? AppDimens.font22
                                            : AppDimens.font16,
                                        color: AppColors.blackColor,
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
                    fontSize: MediaQuery.of(Get.context!).size.width > 650
                        ? AppDimens.font30
                        : AppDimens.font18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              )),
      ),
    );
  }
}
