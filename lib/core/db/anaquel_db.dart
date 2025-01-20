import 'package:anaquel/core/db/database_service.dart';
import 'package:anaquel/data/models/reading.dart';
import 'package:sqflite/sqflite.dart';

class AnaquelDB {
  final tableName = "reading";

  Future createTable(Database db) async {
    await db.execute("""
    CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "date" TEXT NOT NULL,
      "seconds" int NOT NULL,
      "book_id" TEXT NOT NULL,
      "book_type" TEXT NOT NULL,
      PRIMARY KEY ("id" AUTOINCREMENT)
    );""");
  }

  Future<List<Reading>> fetchAll() async {
    final db = await DatabaseService().database;
    final result = await db.query(
      tableName,
      orderBy: "date DESC",
    );
    return result.map((json) => Reading.fromSqfliteDb(json)).toList();
  }

  Future<List<Reading>> fetchByBookId(String bookId) async {
    final db = await DatabaseService().database;
    final result = await db.query(
      tableName,
      where: "book_id = ?",
      whereArgs: [bookId],
      orderBy: "date DESC",
    );
    return result.map((json) => Reading.fromSqfliteDb(json)).toList();
  }

  Future<void> insert(Reading reading) async {
    final db = await DatabaseService().database;
    await db.insert(tableName, reading.toSqfliteDb());
  }
}
