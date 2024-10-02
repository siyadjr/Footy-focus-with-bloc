part of 'teams_bloc_bloc.dart';

@immutable
abstract class TeamsBlocEvent {}

class LoadTeams extends TeamsBlocEvent {
  final String leagueId;

  LoadTeams(this.leagueId);
}

class FilterTeams extends TeamsBlocEvent {
  final String query;

  FilterTeams(this.query);
}
