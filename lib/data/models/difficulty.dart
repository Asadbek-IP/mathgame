import 'package:mathgame/util/constants.dart';

class Difficulty {
  final String title;
  final bool add;
  final bool subtract;
  final bool multiply;
  final bool divide;
  final int max;

  Difficulty({
    required this.title,
    required this.add,
    required this.subtract,
    required this.multiply,
    required this.divide,
    required this.max,
  });

  List<String> getOperations() {
    var operations = <String>[];
    if (add) operations.add(addSign);
    if (subtract) operations.add(subtractSign);
    if (multiply) operations.add(multiplySign);
    if (divide) operations.add(divideSign);
    return operations;
  }
}
