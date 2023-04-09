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
  List<Color> optionColors = [
    Colors.red,
    Colors.green,
    Colors.purple,
  ];
  int? selectedOptionIndex;
  Color? aktiveColor;
  // bool isCorrectAnswerSelected = false;
  String buttonName = 'SUBMIT';

  void checkAnswer() {
    if (selectedOptionIndex ==
        questions[currentQuestionIndex].correctAnswerIndex) {
      setState(() {
        aktiveColor = optionColors[1];
        // isCorrectAnswerSelected = true;
        isAnswered = true;
      });
    } else {
      setState(() {
        aktiveColor = optionColors[0];
        // isCorrectAnswerSelected = false;
        isAnswered = true;
      });
    }
    print('Radio gesperrt = $isAnswered');
  }

  // int? _valueType;
  // bool? _correctOption;
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
            ElevatedButton(
              onPressed: () {
                checkAnswer();
              },
              child: Text(
                buttonName,
                style: TextStyle(fontSize: 18),
              ),
            ),
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
