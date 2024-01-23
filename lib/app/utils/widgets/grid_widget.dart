import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisExtent: 250,
        ),
        itemCount: product.length,
        itemBuilder: (_, i) {
          var grid = product[i];
          return InkWell(
            onTap: () {
              // if (int.tryParse(product[i].quantity!)! >= 1) {
              //   product[i].count = product[i].count! + 1;
              //   product[i].quantity =
              //       (int.tryParse(product[i].quantity.toString())! - 1)
              //           .toString();
              //   print(product[i].quantity);

              //   orders.add(product[i]);
              //   total();
              // }
              handleProductQuantity(i);
            },
            child: Container(
              height: 200,
              width: 120,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.creamColor1,
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
                          height: 140,
                          width: 232,
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
                      : Image.asset(
                          "assets/images/Paneer.png",
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                  // const SizedBox(
                  //   height: 2,
                  // ),
                  SizedBox(
                    // width: 100,
                    child: Text(
                      product[i].name!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: AppDimens.font18,
                        overflow: TextOverflow.visible,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 2,
                  // ),
                  Row(
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
                          "${product[i].weight}",
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
                  Container(
                    // margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "₹${product[i].price}",
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
          );

          // Obx(() =>
          // int.tryParse(product[i].quantity!)! >= 1?
          //     getCard(
          //   picture: grid.picture,
          //   title: grid.name.toString(),
          //   onTap: () {
          //     if (int.tryParse(product[i].quantity!)! >= 1) {
          //       product[i].count = product[i].count! + 1;
          //       product[i].quantity =
          //           (int.tryParse(product[i].quantity.toString())! - 1)
          //               .toString();
          //       print(product[i].quantity);

          //       orders.add(product[i]);
          //       total();
          //     }
          //   },
          //   quantity: product[i].quantity!,
          //   volume: product[i].weight.toString(),
          //   price: product[i].price.toString(),
          //   model: product[i],
          // );
          // : const SizedBox()
          // );
        });
  }

  Widget getCard({
    required Uint8List? picture,
    required String title,
    required String quantity,
    required String price,
    required String volume,
    required void Function()? onTap,
    required ProductModel? model,
  }) {
    return Obx(() => int.tryParse(quantity)! >= 1
        ? InkWell(
            onTap: onTap,
            child: Container(
              height: 200,
              width: 120,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.creamColor1,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  picture != null
                      ? SizedBox(
                          height: 140,
                          width: 190,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            child: Image.memory(
                              picture!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : Image.asset(
                          "assets/images/Paneer.png",
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                  // const SizedBox(
                  //   height: 2,
                  // ),
                  SizedBox(
                    // width: 100,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: AppDimens.font18,
                        overflow: TextOverflow.visible,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 2,
                  // ),
                  Row(
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
                          child: Text(
                            quantity,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.brownColor,
                              fontSize: AppDimens.font12,
                              overflow: TextOverflow.visible,
                            ),
                            overflow: TextOverflow.visible,
                          )),
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
                          "${volume != "" ? volume : 0}",
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
                  Container(
                    // margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "₹$price" ?? "0",
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
          )
        : const SizedBox());
  }
}
