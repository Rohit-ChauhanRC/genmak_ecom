import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../controllers/home_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
            // WebViewWidget(
            //   controller: controller.webViewController,
            // ),
            // Obx(
            //   () => controller.circularProgress
            //       ? Center(
            //           child: CircularProgressIndicator(
            //             value: controller.progress.toDouble(),
            //             backgroundColor: Colors.purple[900],
            //           ),
            //         )
            //       : const Stack(),
            // )

            InAppWebView(
              key: controller.webViewKey,
              initialUrlRequest: URLRequest(
                  url: WebUri(
                      "https://app.maklifedairy.in:5017/index.php/Login/Check_Login/${controller.mobileNumber.toString()}")),
              initialSettings: controller.settings,
              pullToRefreshController: controller.pullToRefreshController,
              onWebViewCreated: (cx) {
                controller.webViewController = cx;
              },
              // onLoadStart: (controller, url) {
              // setState(() {
              // url = url.toString();
              // urlController.text = this.url;
              // });
              // },
              onPermissionRequest: (controller, request) async {
                return PermissionResponse(
                    resources: request.resources,
                    action: PermissionResponseAction.GRANT);
              },
              // shouldOverrideUrlLoading: (cx, navigationAction) async {
              //   var uri = navigationAction.request.url!;

              //   if (![
              //     "http",
              //     "https",
              //     "file",
              //     "chrome",
              //     "data",
              //     "javascript",
              //     "about"
              //   ].contains(uri.scheme)) {
              //     if (await canLaunchUrl(uri)) {
              //       // Launch the App
              //       await launchUrl(
              //         uri,
              //       );
              //       // and cancel the request
              //       return NavigationActionPolicy.CANCEL;
              //     }
              //   }

              //   return NavigationActionPolicy.ALLOW;
              // },
              // onLoadStop: (cx, url) async {
              //   controller.pullToRefreshController!.endRefreshing();
              //   // setState(() {
              //   //   this.url = url.toString();
              //   //   urlController.text = this.url;
              //   // });
              // },
              onReceivedError: (cx, request, error) {
                controller.pullToRefreshController!.endRefreshing();
              },
              onProgressChanged: (cx, progress) {
                // if (progress == 100) {
                //   controller.pullToRefreshController!.endRefreshing();
                // }
                // setState(() {
                //   this.progress = progress / 100;
                //   urlController.text = url;
                // });
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                // setState(() {
                //   this.url = url.toString();
                //   urlController.text = this.url;
                // });
              },
              onConsoleMessage: (controller, consoleMessage) {
                if (kDebugMode) {
                  print(consoleMessage);
                }
              },
              onDownloadStartRequest: (controller, request) async {
                if (kDebugMode) {
                  print('onDownloadStart $request');
                }
                final taskId = await FlutterDownloader.enqueue(
                  url: request.url.toString(),
                  savedDir: (await getDownloadsDirectory())?.path ?? '',
                  showNotification: true,
                  saveInPublicStorage:
                      true, // show download progress in status bar (for Android)
                  openFileFromNotification: true,
                );
              },
            ),
            controller.progress < 1.0
                ? LinearProgressIndicator(value: controller.progress.toDouble())
                : Container(),
          ],
        ),
      ),
    );
  }
}
