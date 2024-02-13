import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/data/models/vendor_model.dart';
import 'package:genmak_ecom/app/routes/app_pages.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:get/get.dart';

class VendorListItem extends StatelessWidget {
  const VendorListItem({super.key, required this.vendorModel});
  final VendorModel vendorModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.EDIT_VENDOR, arguments: vendorModel.id);
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
                        vendorModel.name ?? "",
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
                        "Mobile No.:",
                        style: TextStyle(
                          fontSize: AppDimens.font22,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        vendorModel.mobileNo.toString() ?? "",
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
                        "GSTIN No.",
                        style: TextStyle(
                          fontSize: AppDimens.font22,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        "₹${vendorModel.gst}" ?? "",
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
                        "Address",
                        style: TextStyle(
                          fontSize: AppDimens.font22,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        vendorModel.address.toString() ?? "",
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
