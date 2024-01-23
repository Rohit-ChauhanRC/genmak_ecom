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
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
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
                  fontSize: AppDimens.font22,
                  color: AppColors.brownColor,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormWidget(
              label: "Please enter Shop Name...",
              onChanged: (val) {},
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormWidget(
              label: "Pleae enter Shop Address...",
              onChanged: (val) {},
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormWidget(
              label: "Pleae enter Contact No...",
              onChanged: (val) {},
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                // width: Get.width / 8,
                child: ElevatedButton(
                    // style: ElevatedButton.styleFrom(maximumSize: Size(200, 50)),
                    onPressed: () {},
                    child: const Text("Save"))),
          ],
        ),
      ),
    );
  }
}
