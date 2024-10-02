part of 'league_for_players_bloc.dart';

@immutable
sealed class LeagueForPlayersEvent {}

final class LoadLeagues extends LeagueForPlayersEvent {}

final class FilterLeagues extends LeagueForPlayersEvent {
  final String query;
  FilterLeagues(this.query);
}
