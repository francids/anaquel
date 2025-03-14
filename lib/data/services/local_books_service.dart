import 'dart:convert';

import 'package:anaquel/data/models/local_book.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalBooksService {
  static const String _booksKey = 'local_books';

  Future<void> addBook(LocalBook book) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? booksJson = prefs.getStringList(_booksKey) ?? [];

    booksJson.add(jsonEncode(book.toJson()));

    await prefs.setStringList(_booksKey, booksJson);
  }

  Future<List<LocalBook>> getBooks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? booksJson = prefs.getStringList(_booksKey) ?? [];

    return booksJson
        .map((bookJson) => LocalBook.fromJson(jsonDecode(bookJson)))
        .toList();
  }

  Future<void> updateBook(LocalBook book) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? booksJson = prefs.getStringList(_booksKey) ?? [];

    booksJson.removeWhere((bookJson) {
      final existingBook = LocalBook.fromJson(jsonDecode(bookJson));
      return existingBook.id == book.id;
    });

    booksJson.add(jsonEncode(book.toJson()));

    await prefs.setStringList(_booksKey, booksJson);
  }

  Future<void> removeBook(LocalBook book) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? booksJson = prefs.getStringList(_booksKey) ?? [];

    booksJson.removeWhere((bookJson) {
      final existingBook = LocalBook.fromJson(jsonDecode(bookJson));
      return existingBook.id == book.id;
    });

    await prefs.setStringList(_booksKey, booksJson);
  }
}
