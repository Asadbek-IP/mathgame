part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends GameEvent {}

class AnswerSelectedEvent extends GameEvent {
  final int answer;

  const AnswerSelectedEvent(this.answer);

  @override
  List<Object> get props => [answer];
}

class PlayEvent extends GameEvent {}

class PauseEvent extends GameEvent {}

class NextLevelEvent extends GameEvent {}

class RetryEvent extends GameEvent {}
