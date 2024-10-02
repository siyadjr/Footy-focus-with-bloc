import 'package:bloc/bloc.dart';
import 'package:footy_focus/constant.dart';
import 'package:meta/meta.dart';

part 'league_for_players_event.dart';
part 'league_for_players_state.dart';

class LeagueForPlayersBloc
    extends Bloc<LeagueForPlayersEvent, LeagueForPlayersState> {
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
