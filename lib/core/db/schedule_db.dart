import 'package:anaquel/core/db/database_service.dart';
import 'package:anaquel/data/models/schedule.dart';
import 'package:sqflite/sqflite.dart';

class ScheduleDB {
  final tableName = "schedules";

  Future createTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        "id" INTEGER NOT NULL,
        "label" TEXT NOT NULL,
        "time" TEXT NOT NULL,
        "days" TEXT NOT NULL,
        "active" INTEGER NOT NULL DEFAULT 1,
        PRIMARY KEY ("id" AUTOINCREMENT)
      )
    ''');
  }

  Future<List<Schedule>> fetchAll() async {
    final db = await DatabaseService().database;
    final result = await db.query(tableName);
    return result.map((json) => Schedule.fromSqfliteDb(json)).toList();
  }

  Future<int> insert(Schedule schedule) async {
    final db = await DatabaseService().database;
    return await db.insert(tableName, schedule.toSqfliteDb());
  }

  Future<int> update(Schedule schedule) async {
    final db = await DatabaseService().database;
    return await db.update(
      tableName,
      schedule.toSqfliteDb(),
      where: 'id = ?',
      whereArgs: [schedule.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseService().database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
