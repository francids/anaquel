class Reading {
  final int id;
  final String date;
  final int seconds;
  final String bookId;
  final String bookType;

  Reading({
    required this.id,
    required this.date,
    required this.seconds,
    required this.bookId,
    required this.bookType,
  });

  factory Reading.fromSqfliteDb(Map<String, dynamic> json) => Reading(
        id: json["id"] ?? 0,
        date: json["date"],
        seconds: json["seconds"],
        bookId: json["book_id"],
        bookType: json["book_type"],
      );

  Map<String, Object?> toSqfliteDb() {
    return {
      "date": date,
      "seconds": seconds,
      "book_id": bookId,
      "book_type": bookType,
    };
  }
}
