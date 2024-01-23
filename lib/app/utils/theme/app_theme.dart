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
        color: AppColors.bgColor,
        fontSize: AppDimens.font18,
        fontWeight: FontWeight.w700,
      ),
    );

    return ThemeData(
        fontFamily: "Nunito",
        colorScheme: ColorScheme.light(
          background: AppColors.bgColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.bgColor,
          titleTextStyle: TextStyle(
            color: AppColors.brownColor,
            fontFamily: "Kalnia_Expanded-Bold",
            fontSize: AppDimens.font40,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: AppColors.brownColor,
            size: 40,
          ),
          actionsIconTheme: IconThemeData(
            color: AppColors.brownColor,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.brownColor,
          height: 50,
          minWidth: 300,
          textTheme: ButtonTextTheme.normal,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.brownColor,
            textStyle: const TextStyle(
              // color: Colors.white,
              fontSize: AppDimens.font22,
            ),
            foregroundColor: Colors.white,
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
