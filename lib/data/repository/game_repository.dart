import 'package:mathgame/data/database/database_helper.dart';
import 'package:mathgame/data/models/difficulty.dart';
import 'package:mathgame/data/models/level.dart';
import 'package:mathgame/data/models/question.dart';
import 'package:mathgame/data/models/world.dart';
import 'package:mathgame/util/constants.dart';

class GameRepository {
  final DatabaseHelper dbHelper;

  GameRepository(this.dbHelper);

  Stream<int> changeStream() => dbHelper.changeStream;

  Future<List<Difficulty>> getAllDifficulties() => dbHelper.getAllDifficulties();

  Future<List<World>> getWorldsByDifficulty(int difficultyId) =>
      dbHelper.getWorldsByDifficulty(difficultyId);

  Future<World> getWorldById(int worldId) => dbHelper.getWorldById(worldId);

  Future<List<Level>> getLevelsByWorld(World world) => dbHelper.getLevelsByWorld(world);

  List<Question> getQuestionsForWorld(World world, {int count = questionPerLevel}) {
    return List.generate(count, (_) => Question.generateQuestion(world));
  }
}
