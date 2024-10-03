abstract class LeagueDetailsState {}

class LeagueDetailsInitial extends LeagueDetailsState {}

// Standings States
class StandingsLoading extends LeagueDetailsState {}
class StandingsLoaded extends LeagueDetailsState {
  final Map<String, dynamic> standings;
  StandingsLoaded(this.standings);
}
class StandingsError extends LeagueDetailsState {
  final String message;
  StandingsError(this.message);
}

// Top Scorers States
class TopScorersLoading extends LeagueDetailsState {}
class TopScorersLoaded extends LeagueDetailsState {
  final Map<String, dynamic> topScorers;
  TopScorersLoaded(this.topScorers);
}
class TopScorersError extends LeagueDetailsState {
  final String message;
  TopScorersError(this.message);
}

// Combined State
class CombinedDataState extends LeagueDetailsState {
  final Map<String, dynamic>? standings;
  final Map<String, dynamic>? topScorers;
  final bool isStandingsLoading;
  final bool isTopScorersLoading;
  final String? standingsError;
  final String? topScorersError;

  CombinedDataState({
    this.standings,
    this.topScorers,
    this.isStandingsLoading = false,
    this.isTopScorersLoading = false,
    this.standingsError,
    this.topScorersError,
  });

  CombinedDataState copyWith({
    Map<String, dynamic>? standings,
    Map<String, dynamic>? topScorers,
    bool? isStandingsLoading,
    bool? isTopScorersLoading,
    String? standingsError,
    String? topScorersError,
  }) {
    return CombinedDataState(
      standings: standings ?? this.standings,
      topScorers: topScorers ?? this.topScorers,
      isStandingsLoading: isStandingsLoading ?? this.isStandingsLoading,
      isTopScorersLoading: isTopScorersLoading ?? this.isTopScorersLoading,
      standingsError: standingsError ?? this.standingsError,
      topScorersError: topScorersError ?? this.topScorersError,
    );
  }
}