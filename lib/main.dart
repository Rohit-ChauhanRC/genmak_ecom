import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_mak_inapp/app/constants/constants.dart';

import 'app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final box = GetStorage();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appbarTitle,
      initialRoute:
          box.read(Constants.cred) != null ? AppPages.CHECK : AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
