import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/data/models/vendor_model.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';
import 'package:genmak_ecom/app/utils/widgets/vendor_list_item.dart';

import 'package:get/get.dart';

import '../controllers/vendor_list_controller.dart';

class VendorListView extends GetView<VendorListController> {
  const VendorListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor List'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        height: Get.height,
        width: Get.width,
        child: Obx(() => controller.vendors.isNotEmpty
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
                            textController: controller.textController,
                            label: "Search...",
                            onChanged: (v) =>
                                controller.textController!.text = v.toString(),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.whiteColor),
                            onPressed: () async {
                              if (controller.textController!.text
                                  .toString()
                                  .isNotEmpty) {
                                controller.searchProduct(
                                    controller.textController!.text);
                              }
                            },
                            child: Text(
                              "Search",
                              style: TextStyle(color: AppColors.blackColor),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.whiteColor),
                            onPressed: () async {
                              // controller.textController!.clear();
                              // controller.searchP = false;
                              await controller.all();
                            },
                            child: Text(
                              "All",
                              style: TextStyle(color: AppColors.blackColor),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: Get.height / 1.2,
                    child: ListView.builder(
                        itemCount: controller.searchV
                            ? controller.vendorsSearch.length
                            : controller.vendors.length,
                        itemBuilder: (ctx, i) {
                          VendorModel vendor = controller.searchV
                              ? controller.vendorsSearch[i]
                              : controller.vendors[i];
                          return VendorListItem(vendorModel: vendor);
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
                    fontSize: AppDimens.font30,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              )),
      ),
    );
  }
}
