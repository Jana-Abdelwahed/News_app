import 'package:flutter/material.dart';
import 'package:news/core/utils/app_colors.dart';
import 'package:news/core/utils/app_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white_color,
      centerTitle: true,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: AppColors.black_color),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.white_color,
    ),
    scaffoldBackgroundColor: AppColors.white_color,
    drawerTheme: DrawerThemeData(backgroundColor: AppColors.black_color),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.black_color,
        foregroundColor: AppColors.white_color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),

    textTheme: TextTheme(
      labelLarge: AppStyles.medium14Black,
      labelMedium: AppStyles.medium16Black,
      labelSmall: AppStyles.bold16Black,
      headlineLarge: AppStyles.medium24Black,
      headlineMedium: AppStyles.medium24White,
      headlineSmall: AppStyles.medium20Black,
      displaySmall: AppStyles.medium16Black,
      displayMedium: AppStyles.medium14White,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black_color,
      centerTitle: true,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: AppColors.white_color),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.black_color,
    ),
    scaffoldBackgroundColor: AppColors.black_color,
    drawerTheme: DrawerThemeData(backgroundColor: AppColors.black_color),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white_color,
        foregroundColor: AppColors.black_color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),

    textTheme: TextTheme(
      labelLarge: AppStyles.medium14White,
      labelMedium: AppStyles.medium16White,
      labelSmall: AppStyles.bold16White,
      headlineLarge: AppStyles.medium24White,
      headlineMedium: AppStyles.medium24Black,
      headlineSmall: AppStyles.medium20White,
      displaySmall: AppStyles.medium16White,
      displayMedium: AppStyles.medium14Black,
    ),
  );
}
