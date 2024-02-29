import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genmak_ecom/app/data/models/vendor_model.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';
import 'package:genmak_ecom/app/utils/widgets/vendor_list_item.dart';

import 'package:get/get.dart';

import '../controllers/vendor_list_controller.dart';

class VendorListView extends GetView<VendorListController> {
  const VendorListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.whiteColor,
          size: MediaQuery.of(Get.context!).size.width > 650 ? 40 : 20,
        ),
        title: Text(
          'Vendor List',
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
        height: Get.height,
        width: Get.width,
        child: Obx(() => controller.vendors.isNotEmpty
            ? ListView(
                shrinkWrap: true,
                // scrollDirection: Axis.horizontal,
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
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          // height: 30.h,
                          width: Get.width / 2.4,
                          child: TextFormWidget(
                            suffix: true,
                            textController: controller.textController,
                            label: "Search by vendor name...",
                            onChanged: (v) =>
                                controller.textController!.text = v.toString(),
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.bgColor1),
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
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            padding: const EdgeInsets.all(6),
                            child: ElevatedButton(
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
                                )))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    // color: Colors.blueAccent,
                    // height: Get.height / 1.2,
                    height: Get.height * 0.75,

                    child: ListView.builder(
                        itemCount: controller.searchV
                            ? controller.vendorsSearch.length
                            : controller.vendors.length,
                        itemBuilder: (ctx, i) {
                          VendorModel vendor = controller.searchV
                              ? controller.vendorsSearch[i]
                              : controller.vendors[i];
                          return VendorListItem(vendorModel: vendor);
                        }),
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
