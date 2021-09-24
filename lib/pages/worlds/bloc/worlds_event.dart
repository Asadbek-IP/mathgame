part of 'worlds_bloc.dart';

abstract class WorldsEvent extends Equatable {
  const WorldsEvent();

  @override
  List<Object> get props => [];
}

class InitialWorldsEvent extends WorldsEvent {
  final int difficultyId;

  const InitialWorldsEvent(this.difficultyId);

  @override
  List<Object> get props => [difficultyId];
}
