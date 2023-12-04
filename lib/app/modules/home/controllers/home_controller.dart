import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  //

  WebViewController webViewController = WebViewController()
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
          '/index.php/Login/Check_Login/9868892862'),
      // method: LoadRequestMethod.post,
    );

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
    await permisions();
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
