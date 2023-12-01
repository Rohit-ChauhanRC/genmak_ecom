import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_mak_inapp/app/constants/constants.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appbarTitle,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'http_override.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   HttpOverrides.global = DevHttpOverrides();

//   if (!kIsWeb &&
//       kDebugMode &&
//       defaultTargetPlatform == TargetPlatform.android) {
//     await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(
//         kDebugMode);
//   }
//   // await Permission.
//   runApp(const MaterialApp(home: MyApp()));
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final GlobalKey webViewKey = GlobalKey();

//   InAppWebViewController? webViewController;

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // detect Android back button click
//         final controller = webViewController;
//         if (controller != null) {
//           if (await controller.canGoBack()) {
//             controller.goBack();
//             return false;
//           }
//         }
//         return true;
//       },
//       child: Scaffold(
//           appBar: AppBar(
//             title: const Text("InAppWebView test"),
//           ),
//           body: Column(children: <Widget>[
//             Expanded(
//               child: InAppWebView(
//                 key: webViewKey,
//                 initialUrlRequest:
//                     URLRequest(url: Uri.parse("https://maklifedairy.in")),
//                 onWebViewCreated: (controller) {
//                   webViewController = controller;
//                 },
//               ),
//             ),
//           ])),
//     );
//   }
// }
