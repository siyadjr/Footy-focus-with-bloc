import 'package:bloc/bloc.dart';
import 'package:footy_focus/Controllers/Bloc/bloc/league_details_event.dart';
import 'package:footy_focus/Controllers/Bloc/bloc/league_details_state.dart';

import 'package:meta/meta.dart';



class LeagueDetailsBloc extends Bloc<LeagueDetailsEvent, LeagueDetailsState> {
  LeagueDetailsBloc() : super(LeagueDetailsInitial()) {
    on<LeagueDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
