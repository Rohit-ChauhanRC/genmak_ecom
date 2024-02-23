import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/data/models/sell_model.dart';
import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_dimens/app_dimens.dart';
import '../controllers/cutomer_billing_list_controller.dart';

class CutomerBillingListView extends GetView<CutomerBillingListController> {
  const CutomerBillingListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.blackColor,
          size: MediaQuery.of(Get.context!).size.width > 650 ? 40 : 20,
        ),
        title: Text(
          'Cutomer Billing List',
          style: TextStyle(
            color: Colors.black,
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
                    height: MediaQuery.of(context).size.width > 650 ? 70 : 50,
                    margin: const EdgeInsets.only(left: 10, right: 10),

                    // margin: const EdgeInsets.only(left: 10, right: 10),
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // mainAxisAlignment: MainAxisAlignment.center,
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
                                backgroundColor: AppColors.whiteColor),
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
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.whiteColor),
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
                      shrinkWrap: true,
                      // reverse: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(Get.context!).size.width > 650
                                ? 4
                                : 1,
                        mainAxisExtent:
                            MediaQuery.of(Get.context!).size.width > 650
                                ? 150
                                : 100,
                      ),
                      itemCount: controller.receiveList.length,
                      itemBuilder: (context, index) {
                        SellModel data = controller.receiveList[index];

                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.CUTOMER_BILLING_DETILS,
                                arguments: data);
                          },
                          child: Container(
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
                                      "Invoice No.:",
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
                                    Text(
                                      data.invoiceId.toString(),
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(Get.context!)
                                                    .size
                                                    .width >
                                                650
                                            ? AppDimens.font22
                                            : AppDimens.font16,
                                        color: AppColors.redColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(Get.context!).size.width >
                                              650
                                          ? 10
                                          : 5,
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
                                            ? AppDimens.font18
                                            : AppDimens.font16,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    Text(
                                      data.receivingDate != null &&
                                              data.receivingDate != ""
                                          ? DateFormat("dd/MM/yyyy").format(
                                              DateTime.parse(
                                                  data.receivingDate!))
                                          : "",
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(Get.context!)
                                                    .size
                                                    .width >
                                                650
                                            ? AppDimens.font18
                                            : AppDimens.font16,
                                        color: AppColors.redColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(
                                //       "Amount",
                                //       style: TextStyle(
                                //         fontSize: AppDimens.font18,
                                //         color: AppColors.blackColor,
                                //       ),
                                //     ),
                                //     Text(
                                //       data.productQuantity ?? "",
                                //       style: TextStyle(
                                //         fontSize: AppDimens.font18,
                                //         color: AppColors.brownColor,
                                //       ),
                                //     ),
                                //   ],
                                // ),
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
