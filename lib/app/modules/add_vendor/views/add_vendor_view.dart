import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';

import 'package:get/get.dart';

import '../controllers/add_vendor_controller.dart';

class AddVendorView extends GetView<AddVendorController> {
  const AddVendorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.whiteColor,
          size: MediaQuery.of(Get.context!).size.width > 650 ? 40 : 20,
        ),
        title: Text('Add Vendor',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(Get.context!).size.width > 650
                  ? AppDimens.font30
                  : AppDimens.font18,
            )),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: controller.vendorFormKey,
          child: ListView(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Name :",
                  style: TextStyle(
                    fontSize: MediaQuery.of(Get.context!).size.width > 650
                        ? AppDimens.font22
                        : AppDimens.font16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextFormWidget(
                label: "Please enter Vendor Name...",
                onChanged: (val) => controller.name = val,
                validator: (val) => val!.isEmpty ? "Field is required!" : null,
              ),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 650 ? 20 : 10,
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
              TextFormWidget(
                keyboardType: TextInputType.phone,
                maxLength: 10,
                label: "Please enter Vendor Mobile No...",
                onChanged: (val) => controller.mobileNumber = val,
                validator: (val) => val!.isEmpty ? "Field is required!" : null,
              ),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 650 ? 20 : 10,
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
              TextFormWidget(
                label: "Please enter Vendor GSTIN No...",
                onChanged: (val) => controller.gst = val,
                validator: (val) => val!.isEmpty ? "Field is required!" : null,
              ),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 650 ? 20 : 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Vendor Address :",
                  style: TextStyle(
                    fontSize: MediaQuery.of(Get.context!).size.width > 650
                        ? AppDimens.font22
                        : AppDimens.font16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextFormWidget(
                label: "Please enter Vendor Address...",
                onChanged: (val) => controller.address = val,
                validator: (val) => val!.isEmpty ? "Field is required!" : null,
              ),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 650 ? 20 : 10,
              ),
              ElevatedButton(
                onPressed: () {
                  controller.checkValidate();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor),
                child: Text(
                  "Add",
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
