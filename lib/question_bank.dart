class Question {
  String question;
  List<String> answers;
  int correctAnswerIndex;

  Question(
      {required this.question,
      required this.answers,
      required this.correctAnswerIndex});
}

final List<Question> questions = [
  Question(
    question: "What is the capital of France?",
    answers: ["New York", "Paris", "Berlin", "London"],
    correctAnswerIndex: 1,
  ),
  Question(
    question: "Für die Zertifizierung durch den iSAQB _____.",
    answers: [
      'kann eine Prüfung online abgelegt werden',
      'genügt ein Nachweis über die Berufserfahrung',
      'wird eine Grundlagenschulung vorausgesetzt',
      'ist die Beschäftigung in einem anerkannten Softwareunternehmen erforderlich'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    question: "Wofür steht die Abkürzung UML?",
    answers: [
      'Universal Methodology Lemma',
      'User Mode Language',
      'Universal Markup Language',
      'Unified Modeling Language'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    question: "Ein Software-Architekt muss sich in erster Linie _____.",
    answers: [
      'mit der Technik beschäftigen',
      'um die Finanzierung kümmern',
      'mit der Ausstattung der Arbeitsplätze befassen',
      'um das Betriebsklima kümmern'
    ],
    correctAnswerIndex: 0,
  ),
  // weitere Fragen hier
];
