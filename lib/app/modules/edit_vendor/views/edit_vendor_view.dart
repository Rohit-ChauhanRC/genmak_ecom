import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';

import 'package:get/get.dart';

import '../controllers/edit_vendor_controller.dart';

class EditVendorView extends GetView<EditVendorController> {
  const EditVendorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.whiteColor,
          size: MediaQuery.of(Get.context!).size.width > 650 ? 40 : 20,
        ),
        title: Text(
          'Edit Vendor Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(Get.context!).size.width > 650
                ? AppDimens.font30
                : AppDimens.font18,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() => !controller.progressBar
          ? Container(
              margin: const EdgeInsets.all(20),
              child: Form(
                key: controller.vendorFormKey,
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Vendor Name :",
                        style: TextStyle(
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
                              ? AppDimens.font22
                              : AppDimens.font16,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Obx(() => TextFormWidget(
                          label: "Please enter Vendor Name...",
                          onChanged: (val) => controller.name = val,
                          initialValue: controller.name,
                        )),
                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 650
                          ? 20
                          : 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Mobile No :",
                        style: TextStyle(
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
                              ? AppDimens.font22
                              : AppDimens.font16,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Obx(() => TextFormWidget(
                          label: "Please enter Vendor Mobile No...",
                          onChanged: (val) => controller.mobileNumber = val,
                          initialValue: controller.mobileNumber,
                        )),
                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 650
                          ? 20
                          : 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "GSTIN No :",
                        style: TextStyle(
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
                              ? AppDimens.font22
                              : AppDimens.font16,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Obx(() => TextFormWidget(
                          label: "Please enter Vendor GSTIN No...",
                          onChanged: (val) => controller.gst = val,
                          initialValue: controller.gst,
                        )),
                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 650
                          ? 20
                          : 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Address :",
                        style: TextStyle(
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
                              ? AppDimens.font22
                              : AppDimens.font16,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Obx(() => TextFormWidget(
                          label: "Please enter Vendor Address...",
                          onChanged: (val) => controller.address = val,
                          initialValue: controller.address,
                        )),
                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 650
                          ? 20
                          : 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            controller.checkValidate();
                          },
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                  backgroundColor: MaterialStatePropertyAll(
                                      AppColors.buttonColor)),
                          child: Text(
                            "Update",
                            style: TextStyle(color: AppColors.whiteColor),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.deleteProductTable();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.whiteColor),
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          : const CircularProgressIndicator()),
    );
  }
}
