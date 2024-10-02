part of 'players_bloc_bloc.dart';

@immutable
abstract class PlayersBlocEvent {}

class FetchPlayer extends PlayersBlocEvent { // Error 6: Ensure consistency of event names
  final int id;
  FetchPlayer(this.id);
}

class FilterPlayer extends PlayersBlocEvent { // Error 7: Same here, correct naming convention
  final String query;
  FilterPlayer(this.query);
}
