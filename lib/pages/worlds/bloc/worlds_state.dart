part of 'worlds_bloc.dart';

class WorldsState extends Equatable {
  final List<World> worlds;

  const WorldsState({
    required this.worlds,
  });

  @override
  List<Object?> get props => [worlds];
}
