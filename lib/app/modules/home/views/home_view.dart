import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/utils.dart';
import 'package:genmak_ecom/app/utils/widgets/app_drawer.dart';
import 'package:genmak_ecom/app/utils/widgets/grid_widget.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';
import 'package:genmak_ecom/app/utils/widgets/upload_image_widget.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgrader/upgrader.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.whiteColor,
          size: MediaQuery.of(Get.context!).size.width > 720 ? 40 : 20,
        ),
        title: SizedBox(
          width: Get.width * 0.6,
          child: Obx(() => Text(
                controller.appTitle ?? 'Genmak Info India Limited',
                // overflow: TextOverflow.visible,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(Get.context!).size.width > 720
                      ? AppDimens.font30
                      : AppDimens.font18,
                ),
              )),
        ),
        centerTitle: true,
        actions: [
          // Obx(() => CircleAvatar(
          //       radius: MediaQuery.of(Get.context!).size.width > 720 ? 50 : 20,
          //       backgroundColor: AppColors.greenColor,
          //       // color: Colors.white,
          //       backgroundImage: controller.personPic != null &&
          //               controller.personPic.path != null &&
          //               controller.personPic.path != ""
          //           ? Image.file(
          //               File(controller.personPic.path),
          //               fit: BoxFit.contain,
          //             ).image
          //           : Image.asset("assets/images/images.png").image,
          //     )),
          CircleAvatar(
            //
            maxRadius: MediaQuery.of(Get.context!).size.width > 720 ? 42 : 22,
            minRadius: MediaQuery.of(Get.context!).size.width > 720 ? 40 : 20,
            backgroundColor: AppColors.bgColor1,
            child: Obx(() => UploadImageWidget(
                  imageFile: controller.personPic,
                  onTap: controller.getImage1,
                  bytes: controller.personPicM,
                  imageDb: controller.memoryImg,
                )),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: UpgradeAlert(
        dialogStyle: UpgradeDialogStyle.cupertino,
        showIgnore: false,
        showLater: false,
        canDismissDialog: false,
        showReleaseNotes: true,
        upgrader: Upgrader(),
        child: ListView(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            children: [
              Container(
                color: AppColors.buttonColor,
                height: 35.h,
                margin: const EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(
                  left: MediaQuery.of(Get.context!).size.width > 720 ? 10 : 3,
                  right: MediaQuery.of(Get.context!).size.width > 720 ? 10 : 3,
                ),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      // height: 30.h,
                      width: Get.width / 2.4,
                      child: TextFormWidget(
                        suffix: true,
                        textController: controller.textController,
                        label: "Search...",
                        onChanged: (v) =>
                            controller.textController!.text = v.toString(),
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
                          if (controller.textController!.text
                              .toString()
                              .isNotEmpty) {
                            controller
                                .searchProduct(controller.textController!.text);
                          }
                        },
                        child: const Text(
                          "Search",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
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
                              padding: const EdgeInsets.all(0)),
                          onPressed: () async {
                            // controller.textController!.clear();
                            // controller.searchP = false;
                            await controller.all();
                          },
                          child: const Text(
                            "All",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              Obx(() => controller.products.isNotEmpty ||
                      (controller.searchP &&
                          controller.productSearch.isNotEmpty)
                  ? GetBuilder<HomeController>(builder: (_) {
                      return SizedBox(
                        height: Get.height / 2.0,
                        child: GridWidget(
                          product: controller.searchP
                              ? controller.productSearch.toSet().toList()
                              : controller.products,
                          orders: controller.orders,
                          total: controller.totalAmountCal,
                          handleProductQuantity:
                              controller.handleProductQuantity,
                        ),
                      );
                    })
                  : SizedBox(
                      height: Get.height / 2.01,
                      child: Center(
                        child: Text(
                          "No data found!...",
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize:
                                MediaQuery.of(Get.context!).size.width > 720
                                    ? AppDimens.font30
                                    : AppDimens.font18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
              Container(
                // height: Get.height / 4,
                // color: Colors.black,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.buttonColor,
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
                          fontSize: MediaQuery.of(Get.context!).size.width > 720
                              ? AppDimens.font24
                              : AppDimens.font18,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    Container(
                      // height: Get.height / 9,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.blackColor,
                        ),
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height / 5,
                            child: Obx(() => controller.orders.isNotEmpty
                                ? ListView.separated(
                                    itemCount: controller.orders
                                        .toSet()
                                        .toList()
                                        .length,
                                    itemBuilder: (ctx, i) {
                                      final data =
                                          controller.orders.toSet().toList()[i];

                                      return Obx(() => controller.orders
                                                  .toSet()
                                                  .toList()[i]
                                                  .count! >=
                                              1
                                          ? GetBuilder<HomeController>(
                                              builder: (_) {
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                  top: 20,
                                                  left: 20,
                                                  right: 20,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      // width: Get.width / 6,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              controller
                                                                  .itemSub(i);
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .remove_circle_outline,
                                                              color: AppColors
                                                                  .buttonColor,
                                                              size: 20,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width >
                                                                    720
                                                                ? 20
                                                                : 5,
                                                          ),
                                                          Text(
                                                            " ${controller.orders.toSet().toList()[i].count}",
                                                            style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width >
                                                                      720
                                                                  ? AppDimens
                                                                      .font24
                                                                  : AppDimens
                                                                      .font16,
                                                              color: AppColors
                                                                  .blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width >
                                                                    720
                                                                ? 20
                                                                : 5,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              controller
                                                                  .itemAdd(i);
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .add_circle_outlined,
                                                              color: AppColors
                                                                  .bgColor1,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width >
                                                                  720
                                                              ? Get.width / 2.7
                                                              : Get.width / 3.5,
                                                      child: Text(
                                                        "${data.name}-${data.weight}${data.unit}",
                                                        overflow: TextOverflow
                                                            .visible,
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width >
                                                                  720
                                                              ? AppDimens.font24
                                                              : AppDimens
                                                                  .font16,
                                                          color: AppColors
                                                              .blackColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width >
                                                                  720
                                                              ? Get.width / 6
                                                              : Get.width / 7,
                                                      child: Text(
                                                        "₹${double.tryParse(data.price!)!.toPrecision(2) * data.count!}",
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width >
                                                                  720
                                                              ? AppDimens.font24
                                                              : AppDimens
                                                                  .font16,
                                                          color: AppColors
                                                              .blackColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })
                                          : const SizedBox());
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Obx(() => controller.orders
                                              .toSet()
                                              .toList()
                                              .isNotEmpty
                                          ? const Divider()
                                          : const SizedBox());
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
                                    fontSize:
                                        MediaQuery.of(Get.context!).size.width >
                                                720
                                            ? AppDimens.font24
                                            : AppDimens.font18,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Obx(() => controller.totalAmount != 0.0
                                    ? Text(
                                        "₹${controller.totalAmount.toPrecision(2)}",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(Get.context!)
                                                      .size
                                                      .width >
                                                  720
                                              ? AppDimens.font24
                                              : AppDimens.font18,
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Text(
                                        "₹0.0",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(Get.context!)
                                                      .size
                                                      .width >
                                                  720
                                              ? AppDimens.font24
                                              : AppDimens.font18,
                                          color: AppColors.blackColor,
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
                      // controller.calulateGST();
                      if (controller.orders.isNotEmpty) {
                        await controller.onSave();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                    ),
                    child: Text(
                      "Save & Print",
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     // controller.calulateGST();
                  //     if (controller.orders.isNotEmpty) {
                  //       await controller.printBtn();
                  //       // for (var i = 0; i < controller.orders.length; i++) {
                  //       //   print(
                  //       //       "controller.orders: ${controller.orders[i].id}");
                  //       // }
                  //     } else {
                  //       Utils.showDialog("Order is emplty!");
                  //       // print("controller.orders: ${controller.orders}");
                  //     }
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: AppColors.buttonColor,
                  //   ),
                  //   child: Text(
                  //     "Print",
                  //     style: TextStyle(color: AppColors.whiteColor),
                  //   ),
                  // ),

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
              const SizedBox(
                height: 20,
              ),
            ]),
      ),
      // floatingActionButton:
    );
  }
}
