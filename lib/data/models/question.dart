class Question {
  final int id;
  final String question;
  String answer;

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

  Map<String, dynamic> toJson(int bookId) {
    return {
      "question": question,
      "answer": answer,
      "book": bookId,
    };
  }
}
