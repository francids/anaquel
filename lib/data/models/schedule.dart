import 'package:shared_preferences/shared_preferences.dart';

class Schedule {
  late final SharedPreferences prefs;

  final int id;
  final String label;
  final String time;
  final List<String> days;
  bool active = true;

  Schedule({
    required this.id,
    required this.label,
    required this.time,
    required this.days,
  }) : active = true {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    active = prefs.getBool("schedule-$id") ?? true;
  }

  factory Schedule.fromSqfliteDb(Map<String, dynamic> json) {
    return Schedule(
      id: json["id"],
      label: json["label"],
      time: json["time"],
      days: (json["days"] as String).split(','),
    )..active = json["active"] == 1;
  }

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json["id"],
      label: json["label"],
      time: json["time"],
      days: List<String>.from(json["days"]),
    );
  }

  Map<String, dynamic> toSqfliteDb() {
    return {
      "id": id,
      "label": label,
      "time": time,
      "days": days.join(','),
      "active": active ? 1 : 0,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "label": label,
      "time": time,
      "days": days,
    };
  }
}
