import 'package:mathgame/data/models/question.dart';
import 'package:mathgame/data/models/world.dart';
import 'package:mathgame/util/constants.dart';

void main() {
  final world = World(
      id: 1,
      difficulty: 1,
      image: "",
      unlocked: true,
      stars: 0,
      allowedOperations: [multiplySign, divideSign],
      min: 0,
      max: 10);
  for (int i = 0; i < 100; i++) {
    final question = Question.generateQuestion(world);
    print(question.toString());
  }
}
