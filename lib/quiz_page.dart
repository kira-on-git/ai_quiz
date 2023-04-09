// ignore_for_file: avoid_print

import 'question_bank.dart';

import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool isAnswered = false;
  int currentQuestionIndex = 0;
  int score = 0;
  List<Color> optionColors = [
    Colors.red,
    Colors.green,
    Colors.purple,
  ];
  int? selectedOptionIndex;
  Color? aktiveColor;
  // bool isCorrectAnswerSelected = false;
  // String buttonName = 'SUBMIT';

  void checkAnswer() {
    setState(() {
      if (selectedOptionIndex ==
          questions[currentQuestionIndex].correctAnswerIndex) {
        aktiveColor = optionColors[1];
        score += 25;
      } else {
        aktiveColor = optionColors[0];
        score -= 5;
      }
      isAnswered = !isAnswered;
    });

    // isAnswered ? buttonName = "NEXT" : buttonName = "SUBMIT";

    print('isAnswered = $isAnswered');
  }

  void goToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedOptionIndex = null;
        isAnswered = false;
        aktiveColor = null; // Rücksetzung der aktiven Farbe
      }
    });
    print('currentQuestionIndex = $currentQuestionIndex');
  }
// void showScore() {
//     int numCorrectAnswers = 0;
//     int numIncorrectAnswers = 0;
//     for (int i = 0; i < questions.length; i++) {
//       int? selectedAnswerIndex = selectedAnswerIndexes[i];
//       if (selectedAnswerIndex != null) {
//         if (selectedAnswerIndex == questions[i].correctAnswerIndex) {
//           numCorrectAnswers++;
//         } else {
//           numIncorrectAnswers++;
//         }
//       }
//     }

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Score"),
//         content: Text("You answered $numCorrectAnswers questions correctly and $numIncorrectAnswers questions incorrectly. Your score is $score."),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Question ${currentQuestionIndex + 1} of ${questions.length}",
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 16),
            Text(
              questions[currentQuestionIndex].question,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: questions[currentQuestionIndex].answers.length,
                itemBuilder: (BuildContext context, int index) {
                  /*** RADIO ***/
                  return RadioListTile(
                      title: Text(
                        questions[currentQuestionIndex].answers[index],
                        style: const TextStyle(fontSize: 18),
                      ),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: index,
                      //tileColor: Colors.amber,
                      //selectedTileColor: Colors.deepOrange,
                      groupValue: selectedOptionIndex,
                      onChanged: (val) {
                        isAnswered
                            ? null
                            : setState(() {
                                selectedOptionIndex = val;
                                print(
                                    'selectedOptionIndex = $selectedOptionIndex');
                              });
                      },
                      activeColor: aktiveColor);
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    checkAnswer();
                  },
                  child: const Text(
                    "SUBMIT",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    goToNextQuestion();
                  },
                  child: const Text(
                    'NEXT',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ScorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int score = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text("Score"),
      ),
      body: Center(
        child: Text(
          "You scored $score points!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
