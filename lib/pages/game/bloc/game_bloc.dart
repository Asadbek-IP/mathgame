import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mathgame/data/models/level.dart';
import 'package:mathgame/data/models/question.dart';
import 'package:mathgame/data/models/world.dart';
import 'package:mathgame/data/repository/game_repository.dart';
import 'package:mathgame/util/constants.dart';

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
  }) : super(GameInitial(levelNumber: level.number));

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is InitialEvent) {
      questions = repository.getQuestionsForWorld(world);
      yield state.copyWith(question: questions[0]);
    } else if (event is AnswerSelectedEvent) {
      final isRight = questions[currentQuestionIndex].isRight(event.answer);
      if (isRight) {
        currentQuestionIndex++;
        if (currentQuestionIndex < questionPerLevel) {
          yield state.copyCorrectAnswerState(
              question: questions[currentQuestionIndex], correctCount: state.correctCount + 1);
        } else {
          int star = starsPerLevel + state.life - lifeCount;
          await _changeLevelStar(star);
          yield state.copyWith(star: star, state: PlayState.result);
        }
      } else {
        if (state.life > 1) {
          yield state.copyWrongAnswerState(life: state.life - 1);
        } else {
          yield state.copyWith(state: PlayState.result, star: 0);
        }
      }
    } else if (event is PlayEvent) {
      yield state.copyWith(state: PlayState.play);
    } else if (event is PauseEvent) {
      yield state.copyWith(state: PlayState.pause, star: 0);
    } else if (event is NextLevelEvent) {
      if (level.id % levelEachWorld != 0) {
        final nextLevel = await repository.getLevelById(level.id + 1);
        if (nextLevel.unlocked) {
          level = nextLevel;
          yield _refresh();
        } else {}
      } else {
        yield state.copyNavigateBackState();
      }
    } else if (event is RetryEvent) {
      level = await repository.getLevelById(level.id);
      yield _refresh();
    }
  }

  Future<void> _changeLevelStar(int star) async {
    if (level.stars <= star) {
      repository.changeLevelStar(level, star);
    }
  }

  GameState _refresh() {
    print(level.toMap(1).toString());
    questions = repository.getQuestionsForWorld(world);
    currentQuestionIndex = 0;
    return GameInitial(question: questions[currentQuestionIndex], levelNumber: level.number);
  }
}
