import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mathgame/data/models/level.dart';
import 'package:mathgame/data/models/world.dart';
import 'package:mathgame/data/repository/game_repository.dart';
import 'package:mathgame/util/constants.dart';

part 'levels_event.dart';
part 'levels_state.dart';

class LevelsBloc extends Bloc<LevelsEvent, LevelsState> {
  final GameRepository repository;
  final World world;
  final PageController pageController;

  LevelsBloc(this.repository, {required this.world, required this.pageController})
      : super(LevelsInitial(controller: pageController)) {
    repository.changeStream().listen((event) {
      add(_UpdateEvent());
    });
    pageController.addListener(() {
      var page = (pageController.page ?? 0) + 0.5;
      if (page != state.page) {
        add(_PageChangedEvent(page.toInt()));
      }
    });
  }

  @override
  Stream<LevelsState> mapEventToState(
    LevelsEvent event,
  ) async* {
    if (event is InitialEvent) {
      final levels = await _getLevels();
      yield LevelsInitial(
        stars: world.stars,
        maxStars: levelEachWorld * starsPerLevel,
        levels: levels,
        controller: state.controller,
      );
    } else if (event is _UpdateEvent) {
      final world = await _getWorld();
      final levels = await _getLevels();
      yield state.copyWith(stars: world.stars, levels: levels);
    } else if (event is _PageChangedEvent) {
      yield state.copyWith(page: event.newPage);
    }
  }

  Future<World> _getWorld() async {
    return await repository.getWorldById(world.id);
  }

  Future<List<Level>> _getLevels() async {
    return await repository.getLevelsByWorld(world);
  }
}

class _UpdateEvent extends LevelsEvent {}

class _PageChangedEvent extends LevelsEvent {
  final int newPage;

  const _PageChangedEvent(this.newPage);
}
