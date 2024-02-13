import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';
import 'package:genmak_ecom/app/utils/widgets/upload_image_widget.dart';

import 'package:get/get.dart';

import '../controllers/edit_product_item_controller.dart';

class EditProductItemView extends GetView<EditProductItemController> {
  const EditProductItemView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        centerTitle: true,
      ),
      body: Obx(() => !controller.progressBar
          ? Container(
              margin: const EdgeInsets.all(20),
              child: Form(
                key: controller.productsFormKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() => UploadImageWidget(
                          imageFile: controller.personPic,
                          onTap: controller.getImage1,
                          bytes: controller.imageLocal,
                          imageDb: controller.imgeDb,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
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
                    Obx(() => TextFormWidget(
                          label: "Please enter name...",
                          onChanged: (val) => controller.name = val,
                          initialValue: controller.name,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Product weight :",
                        style: TextStyle(
                          fontSize: AppDimens.font22,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    Obx(() => TextFormWidget(
                          label: "Please enter product weight...",
                          onChanged: (val) => controller.weight = val,
                          initialValue: controller.weight,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Price :",
                        style: TextStyle(
                          fontSize: AppDimens.font22,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    Obx(() => TextFormWidget(
                          label: "Please enter price...",
                          onChanged: (val) => controller.price = val!,
                          initialValue: controller.price.toString(),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Quantity :",
                        style: TextStyle(
                          fontSize: AppDimens.font22,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    Obx(() => TextFormWidget(
                          label: "Please enter quantity...",
                          onChanged: (val) => controller.quantity = val!,
                          initialValue: controller.quantity.toString(),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    // Obx(() => TextFormWidget(
                    //       label: "Please enter description...",
                    //       onChanged: (val) => controller.description = val,
                    //       initialValue: controller.description,
                    //     )),
                    // const SizedBox(
                    //   height: 20,
                    // ),
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
                                      AppColors.whiteColor)),
                          child: Text(
                            "Update",
                            style: TextStyle(color: AppColors.blackColor),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.deleteProductTable();
                          },
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                  backgroundColor: MaterialStatePropertyAll(
                                      AppColors.whiteColor)),
                          child: const Text("Delete",
                              style: TextStyle(color: Colors.red)),
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
