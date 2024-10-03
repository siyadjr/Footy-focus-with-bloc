import 'package:flutter/material.dart';

@immutable
abstract class LeagueDetailsEvent {}

class FetchLEagueDetails extends LeagueDetailsEvent {
  final String leagueCode; 
  FetchLEagueDetails(this.leagueCode);
}

class FetchleagueTopScorers extends LeagueDetailsEvent {
  final String leagueCode; 
  FetchleagueTopScorers(this.leagueCode);
}
