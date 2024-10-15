import 'package:anaquel/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class AFTheme extends StatelessWidget {
  const AFTheme({super.key, this.child});

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
      style: const FStyle(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderWidth: 1,
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
      dividerStyles: FDividerStyles(
        horizontal: FDividerStyle(
          padding: const EdgeInsets.symmetric(vertical: 20),
          color: AppColors.timberwolf.withOpacity(0.5),
        ),
        vertical: FDividerStyle(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: AppColors.timberwolf.withOpacity(0.5),
        ),
      ),
      bottomNavigationBarStyle: FBottomNavigationBarStyle(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        item: FBottomNavigationBarItemStyle(
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
