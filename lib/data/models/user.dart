class User {
  final String username;
  final String email;
  final String name;
  final String password;

  User({
    required this.username,
    required this.email,
    required this.name,
    this.password = "",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      name: json['name'],
      password: json['password'],
    );
  }
}
