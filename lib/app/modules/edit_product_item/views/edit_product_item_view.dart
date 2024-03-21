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
        iconTheme: IconThemeData(
          color: AppColors.whiteColor,
          size: MediaQuery.of(Get.context!).size.width > 720 ? 40 : 20,
        ),
        title: Text(
          'Edit Product',
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(Get.context!).size.width > 720
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
                key: controller.productsFormKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      //
                      maxRadius: MediaQuery.of(Get.context!).size.width > 720
                          ? 102
                          : 52,
                      minRadius: MediaQuery.of(Get.context!).size.width > 720
                          ? 100
                          : 50,
                      backgroundColor: AppColors.buttonColor,
                      child: Obx(() => UploadImageWidget(
                            imageFile: controller.personPic,
                            onTap: controller.getImage1,
                            bytes: controller.imageLocal,
                            imageDb: controller.imgeDb,
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Name :",
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
                          label: "Please enter name...",
                          onChanged: (val) => controller.name = val,
                          initialValue: controller.name,
                        )),
                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 720
                          ? 20
                          : 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Product weight :",
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
                          label: "Please enter product weight...",
                          onChanged: (val) => controller.weight = val,
                          initialValue: controller.weight,
                          // keyboardType: TextInputType.number,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        )),
                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 720
                          ? 20
                          : 10,
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
                      height: MediaQuery.of(Get.context!).size.width > 720
                          ? 20
                          : 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Price :",
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
                          label: "Please enter price...",
                          onChanged: (val) => controller.price = val,
                          initialValue: controller.price.toString(),
                          // keyboardType: TextInputType.number,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        )),
                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 720
                          ? 20
                          : 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Quantity :",
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
                          label: "Please enter quantity...",
                          onChanged: (val) => controller.quantity = val,
                          initialValue: controller.quantity.toString(),
                          // keyboardType: TextInputType.number,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        )),
                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 720
                          ? 20
                          : 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "GST :",
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
                          label: "Please enter GST...",
                          initialValue: controller.gst,
                          onChanged: (val) => controller.gst = val,
                          // keyboardType: TextInputType.number,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),

                          // validator: (v) =>
                          //     v!.isEmpty ? "Field is required!" : null,
                        )),
                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 720
                          ? 20
                          : 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Discount :",
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
                          label: "Please enter Discount...",
                          initialValue: controller.discount,
                          onChanged: (val) => controller.discount = val,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),

                          // validator: (v) => v!.isEmpty ? "Field is required!" : null,
                        )),
                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 720
                          ? 20
                          : 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "HSNCode :",
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
                          // validator: (v) => v!.isEmpty ? "Field is required!" : null,
                        )),
                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 720
                          ? 20
                          : 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Description :",
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
                          initialValue: controller.description,
                          label: "Please enter description...",
                          onChanged: (val) {
                            controller.description = val;
                            print(controller.description);
                          },
                        )),
                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 720
                          ? 20
                          : 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          child: Text(
                            "\tActive: ",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(Get.context!).size.width > 720
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
                                // width: 130,
                                width: Get.width * 0.45,

                                child: ListTile(
                                  title: Text(
                                    'Yes',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: MediaQuery.of(Get.context!)
                                                    .size
                                                    .width >
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
                                          fontSize: MediaQuery.of(Get.context!)
                                                      .size
                                                      .width >
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
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                  backgroundColor: MaterialStatePropertyAll(
                                      AppColors.whiteColor)),
                          child: const Text("Delete",
                              style: TextStyle(color: Colors.black)),
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
