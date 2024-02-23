import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageWidget extends StatelessWidget {
  final void Function()? onTap;
  final XFile imageFile;
  final double? width;
  final double? height;
  final bool? imageDb;
  final Uint8List? bytes;

  const UploadImageWidget({
    Key? key,
    required this.onTap,
    required this.imageFile,
    this.width,
    this.height,
    this.imageDb = false,
    this.bytes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: CircleAvatar(
        radius: MediaQuery.of(Get.context!).size.width > 650 ? 100 : 50,
        backgroundColor: AppColors.buttonColor,
        // color: Colors.white,
        backgroundImage: imageDb == false &&
                imageFile != null &&
                imageFile.path != null &&
                imageFile.path != ""
            ? Image.file(
                File(imageFile.path),
                fit: BoxFit.contain,
              ).image
            : imageDb == true
                ? Image.memory(bytes!).image
                : Image.asset("assets/images/images.png").image,
      ),
    );
  }
}
