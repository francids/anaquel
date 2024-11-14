import 'package:anaquel/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class AnaquelTheme extends StatelessWidget {
  const AnaquelTheme(this.child, {super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final lightTheme = FThemeData.inherit(
      colorScheme: FThemes.zinc.light.colorScheme.copyWith(
        brightness: Brightness.light,
        primary: AppColors.night,
        primaryForeground: AppColors.white,
        secondary: AppColors.puce,
        secondaryForeground: AppColors.night,
        background: AppColors.white,
        foreground: AppColors.black,
      ),
    ).copyWith(
      headerStyle: FHeaderStyles(
        rootStyle: FRootHeaderStyle(
          titleTextStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          actionStyle: FHeaderActionStyle(
            enabledColor: AppColors.night,
            disabledColor: AppColors.timberwolf,
            size: 24,
          ),
          actionSpacing: 8,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        nestedStyle: FNestedHeaderStyle(
          titleTextStyle: const TextStyle(
            fontSize: 20,
            height: 1,
          ),
          actionStyle: FHeaderActionStyle(
            enabledColor: AppColors.night,
            disabledColor: AppColors.timberwolf,
            size: 24,
          ),
          actionSpacing: 8,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      alertStyles: FAlertStyles(
        primary: FAlertCustomStyle(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.antiFlashWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          iconSize: 24,
          iconColor: AppColors.night,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.eerieBlack,
          ),
          subtitleTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: AppColors.eerieBlack,
          ),
        ),
        destructive: FAlertCustomStyle(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.burgundy,
              width: 1,
            ),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          iconSize: 24,
          iconColor: AppColors.burgundy,
          titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.burgundy,
          ),
          subtitleTextStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: AppColors.burgundy,
          ),
        ),
      ),
      switchStyle: FSwitchStyle(
        focusColor: AppColors.night,
        labelLayoutStyle: const FLabelLayoutStyle(
          labelPadding: EdgeInsets.only(left: 8),
          descriptionPadding: EdgeInsets.only(left: 8),
        ),
        enabledStyle: FSwitchStateStyle(
          checkedColor: AppColors.burgundy,
          uncheckedColor: AppColors.timberwolf,
          thumbColor: AppColors.white,
          labelTextStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppColors.black,
          ),
          descriptionTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.eerieBlack,
          ),
        ),
        disabledStyle: FSwitchStateStyle(
          checkedColor: AppColors.timberwolf,
          uncheckedColor: AppColors.timberwolf,
          thumbColor: AppColors.timberwolf,
          labelTextStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          descriptionTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        errorStyle: FSwitchErrorStyle(
          labelTextStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.burgundy,
          ),
          descriptionTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.burgundy,
          ),
          errorTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.burgundy,
          ),
        ),
      ),
      dividerStyles: FDividerStyles(
        horizontalStyle: FDividerStyle(
          padding: const EdgeInsets.symmetric(vertical: 20),
          color: AppColors.timberwolf.withOpacity(0.5),
        ),
        verticalStyle: FDividerStyle(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: AppColors.timberwolf.withOpacity(0.5),
        ),
      ),
      bottomNavigationBarStyle: FBottomNavigationBarStyle(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        itemStyle: FBottomNavigationBarItemStyle(
          activeIconColor: AppColors.black,
          activeTextStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.black,
          ),
          inactiveIconColor: AppColors.eerieBlack,
          inactiveTextStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColors.eerieBlack,
          ),
          iconSize: 22,
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 8,
          ),
        ),
        decoration: const BoxDecoration(),
      ),
    );

    return FTheme(
      data: lightTheme,
      child: child!,
    );
  }
}

ThemeData anaquelMaterialTheme() {
  return ThemeData(
    colorScheme: const ColorScheme.light(
      primary: AppColors.night,
      secondaryContainer: AppColors.antiFlashWhite,
    ),
  );
}
