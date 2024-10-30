class Book {
  final int id;
  final String title;
  final String description;
  final String coverUrl;
  final String isbn;
  final List<String> genres;
  final List<String> authors;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.coverUrl,
    required this.isbn,
    this.genres = const [],
    this.authors = const [],
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      coverUrl: json['coverUrl'],
      isbn: json['isbn'],
      genres: List<String>.from(json['genres']),
      authors: List<String>.from(json['authors']),
    );
  }
}
