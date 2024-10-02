import 'package:bloc/bloc.dart';
import 'package:footy_focus/Controllers/Api/football_api.dart'; // Ensure the API is correctly fetching data
import 'package:meta/meta.dart';

part 'players_bloc_event.dart'; // Correctly linked
part 'players_bloc_state.dart'; // Correctly linked

class PlayersBloc extends Bloc<PlayersBlocEvent, PlayersBlocState> {
  PlayersBloc() : super(PlayersBlocInitial()) {
    on<FetchPlayer>(_onFetchPlayers); // Error 3: Mismatch of event (Correct: `FetchPlayer` not `FetchPlayers`)
    on<FilterPlayer>(_onFilterPlayers); // Error 4: Same as above
  }

  Future<void> _onFetchPlayers(FetchPlayer event, Emitter<PlayersBlocState> emit) async {
    emit(PlayerLoading());
    try {
      final players = await FootballApi().fetchPlayersForTeam(event.id); // Error 5: Fix teamId to id (consistent with `FetchPlayer` event)
      emit(PlayerLoaded(players));
    } catch (e) {
      emit(PlayerLoadingError('Failed to load players: ${e.toString()}'));
    }
  }

  void _onFilterPlayers(FilterPlayer event, Emitter<PlayersBlocState> emit) {
    if (state is PlayerLoaded) {
      final currentState = state as PlayerLoaded;
      final filteredPlayers = currentState.players.where((player) {
        final query = event.query.toLowerCase();
        return player['name'].toLowerCase().contains(query) ||
               player['position'].toLowerCase().contains(query);
      }).toList();
      emit(PlayerLoaded(filteredPlayers));
    }
  }
}
