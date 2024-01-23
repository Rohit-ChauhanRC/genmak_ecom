import 'package:flutter/material.dart';
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
        title: const Text('Product List'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        height: Get.height,
        width: Get.width,
        child: Obx(() => controller.homeController.products.isNotEmpty
            ? ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.width / 2,
                          child: TextFormWidget(
                            textController:
                                controller.homeController.textController,
                            label: "Search...",
                            onChanged: (v) => controller.homeController
                                .textController!.text = v.toString(),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (controller.homeController.textController!.text
                                  .toString()
                                  .isNotEmpty) {
                                controller.homeController.searchProduct(
                                    controller
                                        .homeController.textController!.text);
                              }
                            },
                            child: const Text("Search")),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              // controller.textController!.clear();
                              // controller.searchP = false;
                              await controller.homeController.all();
                            },
                            child: const Text("All"))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: Get.height / 1.2,
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
                    color: AppColors.brownColor,
                    fontSize: AppDimens.font30,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              )),
      ),
    );
  }
}
