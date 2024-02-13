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
        title: const Text('Add Vendor'),
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
                    fontSize: AppDimens.font22,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              TextFormWidget(
                label: "Please enter Vendor Name...",
                onChanged: (val) => controller.name = val,
                validator: (val) => val!.isEmpty ? "Field is required!" : null,
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Mobile No :",
                  style: TextStyle(
                    fontSize: AppDimens.font22,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              TextFormWidget(
                label: "Please enter Vendor Mobile No...",
                onChanged: (val) => controller.mobileNumber = val,
                validator: (val) => val!.isEmpty ? "Field is required!" : null,
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "GSTIN No :",
                  style: TextStyle(
                    fontSize: AppDimens.font22,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              TextFormWidget(
                label: "Please enter Vendor GSTIN No...",
                onChanged: (val) => controller.gst = val,
                validator: (val) => val!.isEmpty ? "Field is required!" : null,
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Vendor Address :",
                  style: TextStyle(
                    fontSize: AppDimens.font22,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              TextFormWidget(
                label: "Please enter Vendor Address...",
                onChanged: (val) => controller.address = val,
                validator: (val) => val!.isEmpty ? "Field is required!" : null,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  controller.checkValidate();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.whiteColor),
                child: Text(
                  "Add",
                  style: TextStyle(color: AppColors.blackColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
