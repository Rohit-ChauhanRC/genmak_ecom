import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';

class AppTheme {
  const AppTheme._();

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
          backgroundColor: AppColors.bgColor1,
          titleTextStyle: TextStyle(
            color: AppColors.blackColor,
            fontFamily: "Kalnia_Expanded-Bold",
            fontSize: AppDimens.font30,
            fontWeight: FontWeight.bold,
            // overflow: TextOverflow.visible,
          ),
          iconTheme: IconThemeData(
            color: AppColors.blackColor,
            size: 40,
          ),
          actionsIconTheme: IconThemeData(
            color: AppColors.blackColor,
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
            backgroundColor: AppColors.whiteColor,
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: AppDimens.font22,
            ),
            // foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColors.whiteColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: AppColors.brownColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: AppColors.brownColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: AppColors.redColor,
            ),
          ),
        ),
        drawerTheme: DrawerThemeData(
            backgroundColor: AppColors.brownColor.withOpacity(0.7)));
  }
}
