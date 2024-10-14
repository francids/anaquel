import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class AFTheme extends StatelessWidget {
  const AFTheme({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return FTheme(
      data: FThemes.zinc.light,
      child: child!,
    );
  }
}
