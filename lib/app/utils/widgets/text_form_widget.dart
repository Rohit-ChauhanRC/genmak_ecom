import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    super.key,
    this.onChanged,
    this.label,
    this.keyboardType,
    this.readOnly = false,
    this.initialValue,
    this.validator,
    this.textController,
  });

  final void Function(String)? onChanged;
  final String? label;
  final TextInputType? keyboardType;
  final bool readOnly;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 80,
      child: TextFormField(
        controller: textController,
        validator: validator,
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.always,
        onChanged: onChanged,
        inputFormatters: [
          if (keyboardType == TextInputType.number ||
              keyboardType == TextInputType.phone)
            FilteringTextInputFormatter.digitsOnly,
        ],
        readOnly: readOnly,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
            // label: Text(label!),
            ),
      ),
    );
  }
}
