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
    final max1 = max ~/ (sqrt(max) / 2);
    switch (operation) {
      case addSign:
        second = random.nextInt(max);
        answer = first + second;
        break;
      case subtractSign:
        first = random.nextInt(max ~/ 2) + (max ~/ 2);
        second = random.nextInt(first);
        answer = first - second;
        break;
      case multiplySign:
        first = random.nextInt(max1 - 1) + 1;
        second = random.nextInt(max1 - 1) + 1;
        answer = first * second;
        break;
      case divideSign:
        second = random.nextInt(max1 - 1) + 1;
        first = random.nextInt(max);
        answer = first ~/ second;
        first = second * answer;
        break;
    }
    answers.add(answer);
    max = operation == multiplySign
        ? max1 * max1
        : operation == addSign
            ? max * 2
            : operation == divideSign
                ? max1
                : max;
    final minAnswer = answer ~/ 2;
    var maxAnswer = answer * 3 ~/ 2;
    if (maxAnswer - minAnswer < 5) {
      maxAnswer += 5;
    }
    for (int i = 0; i < 3; i++) {
      var x = 0;
      do {
        x = random.nextInt(maxAnswer - minAnswer) + minAnswer;
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
