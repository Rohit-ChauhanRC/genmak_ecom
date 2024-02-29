import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';

import 'package:get/get.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.h),
              alignment: Alignment.center,
              child: Text(
                'Verify OTP',
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: AppDimens.font24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 50,
                left: 20,
                right: 20,
              ),
              padding: const EdgeInsets.all(15),
              child: Form(
                key: controller.loginFormKey,
                child: Column(
                  children: [
                    Obx(() => SizedBox(
                          width: Get.width - 40,
                          child: RichText(
                            overflow: TextOverflow.visible,
                            text: TextSpan(
                                text: "Mobile Number",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: "Raleway",
                                  letterSpacing: 1.5,
                                ),
                                children: [
                                  TextSpan(
                                    text: "\t\t${controller.mobileNumber}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red[900],
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "\t\t${"Constants.remaining"}\t ${80 - controller.count}s",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red[900],
                                    ),
                                  ),
                                ]),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Please enter OTP:",
                        style: TextStyle(
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
                              ? AppDimens.font22
                              : AppDimens.font16,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFormWidget(
                      label: "Please enter OTP...",
                      maxLength: 4,
                      onChanged: (val) => controller.otp = val,
                      validator: (value) =>
                          value!.length < 4 ? "Please enter valid otp" : null,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 30,
                      ),
                      // width: Get.width / 2,
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller.otpVerify();
                          // Get.toNamed(Routes.HOME);
                        },
                        child: Text(
                          "Verify",
                          style: TextStyle(
                              fontSize: 18, color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                    // : const CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
