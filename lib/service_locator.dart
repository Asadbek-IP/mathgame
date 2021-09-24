import 'package:get_it/get_it.dart';
import 'package:mathgame/data/database/database_helper.dart';
import 'package:mathgame/data/repository/game_repository.dart';
import 'package:mathgame/pages/worlds/bloc/worlds_bloc.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton(DatabaseHelper.instance);
  sl.registerFactory(() => GameRepository(sl()));
  sl.registerFactory(() => WorldsBloc(sl()));
}
