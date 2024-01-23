import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';

import 'package:get/get.dart';

import '../controllers/edit_vendor_controller.dart';

class EditVendorView extends GetView<EditVendorController> {
  const EditVendorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditVendorView'),
        centerTitle: true,
      ),
      body: Obx(() => !controller.progressBar
          ? Container(
              margin: const EdgeInsets.all(20),
              child: Form(
                key: controller.vendorFormKey,
                child: ListView(
                  children: [
                    TextFormWidget(
                      label: "Please enter Vendor Name...",
                      onChanged: (val) => controller.name = val,
                      initialValue: controller.name,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormWidget(
                      label: "Please enter Vendor Mobile No...",
                      onChanged: (val) => controller.mobileNumber = val,
                      initialValue: controller.mobileNumber,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormWidget(
                      label: "Please enter Vendor GSTIN No...",
                      onChanged: (val) => controller.gst = val,
                      initialValue: controller.gst,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormWidget(
                      label: "Please enter Vendor Address...",
                      onChanged: (val) => controller.address = val,
                      initialValue: controller.address,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            controller.checkValidate();
                          },
                          child: Text("Update"),
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                  backgroundColor: MaterialStatePropertyAll(
                                      AppColors.brownColor)),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.deleteProductTable();
                          },
                          child: Text("Delete"),
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                  backgroundColor: MaterialStatePropertyAll(
                                      AppColors.reddishColor)),
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
