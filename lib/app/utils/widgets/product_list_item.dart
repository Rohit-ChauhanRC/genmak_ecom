import 'package:flutter/material.dart';
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
        height: 250,
        width: 200,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.blackColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: product.picture != null
                  ? Image.memory(
                      product.picture!,
                      fit: BoxFit.contain,
                    )
                  : Image.asset(
                      "assets/images/images.png",
                      fit: BoxFit.contain,
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
                          fontSize: AppDimens.font22,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        product.name ?? "",
                        style: TextStyle(
                          fontSize: AppDimens.font22,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Weight:",
                        style: TextStyle(
                          fontSize: AppDimens.font22,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        product.weight ?? "",
                        style: TextStyle(
                          fontSize: AppDimens.font22,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                          fontSize: AppDimens.font22,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        "₹${product.price}" ?? "₹0.0",
                        style: TextStyle(
                          fontSize: AppDimens.font22,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quntity",
                        style: TextStyle(
                          fontSize: AppDimens.font22,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        product.quantity.toString() ?? "0",
                        style: TextStyle(
                          fontSize: AppDimens.font22,
                          color: AppColors.whiteColor,
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
