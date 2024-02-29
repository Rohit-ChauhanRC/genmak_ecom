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
          color: AppColors.whiteColor,
          size: MediaQuery.of(Get.context!).size.width > 650 ? 40 : 20,
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(Get.context!).size.width > 650
                ? AppDimens.font30
                : AppDimens.font18,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() => !controller.progressBar
          ? SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(20),
                // width: Get.width / 1.2,
                // alignment: Alignment.center,
                child: Column(
                  // shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(Get.context!).size.width > 650
                                  ? 100
                                  : 50),
                          border: Border.all(
                            color: AppColors.buttonColor,
                            width: 2,
                          )),
                      child: Obx(() => UploadImageWidget(
                            imageFile: controller.homeController.personPic,
                            onTap: controller.homeController.getImage1,
                            bytes: controller.homeController.personPicM,
                            imageDb: controller.homeController.memoryImg,
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: Text(
                        "Customer ID: ${controller.customerId}",
                        style: TextStyle(
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
                              ? AppDimens.font22
                              : AppDimens.font16,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 650
                          ? 20
                          : 10,
                    ),
                    _textContainer("Shop Name:", controller.name),
                    // Obx(() => TextFormWidget(
                    //       // label: "Please enter Shop Name...",
                    //       onChanged: (val) => controller.name = val,
                    //       initialValue: controller.name,
                    //     )),
                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 650
                          ? 20
                          : 10,
                    ),
                    _textContainer("GSTIN No.:", controller.gst),

                    // Obx(() => TextFormWidget(
                    //       // label: "Please enter Shop Name...",
                    //       onChanged: (val) => controller.gst = val,
                    //       initialValue: controller.gst,
                    //     )),
                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 650
                          ? 20
                          : 10,
                    ),
                    _textContainer("Contact No.:", controller.contact),

                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 650
                          ? 20
                          : 10,
                    ),
                    _textContainer("Pan No.:", controller.panNo),

                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 650
                          ? 20
                          : 10,
                    ),

                    _textContainer("Shop Address:", controller.address),

                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 650
                          ? 20
                          : 10,
                    ),
                    _textContainer("State:", controller.state),

                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 650
                          ? 20
                          : 10,
                    ),
                    _textContainer("Pincode:", controller.pin),

                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.width > 650
                          ? 20
                          : 10,
                    ),

                    SizedBox(
                        // width: Get.width / 8,
                        child: ElevatedButton(
                            onPressed: () async {
                              // if (controller.homeController.memoryImg) {
                              //   await controller.updateProfile();
                              //   print("id exist");
                              // } else {
                              //   print("id not exist");

                              await controller.updateProfile();
                              // }
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(
                                color: AppColors.whiteColor,
                              ),
                            ))),
                  ],
                ),
              ),
            )
          : const CircularProgressIndicator()),
    );
  }

  Widget _textContainer(String title, String value) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          SizedBox(
            width: Get.width * 0.4,
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: MediaQuery.of(Get.context!).size.width > 650
                    ? AppDimens.font22
                    : AppDimens.font16,
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.4,
            child: Text(
              value,
              // textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontSize: MediaQuery.of(Get.context!).size.width > 650
                    ? AppDimens.font22
                    : AppDimens.font16,
                color: AppColors.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
