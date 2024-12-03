class Schedule {
  final int id;
  final String label;
  final String time;
  final List<String> days;

  Schedule({
    required this.id,
    required this.label,
    required this.time,
    required this.days,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json["id"],
      label: json["label"],
      time: json["time"],
      days: List<String>.from(json["days"]),
    );
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
