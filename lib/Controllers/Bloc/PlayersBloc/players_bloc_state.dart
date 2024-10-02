part of 'players_bloc_bloc.dart';

@immutable
abstract class PlayersBlocState {}

class PlayersBlocInitial extends PlayersBlocState {}

class PlayerLoading extends PlayersBlocState {}

class PlayerLoaded extends PlayersBlocState {
  final List<dynamic> players;
  PlayerLoaded(this.players);
}

class PlayerLoadingError extends PlayersBlocState {
  final String message;
  PlayerLoadingError(this.message);
}
