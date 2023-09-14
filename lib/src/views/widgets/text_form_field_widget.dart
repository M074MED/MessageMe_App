import 'package:flutter/material.dart';
import 'package:messageme_app/src/views/theme/app_colors.dart';
import 'package:messageme_app/utils/constants.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool isPasswordField;

  const TextFormFieldWidget(
      {super.key, required this.name, required this.controller, this.keyboardType, this.isPasswordField = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
      obscureText: isPasswordField,
        keyboardType: keyboardType,
        textAlign: TextAlign.center,
        controller: controller,
        validator: (value) => value!.isEmpty ? "$name can't be empty" : null,
        decoration: InputDecoration(
          hintText: name,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          border: const OutlineInputBorder(borderRadius: APP_BORDER_RADIUS),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 1,
            ),
            borderRadius: APP_BORDER_RADIUS,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.secondaryColor,
              width: 2,
            ),
            borderRadius: APP_BORDER_RADIUS,
          ),
        ),
      ),
    );
  }
}
