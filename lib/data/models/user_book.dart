import 'package:anaquel/data/models/book.dart';

enum UserBookStatus {
  notRead,
  reading,
  read,
}

class UserBook extends Book {
  final UserBookStatus status;
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
      status: UserBookStatus.values.firstWhere(
        (e) =>
            e.toString().toLowerCase() ==
            json['status'].toString().toLowerCase().replaceAll(' ', ''),
        orElse: () => UserBookStatus.notRead,
      ),
      rating: json['rating'] ?? 0.0,
    );
  }
}
