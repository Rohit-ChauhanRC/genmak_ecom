import 'dart:async';

import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OtpController extends GetxController {
  //
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // final DioClient client = DioClient();

  final box = GetStorage();

  final RxString _otp = ''.obs;
  String get otp => _otp.value;
  set otp(String str) => _otp.value = str;

  final RxBool _circularProgress = true.obs;
  bool get circularProgress => _circularProgress.value;
  set circularProgress(bool v) => _circularProgress.value = v;

  final RxString _mobileNumber = ''.obs;
  String get mobileNumber => _mobileNumber.value;
  set mobileNumber(String mobileNumber) => _mobileNumber.value = mobileNumber;

  final RxInt _count = 0.obs;
  int get count => _count.value;
  set count(int i) => _count.value = i;

  final RxBool _resend = true.obs;
  bool get resend => _resend.value;
  set resend(bool v) => _resend.value = v;

  @override
  void onInit() async {
    super.onInit();
    mobileNumber = Get.arguments[1].toString();
    await counter();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    _mobileNumber.close();
    _count.close();
    _otp.close();
  }

  Future<void> counter() async {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (count <= 80) count += 1;
        if (count == 80) {
          resend = true;
          count = 0;
          await resendOtp();
        }
      },
    );
  }

  Future<dynamic> resendOtp() async {
    Utils.closeKeyboard();
    try {
      var res = await http.post(
        Uri.parse("http://182.78.13.18:8090/api/user"),
        body: {
          "MobileNo": Get.arguments[1].trim(),
          "ClientId": Get.arguments[0].trim()
        },
      );
      if (res.statusCode == 200) {
        print(res.statusCode);
        print(res.body);
        // Future.delayed(Duration(seconds: 2), () {
        // showModalBottomSheet<void>(
        //     context: Get.context!,
        //     builder: (_) {
        //       return Container(
        //           padding: const EdgeInsets.all(20), child: Text(res.body));
        //     });
        // });
        // Get.toNamed(Routes.OTP, arguments: [Get.arguments[0], mobileNumber]);
      }
      circularProgress = true;
    } catch (e) {
      // apiLopp(i);
      circularProgress = true;

      showModalBottomSheet<void>(
          context: Get.context!,
          builder: (_) {
            return Text(e.toString());
          });
    }
  }

  Future<dynamic> otpVerify() async {
    Utils.closeKeyboard();
    if (!loginFormKey!.currentState!.validate()) {
      return null;
    }
    try {
      var res = await http.post(
        Uri.parse("http://182.78.13.18:8090/api/OTPValidation"),
        body: {"MobileNo": Get.arguments[1].trim(), "OTP": otp.trim()},
      );
      if (res.statusCode == 200) {
        print(res.statusCode);
        print(res.body);
        // if () {
        await fetchUserData();
        // }
      }
      circularProgress = true;
    } catch (e) {
      // apiLopp(i);
      circularProgress = true;

      showModalBottomSheet<void>(
          context: Get.context!,
          builder: (_) {
            return Text(e.toString());
          });
    }
  }

  Future<void> fetchUserData() async {
    try {
      var res = await http.get(
        Uri.parse(
            "http://182.78.13.18:8090/api/ClientDetail?ClientId=${Get.arguments[0]}"),

        // body: {"MobileNo": Get.arguments[1].trim(), "OTP": otp.trim()},
      );
      if (res.statusCode == 200) {
        print(res.statusCode);
        print(res.body);

        Get.offAllNamed(Routes.HOME, arguments: res.body);
      }
      circularProgress = true;
    } catch (e) {
      // apiLopp(i);
      circularProgress = true;

      showModalBottomSheet<void>(
          context: Get.context!,
          builder: (_) {
            return Text(e.toString());
          });
    }
  }
}
