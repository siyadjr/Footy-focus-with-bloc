part of 'teams_bloc_bloc.dart';

@immutable
abstract class TeamsBlocState {}

class TeamsBlocInitial extends TeamsBlocState {}

class TeamsLoading extends TeamsBlocState {}

class TeamsLoaded extends TeamsBlocState {
  final List<TeamModel> teams;

  TeamsLoaded(this.teams);
}

class TeamsFiltered extends TeamsBlocState {
  final List<TeamModel> filteredTeams;

  TeamsFiltered(this.filteredTeams);
}

class TeamsError extends TeamsBlocState {
  final String message;

  TeamsError(this.message);
}
