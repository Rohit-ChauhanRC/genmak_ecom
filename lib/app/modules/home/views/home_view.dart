import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('HomeView'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
              controller: controller.webViewController,
            ),
            Obx(
              () => controller.circularProgress
                  ? Center(
                      child: CircularProgressIndicator(
                        value: controller.progress.toDouble(),
                        backgroundColor: Colors.purple[900],
                      ),
                    )
                  : const Stack(),
            )
          ],
        ),
      ),
    );
  }
}
