import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/theme/app_theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await GetStorage.init();
  final box = GetStorage();

  runApp(
    ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            title: "Ecommerce",
            initialRoute: (box.read("login") != null)
                ? AppPages.INITIAL1
                : AppPages.INITIAL,
            getPages: AppPages.routes,
            theme: AppTheme.theme,
            debugShowCheckedModeBanner: false,
          );
        }),
  );
}
