import 'package:get_it/get_it.dart';
import 'package:mathgame/data/database/database_helper.dart';
import 'package:mathgame/data/repository/game_repository.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton(DatabaseHelper.instance);
  sl.registerFactory(() => GameRepository(sl()));
}
