class Question {
  final int id;
  final String question;
  final String answer;

  Question({
    this.id = 0,
    required this.question,
    this.answer = "",
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] ?? 0,
      question: json['question'],
      answer: json['answer'] ?? "",
    );
  }
}
