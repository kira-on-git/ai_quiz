import 'package:flutter/material.dart';

import 'question_bank.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  List<int?> selectedAnswerIndexes =
      List.generate(questions.length, (_) => null);

  void submitAnswer() {
    int? selectedAnswerIndex = selectedAnswerIndexes[currentQuestionIndex];
    if (selectedAnswerIndex != null) {
      if (selectedAnswerIndex ==
          questions[currentQuestionIndex].correctAnswerIndex) {
        score += 10;
      } else {
        score -= 5;
      }
    }
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
    }
  }

  void showScore() {
    int numCorrectAnswers = 0;
    int numIncorrectAnswers = 0;
    for (int i = 0; i < questions.length; i++) {
      int? selectedAnswerIndex = selectedAnswerIndexes[i];
      if (selectedAnswerIndex != null) {
        if (selectedAnswerIndex == questions[i].correctAnswerIndex) {
          numCorrectAnswers++;
        } else {
          numIncorrectAnswers++;
        }
      }
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Score"),
        content: Text(
            "You answered $numCorrectAnswers questions correctly and $numIncorrectAnswers questions incorrectly. Your score is $score."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = questions[currentQuestionIndex];

    List<Widget> answerButtons = [];
    for (int i = 0; i < currentQuestion.answers.length; i++) {
      answerButtons.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedAnswerIndexes[currentQuestionIndex] = i;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                selectedAnswerIndexes[currentQuestionIndex] == i
                    ? i == currentQuestion.correctAnswerIndex
                        ? Colors.green
                        : Colors.red
                    : Colors.blue,
              ),
            ),
            child: Text(currentQuestion.answers[i]),
          ),
        ),
      );
    }
/*** QUIZ BODY ***/
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /*** QUESTION ***/
            Text(
              "Question ${currentQuestionIndex + 1}/${questions.length}: ${currentQuestion.question}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            /*** ANSWERS ***/
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: answerButtons,
            ),
            ElevatedButton(
              onPressed: submitAnswer,
              child: Text("Submit"),
            ),
            currentQuestionIndex == questions.length - 1
                ? ElevatedButton(
                    onPressed: showScore,
                    child: Text("Score"),
                  )
                : ElevatedButton(
                    onPressed: goToNextQuestion,
                    child: Text("Next"),
                  ),
          ],
        ),
      ),
    );
  }
}
