import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';
import 'package:genmak_ecom/app/utils/widgets/upload_image_widget.dart';

import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.whiteColor,
          size: MediaQuery.of(Get.context!).size.width > 720 ? 40 : 20,
        ),
        title: Text('Add Product',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(Get.context!).size.width > 720
                  ? AppDimens.font30
                  : AppDimens.font18,
            )),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: controller.productsFormKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                //
                maxRadius:
                    MediaQuery.of(Get.context!).size.width > 720 ? 102 : 52,
                minRadius:
                    MediaQuery.of(Get.context!).size.width > 720 ? 100 : 50,
                backgroundColor: AppColors.buttonColor,
                child: Obx(() => UploadImageWidget(
                      imageFile: controller.personPic,
                      onTap: controller.getImage1,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Product Name:",
                  style: TextStyle(
                    fontSize: MediaQuery.of(Get.context!).size.width > 720
                        ? AppDimens.font22
                        : AppDimens.font16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(() => TextFormWidget(
                    initialValue: controller.name,
                    label: "Please enter Name...",
                    onChanged: (val) => controller.name = val,
                    validator: (v) => v!.isEmpty ? "Field is required!" : null,
                  )),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 720 ? 20 : 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Product Weight:",
                  style: TextStyle(
                    fontSize: MediaQuery.of(Get.context!).size.width > 720
                        ? AppDimens.font22
                        : AppDimens.font16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(() => TextFormWidget(
                    initialValue: controller.weight,
                    label: "Please enter Product Weight...",
                    onChanged: (val) => controller.weight = val,
                    validator: (v) => v!.isEmpty ? "Field is required!" : null,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  )),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 720 ? 20 : 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Units of Measurement:",
                  style: TextStyle(
                    fontSize: MediaQuery.of(Get.context!).size.width > 720
                        ? AppDimens.font22
                        : AppDimens.font16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(() => SizedBox(
                    width: Get.width,
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        hintText: "Units of Measurement",
                      ),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                        items: controller.listOfMea
                            .map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: SizedBox(
                              width: Get.width * 0.6,
                              child: Text(
                                dropDownStringItem.toString(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? val) {
                          controller.unit = val!;
                        },
                        value: controller.unit,
                        isDense: true,
                      )),
                    ),
                  )),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 720 ? 20 : 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Price:",
                  style: TextStyle(
                    fontSize: MediaQuery.of(Get.context!).size.width > 720
                        ? AppDimens.font22
                        : AppDimens.font16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(() => TextFormWidget(
                    initialValue: controller.price,
                    label: "Please enter Price...",
                    onChanged: (val) => controller.price = val,
                    validator: (v) => v!.isEmpty ? "Field is required!" : null,
                    // keyboardType: TextInputType.number,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  )),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 720 ? 20 : 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "GST:",
                  style: TextStyle(
                    fontSize: MediaQuery.of(Get.context!).size.width > 720
                        ? AppDimens.font22
                        : AppDimens.font16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(() => TextFormWidget(
                    initialValue: controller.gst,
                    label: "Please enter GST...",
                    onChanged: (val) => controller.gst = val,
                    validator: (v) => v!.isEmpty ? "Field is required!" : null,
                    // keyboardType: TextInputType.number,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  )),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 720 ? 20 : 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Discount:",
                  style: TextStyle(
                    fontSize: MediaQuery.of(Get.context!).size.width > 720
                        ? AppDimens.font22
                        : AppDimens.font16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(() => TextFormWidget(
                    initialValue: controller.discount,
                    label: "Please enter Discount...",
                    onChanged: (val) {
                      controller.discount = val;
                    },
                    // keyboardType: TextInputType.number,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    // validator: (v) => v!.isEmpty ? "Field is required!" : null,
                  )),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 720 ? 20 : 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "HSNCode:",
                  style: TextStyle(
                    fontSize: MediaQuery.of(Get.context!).size.width > 720
                        ? AppDimens.font22
                        : AppDimens.font16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(() => TextFormWidget(
                    initialValue: controller.hsnCode,
                    label: "Please enter HSNCode...",
                    onChanged: (val) => controller.hsnCode = val,
                  )),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 720 ? 20 : 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description:",
                  style: TextStyle(
                    fontSize: MediaQuery.of(Get.context!).size.width > 720
                        ? AppDimens.font22
                        : AppDimens.font16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(() => TextFormWidget(
                    label: "Please enter Name...",
                    onChanged: (val) => controller.decription = val,
                    initialValue: controller.decription,
                    // validator: (v) => v!.isEmpty ? "Field is required!" : null,
                  )),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 720 ? 20 : 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    child: Text(
                      "\tActive: ",
                      style: TextStyle(
                        fontSize: MediaQuery.of(Get.context!).size.width > 720
                            ? AppDimens.font22
                            : AppDimens.font16,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Obx(
                        () => SizedBox(
                          width: Get.width * 0.45,
                          child: ListTile(
                            title: Text(
                              'Yes',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(Get.context!).size.width >
                                              720
                                          ? AppDimens.font18
                                          : AppDimens.font14),
                            ),
                            leading: Radio(
                              activeColor: AppColors.buttonColor,
                              value: 0,
                              groupValue: controller.check,
                              onChanged: (value) {
                                print(value);
                                controller.check = value!;
                                // setState(() {
                                // selectedOption = value!;
                                // });
                              },
                            ),
                          ),
                        ),
                      ),
                      Obx(() => SizedBox(
                            width: Get.width * 0.4,
                            child: ListTile(
                              title: Text(
                                'No',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(Get.context!).size.width >
                                                720
                                            ? AppDimens.font18
                                            : AppDimens.font14),
                              ),
                              leading: Radio(
                                activeColor: AppColors.buttonColor,
                                value: 1,
                                groupValue: controller.check,
                                onChanged: (value) {
                                  print(value);
                                  controller.check = value!;

                                  // setState(() {
                                  // selectedOption = value!;
                                  // });
                                },
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
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
