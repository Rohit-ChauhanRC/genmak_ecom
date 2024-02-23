import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:get/get.dart';

class AppTheme {
  //  AppTheme._();

  static ThemeData get theme {
    final themeData = ThemeData.light();
    final textTheme = themeData.textTheme;

    final bodyText2 = textTheme.copyWith(
      bodyMedium: TextStyle(
        color: AppColors.bgColor1,
        fontSize: AppDimens.font18,
        fontWeight: FontWeight.w700,
      ),
    );

    return ThemeData(
        fontFamily: "Nunito",
        colorScheme: ColorScheme.light(
          background: AppColors.bgColor1,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.buttonColor,
          titleTextStyle: TextStyle(
            color: AppColors.whiteColor,
            fontFamily: "Kalnia_Expanded-Bold",

            fontWeight: FontWeight.bold,
            // overflow: TextOverflow.visible,
          ),
          actionsIconTheme: IconThemeData(
            color: AppColors.whiteColor,
          ),
        ),
        // buttonTheme: ButtonThemeData(
        //   buttonColor: AppColors.whiteColor,

        //   height: 50,
        //   minWidth: 300,
        //   textTheme: ButtonTextTheme.normal,
        // ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonColor,
            textStyle: const TextStyle(
              color: Colors.white,
              // fontSize: MediaQuery.of(Get.context!).size.width > 650
              //     ? AppDimens.font22
              //     : AppDimens.font16,
            ),
            // foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: TextStyle(color: AppColors.buttonColor),
          fillColor: AppColors.whiteColor,
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: AppColors.blackColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: AppColors.blackColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: AppColors.buttonColor,
            ),
          ),
        ),
        drawerTheme: DrawerThemeData(
            backgroundColor: AppColors.brownColor.withOpacity(0.7)));
  }
}
