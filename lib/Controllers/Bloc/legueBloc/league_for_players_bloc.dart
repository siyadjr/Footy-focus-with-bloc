import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'league_for_players_event.dart';
part 'league_for_players_state.dart';

class LeagueForPlayersBloc
    extends Bloc<LeagueForPlayersEvent, LeagueForPlayersState> {
  final List<Map<String, String>> leagues = [
    {
      "name": "Premier League",
      "country": "England",
      "logo": "🏴󠁧󠁢󠁥󠁮󠁧󠁿",
      "id": " 2021"
    },
    {"name": "La Liga", "country": "Spain", "logo": "🇪🇸", "id": "2014"},
    {"name": "Bundesliga", "country": "Germany", "logo": "🇩🇪", "id": "2002"},
    {"name": "Serie A", "country": "Italy", "logo": "🇮🇹", "id": "2019"},
    {"name": "Ligue 1", "country": "France", "logo": "🇫🇷", "id": "2015"},
    {
      "name": "Eredivisie",
      "country": "Netherlands",
      "logo": "🇳🇱",
      "id": "2003"
    },
    {
      "name": "Primeira Liga",
      "country": "Portugal",
      "logo": "🇵🇹",
      "id": "2017"
    },
    {
      "name": "Scottish Premiership",
      "country": "Scotland",
      "logo": "🏴󠁧󠁢󠁳󠁣󠁴󠁿",
      "id": "2084"
    },
    {
      "name": "Belgian Pro League",
      "country": "Belgium",
      "logo": "🇧🇪",
      "id": "2009"
    },
    {
      "name": "Russian Premier League",
      "country": "Russia",
      "logo": "🇷🇺",
      "id": "2128"
    },
  ];
  LeagueForPlayersBloc() : super(LeagueForPlayersInitial()) {
    on<LoadLeagues>((event, emit) {
      emit(LeagueForPlayersLoading());
      emit(LeagueLoaded(leagues));
    });
    on<FilterLeagues>((event, emit) {
      List<Map<String, String>> filteredLeagues = leagues
          .where((league) =>
              league['name']!
                  .toLowerCase()
                  .contains(event.query.toLowerCase()) ||
              league['country']!
                  .toLowerCase()
                  .contains(event.query.toLowerCase()))
          .toList();
      emit(LeaguesFiltered(filteredLeagues));
    });
  }
}
