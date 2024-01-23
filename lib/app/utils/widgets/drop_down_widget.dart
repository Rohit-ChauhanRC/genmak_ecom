import 'package:flutter/material.dart';
import 'package:genmak_ecom/app/utils/app_colors/app_colors.dart';
import 'package:genmak_ecom/app/utils/app_dimens/app_dimens.dart';

class DropdownFormField<T> extends FormField<T> {
  DropdownFormField({
    super.key,
    required T initialValue,
    required List<DropdownMenuItem<T>> items,
    required FormFieldSetter<T> onSaved,
    FormFieldSetter<T>? onChanged,
    FormFieldValidator<T>? validator,
    String? hintDrop,
    InputDecoration? decoration,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: items.contains(initialValue) ? initialValue : null,
          builder: (FormFieldState<T> field) {
            final InputDecoration effectiveDecoration = decoration ??
                InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.all(10),
                  hintText: hintDrop,
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
                );

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                  hintStyle: const TextStyle(
                    fontSize: 12,
                  ),
                  errorText: field.hasError ? field.errorText : null),
              isEmpty: field.value == '' || field.value == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  value: field.value,
                  isDense: true,
                  onChanged: field.didChange,
                  items: items.toList(),
                ),
              ),
            );
          },
        );
}
