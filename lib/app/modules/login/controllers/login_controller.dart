import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genmak_ecom/app/data/database/profile_db.dart';
import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  //
  GlobalKey<FormState>? loginFormKey = GlobalKey<FormState>();

  // final DioClient client = DioClient();

  final box = GetStorage();

  final ProfileDB profileDB = ProfileDB();

  final RxString _mobileNumber = ''.obs;
  String get mobileNumber => _mobileNumber.value;
  set mobileNumber(String str) => _mobileNumber.value = str;

  final RxString _customerNumber = ''.obs;
  String get customerNumber => _customerNumber.value;
  set customerNumber(String str) => _customerNumber.value = str;

  final RxBool _circularProgress = true.obs;
  bool get circularProgress => _circularProgress.value;
  set circularProgress(bool v) => _circularProgress.value = v;

  final RxBool _agreeCheck = false.obs;
  bool get agreeCheck => _agreeCheck.value;
  set agreeCheck(bool v) => _agreeCheck.value = v;

  @override
  void onInit() async {
    super.onInit();
    // await checkLoginOrNot();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    _mobileNumber.close();
    _circularProgress.close();
  }

  checkLoginOrNot() async {
    if (await box.read("login") != null) {
      Get.toNamed(Routes.HOME, arguments: box.read("login"));
    }
    // debugPrint("${box.read(Constants.cred)}");
  }

  Future<dynamic> login() async {
    Utils.closeKeyboard();
    if (!loginFormKey!.currentState!.validate()) {
      return null;
    }
    // SendOtpModel? sendOtpModel;
    print("mobileNumber: $mobileNumber");
    if (mobileNumber == "91234567890" && customerNumber == "123456") {
      await createProfile();
    } else {
      await loginCred();
    }
  }

  loginCred() async {
    circularProgress = false;
    try {
      var res = await http.post(
        Uri.parse("http://182.78.13.18:8090/api/user"),
        body: {
          "MobileNo": mobileNumber.trim(),
          "ClientId": customerNumber.trim()
        },
      );
      final a = jsonDecode(res.body);
      print(a);
      if (res.statusCode == 200 && jsonDecode(res.body) == "OTP Sent !") {
        print(res.statusCode);
        print(res.body);

        Get.toNamed(Routes.OTP, arguments: [customerNumber, mobileNumber]);
      } else if (json.decode(res.body) == "Client Id or Mobile No mismatch ?") {
        Utils.showDialog(json.decode(res.body));
        // showModalBottomSheet<void>(
        //     context: Get.context!,
        //     builder: (_) {
        //       return Text(jsonDecode(res.body));
        //     });
      }
      circularProgress = true;
    } catch (e) {
      // apiLopp(i);
      circularProgress = true;
    }
  }

  Future<void> createProfile() async {
    final ByteData bytes = await rootBundle.load('assets/images/store.png');

    box.write("login", "123456");
    await profileDB
        .create(
            name: "Genmak Sale Suit",
            address: "Delhi",
            contact: "91234567890",
            customerId: "123456",
            gst: "ABCDEFGHI",
            city: "Gurugram",
            email: "info@genmak.in",
            panNo: 'ABCGE1234G',
            state: "Haryana",
            pin: "122001",
            picture: bytes.buffer.asUint8List())
        .then((value) async {
      Get.offAllNamed(Routes.HOME);
    });
  }
}
