import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Config {
  static String get baseUrl {
    String? base = dotenv.env["ANAQUEL_BACKEND_URL"];
    base ??=
        (Platform.isAndroid) ? "http://10.0.2.2:8080" : "http://localhost:8080";
    return base;
  }

  static String get baseIntelligenceUrl {
    String? base = dotenv.env["ANAQUEL_INTELLIGENCE_URL"];
    base ??=
        (Platform.isAndroid) ? "http://10.0.2.2:3600" : "http://localhost:3600";
    return base;
  }
}
