import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mathgame/data/models/level.dart';
import 'package:mathgame/data/models/question.dart';
import 'package:mathgame/data/models/world.dart';
import 'package:mathgame/data/repository/game_repository.dart';
import 'package:mathgame/service_locator.dart';
import 'package:mathgame/util/constants.dart';
import 'package:mathgame/util/game_audio_player.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository repository;
  final World world;
  late Level level;

  int currentQuestionIndex = 0;
  late List<Question> questions = [];

  GameBloc(
    this.repository, {
    required this.world,
    required this.level,
  }) : super(GameInitial(levelNumber: level.number)) {
    sl<GameAuidoPlayer>().playMusic();
    on<InitialEvent>((event, emit) {
questions = repository.getQuestionsForWorld(world);
      emit(state.copyWith(question: questions[0]));
    });
    on<AnswerSelectedEvent>((event, emit) async {
final isRight = questions[currentQuestionIndex].isRight(event.answer);
      if (isRight) {
        currentQuestionIndex++;
        if (currentQuestionIndex < questionPerLevel) {
          emit(state.copyCorrectAnswerState(
              question: questions[currentQuestionIndex], correctCount: state.correctCount + 1));
        } else {
          int star = starsPerLevel + state.life - lifeCount;
          await _changeLevelStar(star);
          emit(state.copyWith(star: star, state: PlayState.result));
        }
      } else {
        if (state.life > 1) {
          emit(state.copyWrongAnswerState(life: state.life - 1));
        } else {
          emit(state.copyWith(state: PlayState.result, star: 0));
        }
      }
    });
    on<PlayEvent>((event, emit) {
      emit(state.copyWith(state: PlayState.play));
    });
    on<PauseEvent>((event, emit) {
      emit(state.copyWith(state: PlayState.pause, star: 0));
    });
    on<NextLevelEvent>((event, emit) async {
      if (level.id % levelEachWorld != 0) {
        final nextLevel = await repository.getLevelById(level.id + 1);
        if (nextLevel.unlocked) {
          level = nextLevel;
          emit(_refresh());
        } else {}
      } else {
        emit(state.copyNavigateBackState());
      }
    });
    on<RetryEvent>((event, emit) async {
      level = await repository.getLevelById(level.id);
      emit(_refresh());
    });
  }

  @override
  Future<void> close() {
    sl<GameAuidoPlayer>().stopMusic();
    return super.close();
  }

  Future<void> _changeLevelStar(int star) async {
    if (level.stars <= star) {
      repository.changeLevelStar(level, star);
    }
  }

  GameState _refresh() {
    questions = repository.getQuestionsForWorld(world);
    currentQuestionIndex = 0;
    return GameInitial(question: questions[currentQuestionIndex], levelNumber: level.number);
  }
}
