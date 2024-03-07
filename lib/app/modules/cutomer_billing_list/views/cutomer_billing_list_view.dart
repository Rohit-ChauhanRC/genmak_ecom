import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genmak_ecom/app/data/models/sell_model.dart';
import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/widgets/date_time_picker_widget.dart';
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
          color: AppColors.whiteColor,
          size: MediaQuery.of(Get.context!).size.width > 650 ? 40 : 20,
        ),
        title: Text(
          'Customer Billing List',
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
          child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            color: AppColors.buttonColor,
            height: Get.height * 0.25,
            margin: const EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(
              left: MediaQuery.of(Get.context!).size.width > 650 ? 10 : 3,
              right: MediaQuery.of(Get.context!).size.width > 650 ? 10 : 3,
            ),
            child: ListView(
              shrinkWrap: true,
              // scrollDirection: Axis.horizontal,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      height: 50.h,
                      width: Get.width / 2.2,
                      child: DateTimePickerWidget(
                        initialDate: DateTime.tryParse(controller.fromDate),
                        hintText: "From Date",
                        onChanged: (val) {
                          controller.fromDate = val!
                              .copyWith(
                                  hour: 0,
                                  microsecond: 0,
                                  minute: 0,
                                  second: 0,
                                  millisecond: 0)
                              .toIso8601String();
                          print(val);
                        },
                      ),
                      // TextFormWidget(
                      //   textController: controller.textController,
                      //   label: "Search...",
                      //   onChanged: (v) =>
                      //       controller.textController!.text = v.toString(),
                      // ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      height: 50.h,
                      width: Get.width / 2.2,
                      child: DateTimePickerWidget(
                        initialDate: DateTime.tryParse(controller.toDate),
                        hintText: "To Date",
                        onChanged: (val) {
                          controller.toDate = val!
                              .copyWith(
                                  hour: 0,
                                  microsecond: 0,
                                  minute: 0,
                                  second: 0,
                                  millisecond: 0)
                              .toIso8601String();
                          print(val);
                        },
                      ),
                      // TextFormWidget(
                      //   textController: controller.textController,
                      //   label: "Search...",
                      //   onChanged: (v) =>
                      //       controller.textController!.text = v.toString(),
                      // ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 3,
                ),
                Container(
                    padding: const EdgeInsets.all(6),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.bgColor1,
                        ),
                        onPressed: () async {
                          // if (controller.textController!.text
                          //     .toString()
                          //     .isNotEmpty) {
                          controller.filterDaateWise();
                          // }
                        },
                        child: Text(
                          "Search",
                          style: TextStyle(color: AppColors.blackColor),
                        ))),
                const SizedBox(
                  width: 3,
                ),
                // const Spacer(),
                // Container(
                //   alignment: Alignment.centerRight,
                //   padding: const EdgeInsets.all(6),
                //   child: PopupMenuButton(
                //     child: Icon(
                //       Icons.more_vert,
                //       color: AppColors.bgColor1,
                //     ),
                //     itemBuilder: (_) => <PopupMenuItem<String>>[
                //       const PopupMenuItem(
                //         value: 'All',
                //         child: Text('All'),
                //       ),
                //       const PopupMenuItem(
                //         value: 'Date Wise',
                //         child: Text('Date Wise'),
                //       ),
                //     ],
                //     onSelected: (String value) async {
                //       if (value == "All") {
                //         await controller.all();
                //       } else if (value == "Date Wise") {
                //         print("date");
                //       }
                //     },
                //   ),
                // ),

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
          Obx(
            () => controller.receiveList.isNotEmpty ||
                    controller.receiveListSearch.isNotEmpty
                ? Container(
                    margin: const EdgeInsets.only(top: 20),
                    // height: Get.height / 1.2,
                    height: Get.height * 0.55,
                    // color: Colors.blue,
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
                                ? 180.h
                                : 130.h,
                      ),
                      itemCount: controller.searchV
                          ? controller.receiveListSearch.length
                          : controller.receiveList.length,
                      itemBuilder: (context, index) {
                        SellModel data = controller.searchV
                            ? controller.receiveListSearch[index]
                            : controller.receiveList[index];

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
                                      data.invoiceId.toString(),
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
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      data.receivingDate != null &&
                                              data.receivingDate != ""
                                          ? DateFormat("dd/MM/yyyy").format(
                                              DateTime.parse(data.receivingDate!
                                                  .toString()))
                                          : "",
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
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.printBtn(data);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.buttonColor,
                                      ),
                                      child: Text(
                                        "print",
                                        style: TextStyle(
                                          fontSize: AppDimens.font18,
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox(
                    height: 20.h,
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
                  ),
          )
        ],
      )),
    );
  }
}
