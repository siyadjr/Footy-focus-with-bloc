import 'package:footy_focus/Models/team_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '304cc483196f41f4bcf3a5e59a4cc39c';

class FootballApi {
  final String baseUrl = 'https://api.football-data.org/v4';

  Future<Map<String, dynamic>> getPlayerStats(int playerId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/persons/$playerId'),
      headers: {
        'X-Auth-Token': apiKey,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load player stats');
    }
  }

  Future<Map<String, dynamic>> getTeamStats(int teamId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/teams/$teamId'),
      headers: {
        'X-Auth-Token': apiKey,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load team stats');
    }
  }

  Future<Map<String, dynamic>> getLeagueStats(int leagueId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/leagues/$leagueId'),
      headers: {
        'X-Auth-Token': apiKey,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load league stats');
    }
  }

  Future<List<TeamModel>> fetchTeamsForLeague(int leagueId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/competitions/$leagueId/teams'),
      headers: {
        'X-Auth-Token': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> teamsData = data['teams'];
      return teamsData.map((team) => TeamModel.fromJson(team)).toList();
    } else {
      throw Exception('Failed to load teams for the league');
    }
  }

  Future<List<Map<String, dynamic>>> fetchPlayersForTeam(int teamId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/teams/$teamId'),
      headers: {
        'X-Auth-Token': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['squad']);
    } else {
      throw Exception('Failed to load players for the team');
    }
  } Future<List<Map<String, dynamic>>> searchPlayers(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/players?search=$query'), // Adjust based on the actual API
      headers: {
        'X-Auth-Token': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['players']); // Adjust based on the actual structure
    } else {
      throw Exception('Failed to load players');
    }
  }
}
