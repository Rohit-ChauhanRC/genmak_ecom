import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:webview_mak_inapp/app/constants/constants.dart';

class HomeController extends GetxController {
  //

  static final box = GetStorage();

  // var no = box.read(Constants.cred);

  final RxString _mobileNumber = ''.obs;
  String get mobileNumber => _mobileNumber.value;
  set mobileNumber(String mobileNumber) => _mobileNumber.value = mobileNumber;

  WebViewController webViewController = WebViewController();

  Future<void> permisions() async {
    await Permission.storage.request();
    await Permission.camera.request();
    await Permission.mediaLibrary.request();
    await Permission.microphone.request();
    await Permission.photos.request();
  }

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    mobileNumber = box.read(Constants.cred) ?? Get.arguments;
    await permisions();
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('http://app.maklifedairy.in:5011/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.https('app.maklifedairy.in:5017',
            '/index.php/Login/Check_Login/${mobileNumber.toString()}'),
        // method: LoadRequestMethod.post,
      );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
