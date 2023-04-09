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
    Colors.grey,
    Colors.amber,
    Colors.red,
    Colors.green
  ];
  int? selectedOptionIndex;
  Color? aktiveColor;
  void checkAnswer() {
    if (selectedOptionIndex == null) {
      return; // Stop if no option is selected
    }
    if (selectedOptionIndex ==
        questions[currentQuestionIndex].correctAnswerIndex) {
      aktiveColor = Colors.green;
    } else {
      aktiveColor = Colors.red;
    }
    print('selectedOptionIndex = $selectedOptionIndex');
    setState(() {
      isAnswered = true;
    });
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
                    onChanged: (val) => setState(() {
                      selectedOptionIndex = val as int?;
                    }),
                    activeColor: selectedOptionIndex ==
                            questions[currentQuestionIndex].correctAnswerIndex
                        ? Colors.green
                        : Colors.red,
                    secondary: isAnswered
                        ? Icon(
                            index ==
                                    questions[currentQuestionIndex]
                                        .correctAnswerIndex
                                ? Icons.check
                                : Icons.close,
                            color: index ==
                                    questions[currentQuestionIndex]
                                        .correctAnswerIndex
                                ? Colors.green
                                : Colors.red,
                          )
                        : null,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                checkAnswer();
              },
              child: const Text(
                "Submit",
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
