part of 'levels_bloc.dart';

abstract class LevelsEvent extends Equatable {
  const LevelsEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends LevelsEvent {}
