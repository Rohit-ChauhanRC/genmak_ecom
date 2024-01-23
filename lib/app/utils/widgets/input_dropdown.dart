import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';
import 'package:get/get.dart';

class InputDropDown extends StatelessWidget {
  const InputDropDown({
    super.key,
    this.onChanged,
    this.items,
    this.value,
    this.hintText,
  });

  final void Function(String?)? onChanged;
  final List<String>? items;
  final String? value;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.all(10),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: AppDimens.font18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.brownColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.brownColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          items: items!.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
          onChanged: onChanged,
          value: value,
          isDense: true,
        ),
      ),
    );
  }
}
