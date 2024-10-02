part of 'league_for_players_bloc.dart';

@immutable
sealed class LeagueForPlayersState {}

final class LeagueForPlayersInitial extends LeagueForPlayersState {}

final class LeagueLoaded extends LeagueForPlayersState {
  final List<Map<String, String>> leagues;
  LeagueLoaded(this.leagues);
}
final class LeaguesFiltered extends LeagueForPlayersState{
    final List<Map<String, String>> filteredLeagues;

  LeaguesFiltered(this.filteredLeagues);
}
final class LeagueForPlayersLoading extends LeagueForPlayersState {}
