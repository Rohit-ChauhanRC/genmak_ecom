import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genmak_ecom/app/data/models/product_model.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.picture,
    required this.title,
    this.onTap,
    required this.quantity,
    required this.volume,
    required this.price,
    this.model,
  });
  final Uint8List? picture;
  final String title;
  final String quantity;
  final String price;
  final String volume;
  final void Function()? onTap;
  final ProductModel? model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                      "${quantity != "" ? quantity : 0}",
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
    );
  }
}
