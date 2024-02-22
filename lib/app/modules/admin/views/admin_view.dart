import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';

import 'package:get/get.dart';

import '../controllers/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.blackColor,
          size: MediaQuery.of(Get.context!).size.width > 650 ? 40 : 20,
        ),
        title: Text(
          'Admin',
          style: TextStyle(
            color: Colors.black,
            fontSize: MediaQuery.of(Get.context!).size.width > 650
                ? AppDimens.font30
                : AppDimens.font18,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 650 ? 4 : 2,
              mainAxisExtent:
                  MediaQuery.of(Get.context!).size.width > 650 ? 200 : 150,
            ),
            itemCount: controller.gridList.length,
            itemBuilder: (_, i) {
              var grid = controller.gridList[i];
              return _constainer(
                icon: grid["icon"],
                title: grid["title"],
                onTap: grid["onTap"],
              );
            }),
      ),
    );
  }

  Widget _constainer(
      {required IconData icon,
      required String title,
      required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 0.5.sh,
        width: 0.3.sw,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: AppColors.blackColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: MediaQuery.of(Get.context!).size.width > 650
                    ? AppDimens.font20
                    : AppDimens.font18,
                color: AppColors.blackColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
