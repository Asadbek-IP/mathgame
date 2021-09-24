import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mathgame/data/models/world.dart';
import 'package:mathgame/data/repository/game_repository.dart';

part 'worlds_event.dart';
part 'worlds_state.dart';

class WorldsBloc extends Bloc<WorldsEvent, WorldsState> {
  final GameRepository repository;

  WorldsBloc(this.repository) : super(const WorldsState(worlds: [])) {
    repository.changeStream().listen((_) {
      add(_UpdateEvent(_));
    });
  }

  late int difficultyId;

  @override
  Stream<WorldsState> mapEventToState(
    WorldsEvent event,
  ) async* {
    if (event is InitialWorldsEvent) {
      difficultyId = event.difficultyId;
      List<World> worlds = await repository.getWorldsByDifficulty(difficultyId);
      yield WorldsState(worlds: worlds);
    } else if (event is _UpdateEvent) {
      List<World> worlds = await repository.getWorldsByDifficulty(difficultyId);
      yield WorldsState(worlds: worlds);
    }
  }
}

class _UpdateEvent extends WorldsEvent {
  final int update;

  const _UpdateEvent(this.update);

  @override
  List<Object> get props => [update];
}
