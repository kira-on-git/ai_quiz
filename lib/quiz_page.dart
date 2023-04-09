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
  Color? optionColor;
//цвет правильного индекса green
//и цвет выбранного индекса, если он совпадает с правильным - green,
// если не совпадает - red,
// в остальных случаях - amber
  // void checkAnswer() {
  //   print('isAnswered = $isAnswered');
  //   isAnswered = true;
  //   optionColor =
  //       _valueType == questions[currentQuestionIndex].correctAnswerIndex
  //           ? Colors.green
  //           : Colors.red;
  // }

  int? _valueType;
  bool? _correctOption;
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
                      groupValue: _valueType,
                      onChanged: (val) => setState(() {
                            _valueType = val!;
                            //val! as int;
                            _valueType ==
                                    questions[currentQuestionIndex]
                                        .correctAnswerIndex
                                ? _correctOption = true
                                : _correctOption = false;
                            print(_valueType);
                            print(_correctOption);
                          }),
                      activeColor: index ==
                              questions[currentQuestionIndex].correctAnswerIndex
                          ? Colors.green
                          : Colors.red);
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                isAnswered = true;
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
