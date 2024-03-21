import 'dart:io';

import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/modules/home/controllers/home_controller.dart';
import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/upload_image_widget.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.whiteColor,
      // backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      elevation: 10,
      width: Get.width * 0.7,
      child: ListView(
        children: [
          Column(
            children: [
              // Obx(() => CircleAvatar(
              //       radius:
              //           MediaQuery.of(Get.context!).size.width > 720 ? 70 : 45,
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
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(Get.context!).size.width > 720
                            ? 100
                            : 50),
                    border: Border.all(
                      color: AppColors.buttonColor,
                      width: 2,
                    )),
                child: Obx(() => UploadImageWidget(
                      imageFile: controller.personPic,
                      onTap: controller.getImage1,
                      bytes: controller.personPicM,
                      imageDb: controller.memoryImg,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => Text(
                    controller.customerId,
                    // overflow: TextOverflow.visible,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(Get.context!).size.width > 720
                          ? AppDimens.font30
                          : AppDimens.font18,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Obx(() => Text(
                    controller.appTitle,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(Get.context!).size.width > 720
                          ? AppDimens.font30
                          : AppDimens.font18,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Divider(
                color: AppColors.buttonColor,
                thickness: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.PROFILE);
                },
                title: Text(
                  "Profile",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: MediaQuery.of(Get.context!).size.width > 720
                        ? AppDimens.font26
                        : AppDimens.font18,
                  ),
                ),
                leading: Icon(
                  Icons.person,
                  color: AppColors.blackColor,
                  size: MediaQuery.of(Get.context!).size.width > 720 ? 40 : 20,
                ),
              ),
              ListTile(
                title: Text(
                  "Admin",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: MediaQuery.of(Get.context!).size.width > 720
                        ? AppDimens.font26
                        : AppDimens.font18,
                  ),
                ),
                leading: Icon(
                  Icons.admin_panel_settings,
                  color: AppColors.blackColor,
                  size: MediaQuery.of(Get.context!).size.width > 720 ? 40 : 20,
                ),
                onTap: () {
                  Get.toNamed(Routes.ADMIN);
                },
              ),
            ],
          ),

          // ListTile(
          //   title: Text(
          //     "Billing",
          //     style: TextStyle(
          //       color: AppColors.blackColor,
          //       fontSize: MediaQuery.of(Get.context!).size.width > 720
          //           ? AppDimens.font26
          //           : AppDimens.font18,
          //     ),
          //   ),
          //   leading: Icon(
          //     Icons.home,
          //     color: AppColors.blackColor,
          //     size: MediaQuery.of(Get.context!).size.width > 720 ? 40 : 20,
          //   ),
          //   onTap: () {
          //     Get.toNamed(Routes.HOME);
          //   },
          // ),

          // Expanded(
          //     child: Container(
          //   margin: const EdgeInsets.only(left: 15),
          //   alignment: Alignment.bottomLeft,
          //   child: Text(
          //     "Constants.logout.toUpperCase()",
          //     style: const TextStyle(
          //       color: Colors.white,
          //       fontSize: 16,
          //     ),
          //   ),
          // ))
        ],
      ),
    );
  }
}
