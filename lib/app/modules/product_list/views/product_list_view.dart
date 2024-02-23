import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genmak_ecom/app/data/models/product_model.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/product_list_item.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';

import 'package:get/get.dart';

import '../controllers/product_list_controller.dart';

class ProductListView extends GetView<ProductListController> {
  const ProductListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.whiteColor,
          size: MediaQuery.of(Get.context!).size.width > 650 ? 40 : 20,
        ),
        title: Text('Product List',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(Get.context!).size.width > 650
                  ? AppDimens.font30
                  : AppDimens.font18,
            )),
        centerTitle: true,
      ),
      body: Container(
        // margin: const EdgeInsets.all(20),
        height: Get.height,
        width: Get.width,
        child: Obx(() => controller.homeController.products.isNotEmpty
            ? ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    color: AppColors.buttonColor,
                    height: 35.h,
                    margin: const EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(
                      left:
                          MediaQuery.of(Get.context!).size.width > 650 ? 10 : 5,
                      right:
                          MediaQuery.of(Get.context!).size.width > 650 ? 10 : 5,
                    ),
                    // color: AppColors.buttonColor,
                    // height: MediaQuery.of(context).size.width > 650 ? 70 : 50,
                    // margin: const EdgeInsets.only(top: 20),
                    // padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: Get.width / 2.3,
                          child: TextFormWidget(
                            textController:
                                controller.homeController.textController,
                            label: "Search...",
                            onChanged: (v) => controller.homeController
                                .textController!.text = v.toString(),
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.bgColor1,
                              ),
                              onPressed: () async {
                                if (controller
                                    .homeController.textController!.text
                                    .toString()
                                    .isNotEmpty) {
                                  controller.homeController.searchProduct(
                                      controller
                                          .homeController.textController!.text);
                                }
                              },
                              child: Text(
                                "Search",
                                style: TextStyle(color: AppColors.blackColor),
                              )),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.bgColor1,
                              ),
                              onPressed: () async {
                                // controller.textController!.clear();
                                // controller.searchP = false;
                                await controller.homeController.all();
                              },
                              child: Text(
                                "All",
                                style: TextStyle(color: AppColors.blackColor),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: Get.height / 1.3,
                    // color: Colors.green,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.homeController.searchP
                            ? controller.homeController.productSearch.length
                            : controller.homeController.products.length,
                        itemBuilder: (ctx, i) {
                          ProductModel product =
                              controller.homeController.searchP
                                  ? controller.homeController.productSearch[i]
                                  : controller.homeController.products[i];
                          return ProductListItem(product: product);
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
