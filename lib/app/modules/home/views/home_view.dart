import 'dart:io';

import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/app_drawer.dart';
import 'package:genmak_ecom/app/utils/widgets/grid_widget.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genmak Info India Limited'),
        centerTitle: true,
        actions: [
          Obx(() => CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.greenColor,
                // color: Colors.white,
                backgroundImage: controller.personPic != null &&
                        controller.personPic.path != null &&
                        controller.personPic.path != ""
                    ? Image.file(
                        File(controller.personPic.path),
                        fit: BoxFit.contain,
                      ).image
                    : Image.asset("assets/images/images.png").image,
              ))
        ],
      ),
      drawer: AppDrawer(),
      body: ListView(shrinkWrap: true, children: [
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
                  onPressed: () async {
                    if (controller.textController!.text.toString().isNotEmpty) {
                      controller.searchProduct(controller.textController!.text);
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
                    await controller.all();
                  },
                  child: const Text("All"))
            ],
          ),
        ),
        Obx(() => controller.products.isNotEmpty ||
                (controller.searchP && controller.productSearch.isNotEmpty)
            ? GetBuilder<HomeController>(builder: (context) {
                return SizedBox(
                  height: Get.height / 2.0,
                  child: GridWidget(
                    product: controller.searchP
                        ? controller.productSearch.toSet().toList()
                        : controller.products,
                    orders: controller.orders,
                    total: controller.totalAmountCal,
                    handleProductQuantity: controller.handleProductQuantity,
                  ),
                );
              })
            : SizedBox(
                height: Get.height / 2.01,
                child: Center(
                  child: Text(
                    "No data found!...",
                    style: TextStyle(
                      color: AppColors.brownColor,
                      fontSize: AppDimens.font24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )),
        Container(
          height: Get.height / 3.0,
          // color: Colors.black,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.blackColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: Text(
                  "Order",
                  style: TextStyle(
                    fontSize: AppDimens.font24,
                    color: AppColors.brownColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              Container(
                height: 200.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.blackColor,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height / 4.9,
                      child: Obx(() => controller.orders.isNotEmpty
                          ? ListView.separated(
                              itemCount:
                                  controller.orders.toSet().toList().length,
                              itemBuilder: (ctx, i) {
                                final data =
                                    controller.orders.toSet().toList()[i];

                                return Obx(() => controller.orders
                                            .toSet()
                                            .toList()[i]
                                            .count! >=
                                        1
                                    ? Container(
                                        margin: const EdgeInsets.only(
                                          top: 20,
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: Get.width / 6,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      controller.itemSub(i);
                                                    },
                                                    child: Icon(
                                                      Icons
                                                          .remove_circle_outline,
                                                      color: AppColors
                                                          .reddishColor,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    " ${controller.orders.toSet().toList()[i].count}",
                                                    style: TextStyle(
                                                      fontSize:
                                                          AppDimens.font24,
                                                      color:
                                                          AppColors.brownColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      controller.itemAdd(i);
                                                    },
                                                    child: Icon(
                                                      Icons.add_circle_outlined,
                                                      color:
                                                          AppColors.brownColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width / 2.7,
                                              child: Text(
                                                "${data.name}",
                                                overflow: TextOverflow.visible,
                                                style: TextStyle(
                                                  fontSize: AppDimens.font24,
                                                  color: AppColors.brownColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width / 6,
                                              child: Text(
                                                "₹${int.tryParse(data.price!)! * data.count!}",
                                                style: TextStyle(
                                                  fontSize: AppDimens.font24,
                                                  color: AppColors.brownColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox());
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider();
                              },
                            )
                          : const SizedBox()),
                    ),
                    Container(
                      // color: Colors.blue,
                      decoration: const BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                              fontSize: AppDimens.font24,
                              color: AppColors.brownColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Obx(() => controller.totalAmount != 0.0
                              ? Text(
                                  "₹${controller.totalAmount.toString()}",
                                  style: TextStyle(
                                    fontSize: AppDimens.font24,
                                    color: AppColors.brownColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Text(
                                  "₹0.0",
                                  style: TextStyle(
                                    fontSize: AppDimens.font24,
                                    color: AppColors.brownColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                controller.connectionEst();
                // controller.tcpConn();
                // controller.discover();
                // await controller.checkP();
                if (controller.orders.isNotEmpty) await controller.onSave();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brownColor,
              ),
              child: const Text("Save"),
            ),
            // const SizedBox(
            //   width: 20,
            // ),
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: AppColors.reddishColor,
            //   ),
            //   child: const Text("Cart"),
            // )
          ],
        ),
      ]),
      // floatingActionButton:
    );
  }
}
