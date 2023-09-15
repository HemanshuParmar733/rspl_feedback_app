import "package:feedback_app/core/enums/font_family_enum.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "app_colors.dart";

ThemeData customLightTheme() {
  TextTheme _customLightThemesTextTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontFamily: AppFontFamily.Roboto.name,
        fontSize: 22.0,
        color: AppColors.navyBlueColor,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontSize: 15.0,
        color: AppColors.navyBlueColor,
      ),
      headlineMedium: base.displayLarge?.copyWith(
        fontSize: 24.0,
        color: AppColors.greyolor,
      ),
      displaySmall: base.displayLarge?.copyWith(
        fontSize: 22.0,
        color: AppColors.greyolor,
      ),
      bodySmall: base.bodySmall?.copyWith(
        color: const Color(0xFFCCC5AF),
      ),
      bodyMedium: base.bodyMedium?.copyWith(color: const Color(0xFF807A6B)),
      bodyLarge: base.bodyLarge?.copyWith(color: Colors.brown),
    );
  }

  final ThemeData lightTheme = ThemeData.light();
  return lightTheme.copyWith(
    useMaterial3: true,
    textTheme: _customLightThemesTextTheme(lightTheme.textTheme),
    primaryColor: AppColors.navyBlueColor,
    indicatorColor: AppColors.darkBlueColor,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    primaryIconTheme: lightTheme.primaryIconTheme.copyWith(
      color: Colors.white,
      size: 20,
    ),
    iconTheme: lightTheme.iconTheme.copyWith(
      color: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.greyolor),
      color: AppColors.navyBlueColor,
      foregroundColor: AppColors.navyBlueColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.navyBlueColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
    tabBarTheme: lightTheme.tabBarTheme.copyWith(
      labelColor: AppColors.darkBlueColor,
      unselectedLabelColor: Colors.grey,
    ),
    buttonTheme:
        lightTheme.buttonTheme.copyWith(buttonColor: AppColors.navyBlueColor),
    cardColor: AppColors.greyolor,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: AppColors.greyolor),
  );
}

ThemeData customDarkTheme() {
  final ThemeData darkTheme = ThemeData.dark();
  return darkTheme.copyWith(
      useMaterial3: true,
      indicatorColor: const Color(0xFF807A6B),
      hintColor: const Color(0xFFFFF8E1),
      primaryIconTheme: darkTheme.primaryIconTheme.copyWith(
        color: AppColors.lightBlueColor,
        size: 20,
      ),
      primaryColor: Colors.blue,
      primaryColorDark: Colors.blue.shade900,
      primaryColorLight: Colors.blue.shade50,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
        accentColor: Colors.blue.shade900,
        brightness: Brightness.dark,
      ),
      cardColor: AppColors.lightBlueColor,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ));
}
