part of 'players_bloc_bloc.dart';

@immutable
abstract class PlayersBlocEvent {}

class FetchPlayer extends PlayersBlocEvent { 
  final int id;
  FetchPlayer(this.id);
}

class FilterPlayer extends PlayersBlocEvent { 
  final String query;
  FilterPlayer(this.query);
}
