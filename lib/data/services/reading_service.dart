import 'package:anaquel/core/db/anaquel_db.dart';
import 'package:anaquel/data/models/reading.dart';
import 'package:easy_localization/easy_localization.dart';

class ReadingService {
  final AnaquelDB _db = AnaquelDB();

  /// Save reading time spent in seconds
  Future<void> saveReadingTime(String bookId, int seconds) async {
    final reading = Reading(
      id: 0,
      date: DateFormat("YYYYMMDD").format(DateTime.now()),
      seconds: seconds,
      bookId: bookId,
      bookType: "book",
    );
    await _db.insert(reading);
  }

  /// Get reading time spent in seconds by book
  Future<int> getTimeSpentReadingByBook(String bookId) async {
    final readings = await _db.fetchByBookId(bookId);
    return readings.fold<int>(0, (acc, reading) {
      final time = reading.seconds;
      return acc + time;
    });
  }
}
