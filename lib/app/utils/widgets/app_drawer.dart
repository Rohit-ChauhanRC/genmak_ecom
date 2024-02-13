import 'dart:io';

import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/modules/home/controllers/home_controller.dart';
import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.blackColor,
      // backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      elevation: 10,
      width: Get.width * 0.7,
      child: ListView(
        children: [
          Column(
            children: [
              Obx(() => CircleAvatar(
                    radius: 70,
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
                  )),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.white,
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
                    color: AppColors.whiteColor,
                    fontSize: AppDimens.font26,
                  ),
                ),
                leading: Icon(
                  Icons.person,
                  color: AppColors.whiteColor,
                  size: 40,
                ),
              ),
              ListTile(
                title: Text(
                  "Admin",
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: AppDimens.font26,
                  ),
                ),
                leading: Icon(
                  Icons.admin_panel_settings,
                  color: AppColors.whiteColor,
                  size: 40,
                ),
                onTap: () {
                  Get.toNamed(Routes.ADMIN);
                },
              ),
            ],
          ),

          ListTile(
            title: Text(
              "Billing",
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: AppDimens.font26,
              ),
            ),
            leading: Icon(
              Icons.home,
              color: AppColors.whiteColor,
              size: 40,
            ),
            onTap: () {
              Get.toNamed(Routes.HOME);
            },
          ),

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
