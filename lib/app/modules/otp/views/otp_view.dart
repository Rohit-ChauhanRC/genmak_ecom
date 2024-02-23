import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';

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
                                text: "Constants.plsOtp",
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
                                  const TextSpan(
                                    text: "\n${"Constants.regenerate"}",
                                  ),
                                  const TextSpan(
                                    text: "\n${"Constants.yourOtp"}",
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

                    Container(
                      margin: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: TextFormField(
                        validator: (value) =>
                            value!.length < 4 || value!.length > 5
                                ? "Please enter valid otp"
                                : null,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (val) {
                          controller.otp = val;
                        },
                        decoration: InputDecoration(
                          label: const Text("Please enter OTP..."),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Obx(() => controller.resend
                    //     ? InkWell(
                    //         onTap: () {
                    //           controller.resendOtp();
                    //         },
                    //         child: Text(
                    //           Constants.dontReceive,
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.purple[900],
                    //           ),
                    //         ),
                    //       )
                    //     : const SizedBox()),
                    // controller.circularProgress
                    //     ?
                    Container(
                      margin: const EdgeInsets.only(
                        top: 30,
                      ),
                      // width: Get.width / 2,
                      child: ElevatedButton(
                        onPressed: () async {
                          // await controller.otpVerify();
                          Get.toNamed(Routes.HOME);
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
