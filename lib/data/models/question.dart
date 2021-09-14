import 'dart:math';

import 'package:mathgame/data/models/difficulty.dart';
import 'package:mathgame/util/constants.dart';

class Question {
  final String question;
  final List<int> answers;
  final int _rightAnswer;

  Question(
    this._rightAnswer, {
    required this.question,
    required this.answers,
  });

  factory Question.generateQuestion(Difficulty difficulty) {
    var answers = <int>[];
    var answer = 0;
    var random = Random();
    var max = difficulty.max;
    var operations = difficulty.getOperations();
    var operation = operations[random.nextInt(operations.length)];
    var first = random.nextInt(max);
    var second = 0;
    if (operation == divideSign) {
      do {
        second = random.nextInt(max - 1) + 1;
      } while (first % second != 0);
    } else if (operation == subtractSign) {
      do {
        second = random.nextInt(max);
      } while (first <= second);
    } else {
      second = random.nextInt(max);
    }
    switch (operation) {
      case addSign:
        answer = first + second;
        break;
      case subtractSign:
        answer = first - second;
        break;
      case multiplySign:
        answer = first * second;
        break;
      case divideSign:
        answer = first ~/ second;
        break;
    }
    answers.add(answer);
    max = operation == multiplySign
        ? max * max
        : operation == addSign
            ? max * 2
            : max;
    for (int i = 0; i < 3; i++) {
      var x = 0;
      do {
        x = random.nextInt(max);
      } while (answers.contains(x));
      answers.add(x);
    }
    answers.shuffle(random);
    return Question(answer, question: "$first$operation$second=", answers: answers);
  }

  bool isRight(int answer) {
    return answer == _rightAnswer;
  }
}
