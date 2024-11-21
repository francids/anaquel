class LocalBook {
  final String id;
  final String coverUrl;
  final String title;
  final String author;
  final String description;
  final List<String> genres;
  final int status;

  LocalBook({
    required this.id,
    required this.coverUrl,
    required this.title,
    required this.author,
    required this.description,
    required this.genres,
    required this.status,
  });

  factory LocalBook.fromJson(Map<String, dynamic> json) {
    return LocalBook(
      id: json['id'],
      coverUrl: json['coverUrl'],
      title: json['title'],
      author: json['author'],
      description: json['description'],
      genres: List<String>.from(json['genres']),
      status: json['status'],
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
      'status': status,
    };
  }

  LocalBook copyWith({
    String? id,
    String? coverUrl,
    String? title,
    String? author,
    String? description,
    List<String>? genres,
    int? status,
  }) {
    return LocalBook(
      id: id ?? this.id,
      coverUrl: coverUrl ?? this.coverUrl,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      genres: genres ?? this.genres,
      status: status ?? this.status,
    );
  }
}
