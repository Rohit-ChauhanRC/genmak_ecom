import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
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
                'Login',
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
                    Container(
                      margin: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: TextFormField(
                        validator: (value) => value!.isNotEmpty
                            ? "Please enter valid customer id!"
                            : null,
                        keyboardType: TextInputType.text,
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.digitsOnly,
                        // ],
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (val) {
                          // controller.mobileNumber = val;
                        },
                        decoration: InputDecoration(
                          label: const Text("Please enter customer id"),
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
                    // Container(
                    //   margin: const EdgeInsets.only(
                    //     top: 30,
                    //   ),
                    //   child: TextFormField(
                    //     validator: (value) => value!.isNotEmpty
                    //         ? "Please enter valid password!"
                    //         : null,
                    //     keyboardType: TextInputType.text,
                    //     // inputFormatters: [
                    //     //   FilteringTextInputFormatter.digitsOnly,
                    //     // ],
                    //     autovalidateMode: AutovalidateMode.always,
                    //     onChanged: (val) {
                    //       // controller.mobileNumber = val;
                    //     },
                    //     decoration: InputDecoration(
                    //       label: const Text("Please enter password"),
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: const BorderSide(
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: const BorderSide(
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //       errorBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: const BorderSide(
                    //           color: Colors.red,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    Container(
                      margin: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: TextFormField(
                        validator: (value) => value!.length < 10
                            ? "Please enter valid mobile no."
                            : null,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (val) {
                          controller.mobileNumber = val;
                        },
                        decoration: InputDecoration(
                          label: const Text("Please enter mobile no."),
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
                                Get.toNamed(Routes.OTP);

                                if (controller.agreeCheck) {
                                  await controller.login();
                                }
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 18, color: AppColors.whiteColor),
                              ),
                            ),
                          )
                        : const CircularProgressIndicator(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
