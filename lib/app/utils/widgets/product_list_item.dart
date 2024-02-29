import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genmak_ecom/app/data/models/product_model.dart';
import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:get/get.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.EDIT_PRODUCT_ITEM, arguments: product.id);
      },
      child: Container(
        height: MediaQuery.of(Get.context!).size.width > 650 ? 250.h : 150.h,
        width: MediaQuery.of(Get.context!).size.width > 650 ? 200.w : 150.w,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.blackColor,
            ),
            borderRadius: BorderRadius.circular(10),
            color: AppColors.whiteColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
              child: product.picture != null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      child: Image.memory(
                        product.picture!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      child: Image.asset(
                        "assets/images/images.png",
                        fit: BoxFit.contain,
                      ),
                    ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name: ",
                        style: TextStyle(
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
                              ? AppDimens.font22
                              : AppDimens.font16,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: Get.width * 0.3,
                        child: Text(
                          // maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          product.name ?? "",
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(Get.context!).size.width > 650
                                    ? AppDimens.font22
                                    : AppDimens.font16,
                            color: AppColors.blackColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height:
                        MediaQuery.of(Get.context!).size.width > 650 ? 20 : 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Weight:",
                        style: TextStyle(
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
                              ? AppDimens.font22
                              : AppDimens.font16,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        product.weight ?? "",
                        style: TextStyle(
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
                              ? AppDimens.font22
                              : AppDimens.font16,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height:
                        MediaQuery.of(Get.context!).size.width > 650 ? 20 : 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
                              ? AppDimens.font22
                              : AppDimens.font16,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        "₹${product.price}" ?? "₹0.0",
                        style: TextStyle(
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
                              ? AppDimens.font22
                              : AppDimens.font16,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height:
                        MediaQuery.of(Get.context!).size.width > 650 ? 20 : 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quantity",
                        style: TextStyle(
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
                              ? AppDimens.font22
                              : AppDimens.font16,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        product.quantity.toString() ?? "0",
                        style: TextStyle(
                          fontSize: MediaQuery.of(Get.context!).size.width > 650
                              ? AppDimens.font22
                              : AppDimens.font16,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
