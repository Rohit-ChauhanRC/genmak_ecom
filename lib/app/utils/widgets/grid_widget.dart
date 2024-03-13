import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genmak_ecom/app/data/models/product_model.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:get/get.dart';

import 'card_widget.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({
    super.key,
    required this.product,
    required this.orders,
    required this.total,
    required this.handleProductQuantity,
  });

  final List<ProductModel> product;
  final List<ProductModel> orders;
  final VoidCallback total;
  final Function(int) handleProductQuantity;

  get itemBuilder => null;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 650 ? 4 : 2,
          mainAxisExtent: MediaQuery.of(context).size.width > 650 ? 250 : 180,
        ),
        itemCount: product.length,
        itemBuilder: (_, i) {
          var grid = product[i];
          return InkWell(
            onTap: () {
              if (grid.active == 0) {
                handleProductQuantity(i);
              }
            },
            child: Container(
              height: MediaQuery.of(context).size.width > 650 ? 200 : 120,
              width: 120,
              margin: const EdgeInsets.all(10),
              foregroundDecoration: int.parse(grid.quantity!) == 0
                  ? BoxDecoration(
                      color: Colors.grey,
                      backgroundBlendMode: BlendMode.color,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    )
                  : const BoxDecoration(),
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  product[i].picture != null
                      ? SizedBox(
                          height: MediaQuery.of(context).size.width > 650
                              ? 140
                              : 70,
                          width: Get.width,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            child: Image.memory(
                              product[i].picture!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.width > 650
                              ? 140
                              : 70,
                          width: Get.width,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            child: Image.asset(
                              "assets/images/Paneer.png",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                  // const SizedBox(
                  //   height: 2,
                  // ),
                  SizedBox(
                    // width: 100.w,
                    child: Text(
                      "${product[i].name!}-${product[i].weight!}${product[i].unit ?? ""}",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: MediaQuery.of(context).size.width > 650
                            ? AppDimens.font18
                            : AppDimens.font14,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 2,
                  // ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          // width: 100,
                          child: ObxValue(
                            (v) => Text(
                              product[i].quantity.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.brownColor,
                                fontSize: AppDimens.font12,
                                overflow: TextOverflow.visible,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                            product[i].quantity!.obs,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "₹${product[i].price}/-",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.brownColor,
                              fontSize: AppDimens.font12,
                              overflow: TextOverflow.visible,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
