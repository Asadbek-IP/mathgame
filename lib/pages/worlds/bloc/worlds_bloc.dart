import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mathgame/data/models/world.dart';
import 'package:mathgame/data/repository/game_repository.dart';

part 'worlds_event.dart';
part 'worlds_state.dart';

class WorldsBloc extends Bloc<WorldsEvent, WorldsState> {
  final GameRepository repository;

  late int difficultyId;

  WorldsBloc(this.repository) : super(const WorldsState(worlds: [])) {
    repository.changeStream().listen((_) {
      add(_UpdateEvent(_));
    });

    on<InitialWorldsEvent>((event, emit) async {
      difficultyId = event.difficultyId;
      final worlds = await repository.getWorldsByDifficulty(difficultyId);
      emit(WorldsState(worlds: worlds));
    });

    on<_UpdateEvent>((event, emit) async {
      final worlds = await repository.getWorldsByDifficulty(difficultyId);
      emit(WorldsState(worlds: worlds));
    });
  }
}

class _UpdateEvent extends WorldsEvent {
  final int update;

  const _UpdateEvent(this.update);

  @override
  List<Object> get props => [update];
}
