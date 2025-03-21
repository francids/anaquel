import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Config {
  static String get baseUrl => "http://localhost";
  static String get baseIntelligenceUrl => "http://localhost";
  static String get APPWRITE_ENDPOINT => dotenv.env["APPWRITE_ENDPOINT"]!;
  static String get APPWRITE_PROJECT => dotenv.env["APPWRITE_PROJECT"]!;
}
