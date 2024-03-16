import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genmak_ecom/app/data/models/receiving_model.dart';
import 'package:genmak_ecom/app/data/models/vendor_model.dart';
import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/date_time_picker_widget.dart';

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
          'Received products history',
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
            // height: 35.h,
            height: Get.height * 0.30,

            margin: const EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(
              left: MediaQuery.of(Get.context!).size.width > 650 ? 10 : 3,
              right: MediaQuery.of(Get.context!).size.width > 650 ? 10 : 3,
            ),
            // margin: const EdgeInsets.only(left: 10, right: 10),
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
                Obx(() => controller.vendors.isNotEmpty
                    ? InputDecorator(
                        decoration: const InputDecoration(
                          hintText: "Select Vendor",
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<VendorModel>(
                            items: controller.vendors
                                .map((VendorModel dropDownStringItem) {
                              return DropdownMenuItem<VendorModel>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem.name!),
                              );
                            }).toList(),
                            onChanged: (VendorModel? val) {
                              print(val!.id);
                              controller.setSelected(val.name!.toString());
                              controller.vendorModel = val;
                              // controller.vendorId = val.id.toString();
                            },
                            value: controller.vendorModel,
                            isDense: true,
                          ),
                        ),
                      )
                    : const SizedBox()),
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
                      //   controller.searchProduct(
                      //       controller.textController!.text);
                      // }
                      controller.filterDaateWise();
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
          Obx(
            () => controller.receiveList.isNotEmpty ||
                    controller.receiveListSearch.isNotEmpty
                ? Container(
                    margin: const EdgeInsets.only(top: 20),
                    // height: Get.height / 1.2,
                    height: Get.height * 0.45,
                    // color: Colors.blue,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.searchV
                          ? controller.receiveListSearch.length
                          : controller.receiveList.length,
                      itemBuilder: (context, index) {
                        ReceivingModel data = controller.searchV
                            ? controller.receiveListSearch[index]
                            : controller.receiveList[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.ORDER_DETAILS, arguments: data);
                          },
                          child: Container(
                            height: MediaQuery.of(Get.context!).size.width > 650
                                ? 250.h
                                : 150.h,
                            width: MediaQuery.of(Get.context!).size.width > 650
                                ? 200.w
                                : 150.w,
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
                                      data.receivingDate!.isNotEmpty
                                          ? DateFormat("dd/MM/yyyy").format(
                                              DateTime.parse(data.receivingDate!
                                                  .toString()))
                                          : "",
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
                    ),
                  )),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20.h, top: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(
                  color: AppColors.blackColor,
                  thickness: 2,
                ),
                const Text("Total Amount: "),
                SizedBox(
                  width: 20.w,
                ),
                Obx(() => Text(
                    "₹${controller.searchV ? controller.totalAmounntS : controller.totalAmounnt}/-")),
                Divider(
                  color: AppColors.blackColor,
                  thickness: 2,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
