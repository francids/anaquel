class Collection {
  final int id;
  final String name;
  final String color;

  Collection({
    required this.id,
    required this.name,
    required this.color,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'],
      name: json['name'],
      color: json['color'],
    );
  }
}
