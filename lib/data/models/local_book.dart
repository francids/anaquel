class LocalBook {
  final String id;
  final String coverUrl;
  final String title;
  final String author;
  final String description;
  final List<String> genres;

  LocalBook({
    required this.id,
    required this.coverUrl,
    required this.title,
    required this.author,
    required this.description,
    required this.genres,
  });

  factory LocalBook.fromJson(Map<String, dynamic> json) {
    return LocalBook(
      id: json['id'],
      coverUrl: json['coverUrl'],
      title: json['title'],
      author: json['author'],
      description: json['description'],
      genres: List<String>.from(json['genres']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coverUrl': coverUrl,
      'title': title,
      'author': author,
      'description': description,
      'genres': genres,
    };
  }
}
