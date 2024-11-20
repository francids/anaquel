import 'package:anaquel/data/models/book.dart';

class Collection {
  final int id;
  final String name;
  final String color;
  List<Book> books;

  Collection({
    required this.id,
    required this.name,
    required this.color,
    this.books = const [],
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'],
      name: json['name'],
      color: json['color'],
    );
  }
}
