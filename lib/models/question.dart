class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

// Contoh data dummy
final dummyQuestions = [
  Question(
    question: "Ibukota Indonesia adalah?",
    options: ["Bandung", "Jakarta", "Surabaya", "Medan"],
    correctAnswerIndex: 1,
  ),
  Question(
    question: "2 + 5 = ...",
    options: ["5", "7", "8", "9"],
    correctAnswerIndex: 1,
  ),
  Question(
    question: "Presiden pertama RI?",
    options: ["Soekarno", "Soeharto", "BJ Habibie", "Megawati"],
    correctAnswerIndex: 0,
  ),
];