import 'package:flutter/material.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:anaquel/app/app.dart';
import 'package:anaquel/constants/system_ui_config.dart';

void main() {
  ScaledWidgetsFlutterBinding.ensureInitialized();
  configureSystemUI();
  runApp(const AnaquelApp());
}
