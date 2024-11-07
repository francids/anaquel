import 'dart:io';

class Config {
  static String get baseUrl {
    return Platform.environment["ANAQUEL_BACKEND_URL"] ??
        "http://10.0.0.77:8080";
  }

  static String get baseIntelligenceUrl {
    return Platform.environment["ANAQUEL_INTELLIGENCE_URL"] ??
        "http://10.0.0.77:3600";
  }
}
