import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/data/models/product_model.dart';
import 'package:genmak_ecom/app/data/models/receiving_model.dart';
import 'package:genmak_ecom/app/data/models/vendor_model.dart';
import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/date_time_picker_widget.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';

import 'package:get/get.dart';
import '../../../utils/extensions/app_extensions.dart';
import '../controllers/receive_products_controller.dart';

class ReceiveProductsView extends GetView<ReceiveProductsController> {
  const ReceiveProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.whiteColor,
          size: MediaQuery.of(Get.context!).size.width > 650 ? 40 : 20,
        ),
        title: Text(
          'Receive Products',
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
        height: Get.height,
        margin: const EdgeInsets.all(20),
        child: Form(
          key: controller.receiveFormKey,
          child: ListView(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Invoice No. :",
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
                label: "Please enter invoice no...",
                onChanged: (val) => controller.invoiceId = val,
                validator: (v) => v!.isEmpty ? "Field is required!" : null,
              ),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 650 ? 20 : 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Total amount :",
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
                label: "Please enter total amount...",
                onChanged: (val) => controller.totalAmount = val,
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "Field is required!" : null,
              ),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 650 ? 20 : 10,
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              controller.vendors.isNotEmpty
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select Vendor :",
                        style: TextStyle(
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
                              ? AppDimens.font22
                              : AppDimens.font16,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : const SizedBox(),
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
                            controller.vendorId = val.id.toString();
                          },
                          value: controller.vendorModel,
                          isDense: true,
                        ),
                      ),
                    )
                  : const SizedBox()),
              controller.vendors.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Text(
                            "if vendor not available in the above list please,",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(Get.context!).size.width > 650
                                      ? AppDimens.font18
                                      : AppDimens.font10,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.ADD_VENDOR);
                            },
                            child: Text(
                              "\tclick here",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(Get.context!).size.width > 650
                                        ? AppDimens.font18
                                        : AppDimens.font10,
                                color: AppColors.reddishColor,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.reddishColor,
                                decorationStyle: TextDecorationStyle.solid,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 650 ? 20 : 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Receiving Date :",
                  style: TextStyle(
                    fontSize: MediaQuery.of(Get.context!).size.width > 650
                        ? AppDimens.font22
                        : AppDimens.font16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DateTimePickerWidget(
                hintText: "Receiving Date",
                onChanged: (val) => controller.receivingDate = val.toString(),
              ),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 650 ? 20 : 10,
              ),
              Container(
                height: Get.height / 2.3,
                // color: Colors.black,
                child: Obx(() => ListView.builder(
                    itemCount: controller.productListModel.length,
                    itemBuilder: (ctx, index) {
                      ReceivingModel _product =
                          controller.productListModel[index];

                      return Container(
                        // key: GlobalObjectKey(index),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.blackColor,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.whiteColor,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Select Product :",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(Get.context!).size.width >
                                              650
                                          ? AppDimens.font22
                                          : AppDimens.font16,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Obx(() => controller.products.isNotEmpty
                                ? InputDecorator(
                                    decoration: const InputDecoration(
                                      hintText: "Select Product",
                                    ),
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButton<ProductModel>(
                                      items: controller.products.map(
                                          (ProductModel dropDownStringItem) {
                                        return DropdownMenuItem<ProductModel>(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem.name
                                              .toString()),
                                        );
                                      }).toList(),
                                      onChanged: (ProductModel? val) {
                                        controller.productListModel[index]
                                            .productName = val!.name;
                                        controller.productListModel[index]
                                            .productModel = val;
                                        controller.productListModel[index]
                                            .productId = val.id.toString();
                                        // controller.pmodel = val;
                                        // _product.productModel = val;
                                        controller.productListModel.update(
                                            index,
                                            ReceivingModel(
                                              invoiceId: controller.invoiceId,
                                              productId: val.id.toString(),
                                              productName: val.name,
                                              productModel: val,
                                              totalAmount:
                                                  controller.totalAmount,
                                              vendorId: controller.vendorId,
                                              receivingDate:
                                                  controller.receivingDate,
                                              vendorName:
                                                  controller.vendorModel.name,
                                            ));

                                        controller.setSelectedProduct(
                                            val.name.toString());
                                      },
                                      value: controller
                                          .productListModel[index].productModel,
                                      isDense: true,
                                    )),
                                  )
                                : const SizedBox()),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    // width: Get.width * 0.7,
                                    child: Text(
                                      "if product not available in the above list please,",
                                      // maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(Get.context!)
                                                    .size
                                                    .width >
                                                650
                                            ? AppDimens.font18
                                            : AppDimens.font10,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.ADD_PRODUCT);
                                    },
                                    child: Text(
                                      "\tclick here",
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(Get.context!)
                                                    .size
                                                    .width >
                                                650
                                            ? AppDimens.font18
                                            : AppDimens.font10,
                                        color: AppColors.reddishColor,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.reddishColor,
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(Get.context!).size.width > 650
                                      ? 20
                                      : 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Quantity :",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(Get.context!).size.width >
                                              650
                                          ? AppDimens.font22
                                          : AppDimens.font16,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Obx(() => controller.products.isNotEmpty
                                ? TextFormWidget(
                                    validator: (v) => v!.isEmpty
                                        ? "Field is required!"
                                        : null,
                                    label: "Please enter product quantity...",
                                    onChanged: (val) {
                                      _product.productQuantity = val;
                                      controller.productListModel[index]
                                          .productQuantity = val;
                                    },
                                    keyboardType: TextInputType.number,
                                    initialValue: controller
                                        .productListModel[index]
                                        .productQuantity,
                                  )
                                : const SizedBox()),
                            Obx(() => controller.products.length > 1
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            controller.addProductList(index);
                                          },
                                          child: Text(
                                            "ADD",
                                            style: TextStyle(
                                                color: AppColors.whiteColor),
                                          )),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      if (controller.productListModel.length >
                                              1 ||
                                          index > 1)
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.whiteColor,
                                            ),
                                            onPressed: () {
                                              controller.removeProductList(
                                                  index, _product);
                                            },
                                            child: Text(
                                              "REMOVE",
                                              style: TextStyle(
                                                  color: AppColors.blackColor),
                                            )),
                                    ],
                                  )
                                : const SizedBox()),
                          ],
                        ),
                      );
                    })),
                // ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (controller.products.isNotEmpty &&
                      controller.vendors.isNotEmpty) {
                    await controller.onSumit();
                  }
                },
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    backgroundColor:
                        MaterialStatePropertyAll(AppColors.buttonColor)),
                child: Text(
                  "Submit",
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
