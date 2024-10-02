import 'package:bloc/bloc.dart';
import 'package:footy_focus/Controllers/Api/football_api.dart';
import 'package:footy_focus/Models/team_model.dart';
import 'package:meta/meta.dart';

part 'teams_bloc_event.dart';
part 'teams_bloc_state.dart';

class TeamsBlocBloc extends Bloc<TeamsBlocEvent, TeamsBlocState> {
  TeamsBlocBloc() : super(TeamsBlocInitial()) {
    on<LoadTeams>((event, emit) async {
      emit(TeamsLoading());
      try {
        final teams = await FootballApi().fetchTeamsForLeague(int.parse(event.leagueId));
        emit(TeamsLoaded(teams));
      } catch (e) {
        emit(TeamsError('Failed to load teams'));
      }
    });

    on<FilterTeams>((event, emit) {
      if (state is TeamsLoaded) {
        final allTeams = (state as TeamsLoaded).teams;
        final filteredTeams = allTeams.where((team) =>
            team.name.toLowerCase().contains(event.query.toLowerCase()) ||
            team.country.toLowerCase().contains(event.query.toLowerCase())).toList();

        emit(TeamsFiltered(filteredTeams));
      }
    });
  }
}
