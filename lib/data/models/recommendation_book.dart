class RecommendationBook {
  final int id;
  final String title;
  final String coverUrl;
  final List<String> authors;

  RecommendationBook({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.authors,
  });

  factory RecommendationBook.fromJson(Map<String, dynamic> json) {
    return RecommendationBook(
      id: json["id"],
      title: json["title"],
      coverUrl: json["coverUrl"],
      authors: List<String>.from(json["authors"]),
    );
  }
}
