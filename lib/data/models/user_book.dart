import 'package:anaquel/data/models/book.dart';

class UserBook extends Book {
  final String status;
  final double rating;

  UserBook({
    required super.id,
    required super.title,
    required super.description,
    required super.coverUrl,
    required super.isbn,
    required super.genres,
    required super.authors,
    required this.status,
    required this.rating,
  });

  factory UserBook.fromJson(Map<String, dynamic> json) {
    return UserBook(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      coverUrl: json['coverUrl'],
      isbn: json['isbn'],
      genres: List<String>.from(json['genres']),
      authors: List<String>.from(json['authors']),
      status: json['status'],
      rating: json['rating'],
    );
  }
}
