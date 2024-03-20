import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/data/models/product_model.dart';
import 'package:genmak_ecom/app/data/models/receiving_model.dart';
import 'package:genmak_ecom/app/modules/receive_products/controllers/receive_products_controller.dart';
import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';
import 'package:get/get.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.controller,
  });

  final ReceiveProductsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 2.3,
      // color: Colors.black,
      child: ListView(shrinkWrap: true, children: [
        Container(
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
                    fontSize: MediaQuery.of(Get.context!).size.width > 650
                        ? AppDimens.font22
                        : AppDimens.font16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(() => controller.products.isNotEmpty
                  ? SizedBox(
                      width: Get.width,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          hintText: "Select Product",
                        ),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton<ProductModel>(
                          items: controller.products
                              .map((ProductModel dropDownStringItem) {
                            return DropdownMenuItem<ProductModel>(
                              value: dropDownStringItem,
                              child: SizedBox(
                                width: Get.width * 0.6,
                                child: Text(
                                  "${dropDownStringItem.name}-${dropDownStringItem.weight}${dropDownStringItem.unit}",
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (ProductModel? val) {
                            // controller.setSelectedProduct(
                            //     val!.name.toString());
                          },
                          // value: "nn",
                          isDense: true,
                        )),
                      ),
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
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
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
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
                              ? AppDimens.font18
                              : AppDimens.font10,
                          color: AppColors.reddishColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.reddishColor,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.width > 650 ? 20 : 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Quantity :",
                  style: TextStyle(
                    fontSize: MediaQuery.of(Get.context!).size.width > 650
                        ? AppDimens.font22
                        : AppDimens.font16,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(() => controller.products.isNotEmpty
                  ? TextFormWidget(
                      validator: (v) =>
                          v!.isEmpty ? "Field is required!" : null,
                      label: "Please enter product quantity...",
                      onChanged: (val) {},
                      keyboardType: TextInputType.number,
                      // initialValue: controller
                      //     .productListModel[index]
                      //     .productQuantity,
                    )
                  : const SizedBox()),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Price :",
                      style: TextStyle(
                        fontSize: MediaQuery.of(Get.context!).size.width > 650
                            ? AppDimens.font22
                            : AppDimens.font16,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Obx(() => Text(
                    //       "${double.tryParse(controller.productListModel[index].productModel?.price ?? "0.0")! * int.tryParse(controller.productListModel[index].productQuantity ?? "0")!}",
                    //       style: TextStyle(
                    //         fontSize: MediaQuery.of(Get.context!)
                    //                     .size
                    //                     .width >
                    //                 650
                    //             ? AppDimens.font22
                    //             : AppDimens.font16,
                    //         color: AppColors.blackColor,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
