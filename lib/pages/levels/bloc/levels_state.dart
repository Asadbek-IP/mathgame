part of 'levels_bloc.dart';

abstract class LevelsState extends Equatable {
  final int stars;
  final int maxStars;
  final List<Level> levels;
  final PageController controller;
  final int page;

  const LevelsState({
    required this.stars,
    required this.maxStars,
    required this.levels,
    required this.controller,
    required this.page,
  });

  @override
  List<Object> get props => [stars, maxStars, levels, controller, page];

  LevelsState copyWith({
    int? stars,
    int? maxStars,
    List<Level>? levels,
    int? page,
  }) =>
      LevelsInitial(
        stars: stars ?? this.stars,
        maxStars: maxStars ?? this.maxStars,
        levels: levels ?? this.levels,
        controller: controller,
        page: page ?? this.page,
      );
}

class LevelsInitial extends LevelsState {
  LevelsInitial({
    int? stars,
    int? maxStars,
    List<Level>? levels,
    required PageController controller,
    int? page,
  }) : super(
          stars: stars ?? 0,
          maxStars: maxStars ?? 0,
          levels: levels ?? <Level>[],
          controller: controller,
          page: page ?? 0,
        );
}
