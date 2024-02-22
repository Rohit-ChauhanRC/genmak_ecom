import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';
import 'package:genmak_ecom/app/utils/widgets/upload_image_widget.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.blackColor,
          size: MediaQuery.of(Get.context!).size.width > 650 ? 40 : 20,
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(Get.context!).size.width > 650
                ? AppDimens.font30
                : AppDimens.font18,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        // width: Get.width / 1.2,
        // alignment: Alignment.center,
        child: Column(
          // shrinkWrap: true,
          children: [
            const SizedBox(
              height: 20,
            ),
            Obx(() => UploadImageWidget(
                  imageFile: controller.homeController.personPic,
                  onTap: controller.homeController.getImage1,
                  bytes: controller.homeController.personPicM,
                  imageDb: controller.homeController.memoryImg,
                )),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              child: Text(
                "Customer ID: 223234",
                style: TextStyle(
                  fontSize: MediaQuery.of(Get.context!).size.width > 650
                      ? AppDimens.font22
                      : AppDimens.font16,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(Get.context!).size.width > 650 ? 20 : 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Shop Name :",
                style: TextStyle(
                  fontSize: MediaQuery.of(Get.context!).size.width > 650
                      ? AppDimens.font22
                      : AppDimens.font16,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            TextFormWidget(
              // label: "Please enter Shop Name...",
              onChanged: (val) {},
            ),
            SizedBox(
              height: MediaQuery.of(Get.context!).size.width > 650 ? 20 : 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Shop Address :",
                style: TextStyle(
                  fontSize: MediaQuery.of(Get.context!).size.width > 650
                      ? AppDimens.font22
                      : AppDimens.font16,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            TextFormWidget(
              label: "Pleae enter Shop Address...",
              onChanged: (val) {},
            ),
            SizedBox(
              height: MediaQuery.of(Get.context!).size.width > 650 ? 20 : 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Contact No :",
                style: TextStyle(
                  fontSize: MediaQuery.of(Get.context!).size.width > 650
                      ? AppDimens.font22
                      : AppDimens.font16,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            TextFormWidget(
              label: "Pleae enter Contact No...",
              onChanged: (val) {},
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: MediaQuery.of(Get.context!).size.width > 650 ? 20 : 10,
            ),
            SizedBox(
                // width: Get.width / 8,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: AppColors.blackColor,
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
