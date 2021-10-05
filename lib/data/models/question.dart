import 'dart:math';

import 'package:mathgame/data/models/world.dart';
import 'package:mathgame/util/constants.dart';

class Question {
  final String question;
  final List<int> answers;
  final int _rightAnswer;

  const Question(
    this._rightAnswer, {
    required this.question,
    required this.answers,
  });

  @override
  String toString() {
    return {"question": question, "answers": answers}.toString();
  }

  factory Question.generateQuestion(World world) {
    var answers = <int>[];
    var answer = 0;
    var random = Random();
    var max = world.max;
    var operations = world.allowedOperations;
    var operation = operations[random.nextInt(operations.length)];
    var first = random.nextInt(max);
    var second = 0;
    switch (operation) {
      case addSign:
        second = random.nextInt(max);
        answer = first + second;
        break;
      case subtractSign:
        first += random.nextInt(max ~/ 2) + (max ~/ 2);
        second = random.nextInt(first);
        answer = first - second;
        break;
      case multiplySign:
        if (first == 0) {
          first = random.nextInt(max - 1) + 1;
        }
        second = (random.nextInt(max * 5) / first).round();
        if (second > max) {
          second = random.nextInt(max);
        }
        answer = first * second;
        break;
      case divideSign:
        if (first == 0) {
          first = random.nextInt(max - 1) + 1;
        }
        second = first;
        answer = (random.nextInt(max * 2) / first).round();
        first = second * answer;
        break;
    }
    answers.add(answer);
    max = operation == multiplySign
        ? max * 5
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
