import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:genmak_ecom/app/utils/widgets/text_form_widget.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: Get.height,
        width: Get.width,
        child: Column(
          // physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 50.h,
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h),
              alignment: Alignment.center,
              child: Text(
                'Login',
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: AppDimens.font24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 50,
                  left: 20,
                  right: 20,
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: controller.loginFormKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Customer Id:",
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(Get.context!).size.width > 650
                                    ? AppDimens.font22
                                    : AppDimens.font16,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextFormWidget(
                        label: "Please enter Customer Id...",
                        onChanged: (val) => controller.customerNumber = val,
                        validator: (v) =>
                            v!.isEmpty ? "Field is required!" : null,
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Mobile No.:",
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(Get.context!).size.width > 650
                                    ? AppDimens.font22
                                    : AppDimens.font16,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextFormWidget(
                        label: "Please enter Mobile No....",
                        onChanged: (val) => controller.mobileNumber = val,
                        validator: (v) =>
                            v!.isEmpty ? "Field is required!" : null,
                      ),
                      // CheckboxFormField(
                      //   title: const Text(Constants.agreeTerms),
                      //   initialValue: controller.agreeCheck,
                      //   onSaved: (val) {
                      //     controller.agreeCheck = val!;
                      //     debugPrint("${controller.agreeCheck}");
                      //   },
                      // ),
                      // Obx(() => CheckBoxWidget(
                      //       onChanged: (val) {
                      //         controller.agreeCheck = val!;
                      //         debugPrint("${controller.agreeCheck}");
                      //         debugPrint("${controller.agreeCheck}");
                      //       },
                      //       title: Constants.agreeTerms,
                      //       value: controller.agreeCheck,
                      //       width: Get.width * .6,
                      //       onTap: () {},
                      //     )),
                      controller.circularProgress
                          ? Container(
                              margin: const EdgeInsets.only(
                                top: 30,
                              ),
                              width: Get.width / 2,
                              child: ElevatedButton(
                                // style: ElevatedButton.styleFrom(
                                //   backgroundColor: Colors.purple[900],
                                //   foregroundColor: Colors.white,
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(30),
                                //   ),
                                //   fixedSize: const Size(120, 30),
                                // ),
                                onPressed: () async {
                                  // Get.toNamed(Routes.OTP);

                                  // if (controller.agreeCheck) {
                                  await controller.login();
                                  // }
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.whiteColor),
                                ),
                              ),
                            )
                          : const CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
