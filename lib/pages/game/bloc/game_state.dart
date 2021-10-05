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
    life = lifeCount,
    question = blankQuestion,
    correctCount = 0,
    required int levelNumber,
    star = 0,
    state = PlayState.play,
  }) : super(
            life: life,
            question: question,
            correctCount: correctCount,
            levelNumber: levelNumber,
            star: star,
            state: state);
}

class CorrectAnswerState extends GameState {
  const CorrectAnswerState({
    required int life,
    required Question question,
    required int correctCount,
    required int levelNumber,
    required int star,
    required PlayState state,
  }) : super(
            life: life,
            question: question,
            correctCount: correctCount,
            levelNumber: levelNumber,
            star: star,
            state: state);
}

class WrongAnswerState extends GameState {
  const WrongAnswerState({
    required int life,
    required Question question,
    required int correctCount,
    required int levelNumber,
    required int star,
    required PlayState state,
  }) : super(
            life: life,
            question: question,
            correctCount: correctCount,
            levelNumber: levelNumber,
            star: star,
            state: state);
}

class GameOverState extends GameState {
  const GameOverState({
    required int life,
    required Question question,
    required int correctCount,
    required int levelNumber,
    required int star,
    required PlayState state,
  }) : super(
            life: life,
            question: question,
            correctCount: correctCount,
            levelNumber: levelNumber,
            star: star,
            state: state);
}

class NavigateBackState extends GameState {
  const NavigateBackState({
    required int life,
    required Question question,
    required int correctCount,
    required int levelNumber,
    required int star,
    required PlayState state,
  }) : super(
            life: life,
            question: question,
            correctCount: correctCount,
            levelNumber: levelNumber,
            star: star,
            state: state);
}
