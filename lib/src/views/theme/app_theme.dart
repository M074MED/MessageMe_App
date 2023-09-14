import 'package:flutter/material.dart';
import 'package:messageme_app/utils/constants.dart';

import 'app_colors.dart';

class AppTheme {
  static final appTheme = ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
      ),
      primaryColor: AppColors.primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
      ),
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.primaryColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.secondaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: AppColors.primaryColor),
          iconColor: AppColors.secondaryColor,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor),
            borderRadius: APP_BORDER_RADIUS,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
            borderRadius: APP_BORDER_RADIUS,
          )));
}
