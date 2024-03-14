part of 'game_bloc.dart';

enum PlayState { play, pause, result }

const blankQuestion = Question(0, question: "", answers: []);

abstract class GameState extends Equatable {
  final int life;
  final Question question;
  final int correctCount;
  final int levelNumber;
  final int star;
  final PlayState state;

  const GameState({
    required this.life,
    required this.question,
    required this.correctCount,
    required this.levelNumber,
    required this.star,
    required this.state,
  });

  GameState copyWith({
    int? life,
    Question? question,
    int? correctCount,
    int? levelNumber,
    int? star,
    PlayState? state,
  }) =>
      GameInitial(
        life: life ?? this.life,
        question: question ?? this.question,
        correctCount: correctCount ?? this.correctCount,
        levelNumber: levelNumber ?? this.levelNumber,
        star: star ?? this.star,
        state: state ?? this.state,
      );

  CorrectAnswerState copyCorrectAnswerState({
    int? life,
    Question? question,
    int? correctCount,
    int? levelNumber,
    int? star,
    PlayState? state,
  }) =>
      CorrectAnswerState(
        life: life ?? this.life,
        question: question ?? this.question,
        correctCount: correctCount ?? this.correctCount,
        levelNumber: levelNumber ?? this.levelNumber,
        star: star ?? this.star,
        state: state ?? this.state,
      );

  WrongAnswerState copyWrongAnswerState({
    int? life,
    Question? question,
    int? correctCount,
    int? levelNumber,
    int? star,
    PlayState? state,
  }) =>
      WrongAnswerState(
        life: life ?? this.life,
        question: question ?? this.question,
        correctCount: correctCount ?? this.correctCount,
        levelNumber: levelNumber ?? this.levelNumber,
        star: star ?? this.star,
        state: state ?? this.state,
      );

  NavigateBackState copyNavigateBackState({
    int? life,
    Question? question,
    int? correctCount,
    int? levelNumber,
    int? star,
    PlayState? state,
  }) =>
      NavigateBackState(
        life: life ?? this.life,
        question: question ?? this.question,
        correctCount: correctCount ?? this.correctCount,
        levelNumber: levelNumber ?? this.levelNumber,
        star: star ?? this.star,
        state: state ?? this.state,
      );

  @override
  List<Object> get props => [life, question, correctCount, star, state];
}

class GameInitial extends GameState {
  const GameInitial({
    super.life = lifeCount,
    super.question = blankQuestion,
    super.correctCount = 0,
    required super.levelNumber,
    super.star = 0,
    super.state = PlayState.play,
  });
}

class CorrectAnswerState extends GameState {
  const CorrectAnswerState({
    required super.life,
    required super.question,
    required super.correctCount,
    required super.levelNumber,
    required super.star,
    required super.state,
  });
}

class WrongAnswerState extends GameState {
  const WrongAnswerState({
    required super.life,
    required super.question,
    required super.correctCount,
    required super.levelNumber,
    required super.star,
    required super.state,
  });
}

class GameOverState extends GameState {
  const GameOverState({
    required super.life,
    required super.question,
    required super.correctCount,
    required super.levelNumber,
    required super.star,
    required super.state,
  });
}

class NavigateBackState extends GameState {
  const NavigateBackState({
    required super.life,
    required super.question,
    required super.correctCount,
    required super.levelNumber,
    required super.star,
    required super.state,
  });
}
