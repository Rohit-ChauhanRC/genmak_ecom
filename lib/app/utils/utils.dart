import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'app_colors/app_colors.dart';
import 'app_dimens/app_dimens.dart';

class Utils {
  const Utils._();
  //
  static Future<void> showImagePicker({
    required Function(XFile image) onGetImage,
  }) {
    return showModalBottomSheet<void>(
      context: Get.context!,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    getImage(source: 2).then((v) {
                      if (v != null) {
                        onGetImage(XFile(v.path));
                        Get.back();
                      }
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image,
                        size: 60,
                        color: AppColors.greenColor,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Gallery",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.reddishColor,
                          fontSize: AppDimens.font16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    getImage().then((v) {
                      if (v != null) {
                        onGetImage(XFile(v.path));
                        Get.back();
                      }
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera,
                        size: 60,
                        color: AppColors.greenColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Camera",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.reddishColor,
                          fontSize: AppDimens.font16,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static Future<CroppedFile> getImage({int source = 1}) async {
    CroppedFile? croppedFile;
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(
      source: source == 1 ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 60,
    );

    if (pickedFile != null) {
      final image = File(pickedFile!.path);

      if (image != null) {
        croppedFile = (await ImageCropper().cropImage(
          compressQuality: 50,
          sourcePath: image!.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            IOSUiSettings(
              minimumAspectRatio: 0.1,
              aspectRatioLockDimensionSwapEnabled: true,
            ),
            AndroidUiSettings(
              toolbarColor: Colors.transparent,
              toolbarWidgetColor: Colors.transparent,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
          ],
        ))!;
      }
    }

    return croppedFile!;
  }

  static void closeKeyboard() {
    final currentFocus = Get.focusScope;
    // if (!currentFocus.hasPrimaryFocus) {
    currentFocus!.unfocus();
    // }
  }

  static void loadingDialog() {
    Utils.closeDialog();

    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static void closeDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static void closeSnackbar() {
    if (Get.isSnackbarOpen) {
      Get.back();
    }
  }

  static void showDialog(String message) => Get.defaultDialog(
        barrierDismissible: false,
        backgroundColor: AppColors.whiteColor,
        onWillPop: () async {
          Get.back();

          return true;
        },
        titleStyle: TextStyle(color: AppColors.buttonColor),
        // title: success ? Strings.success : title,
        content: Text(
          message,
          textAlign: TextAlign.center,
          maxLines: 6,
          style: TextStyle(
            color: AppColors.buttonColor,
            fontSize: AppDimens.font16,
          ),
        ),
        confirm: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Text(
              "OK",
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: AppDimens.font16,
              ),
            ),
          ),
        ),
      );
}
