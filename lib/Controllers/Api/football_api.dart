import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:footy_focus/Models/player_model.dart';
import 'package:footy_focus/Models/team_model.dart';

const apiKey = '304cc483196f41f4bcf3a5e59a4cc39c';

class FootballApi {
  final String baseUrl = 'https://api.football-data.org/v4';

  Future<PlayerModel?> getPlayerStats(int playerId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/persons/$playerId'),
      headers: {
        'X-Auth-Token': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PlayerModel.fromJson(data);
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
  }

  Future<TeamModel> fetchTeamDetails(int teamId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/teams/$teamId'),
      headers: {
        'X-Auth-Token': apiKey,
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return TeamModel.fromJson(data);
    } else {
      throw Exception('Failed to load team details');
    }
  }
 Future<Map<String, dynamic>> fetchStandings(String leagueId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/competitions/$leagueId/standings'),
        headers: {"X-Auth-Token": apiKey},
      );
      
      log('Standings Response Status: ${response.statusCode}');
      log('Standings Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load standings: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching standings: $e');
      throw Exception('Failed to load standings: $e');
    }
  }

  Future<Map<String, dynamic>> fetchTopScorers(String leagueId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/competitions/$leagueId/scorers'),
        headers: {"X-Auth-Token": apiKey},
      );
      
      log('Top Scorers Response Status: ${response.statusCode}');
      log('Top Scorers Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load top scorers: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching top scorers: $e');
      throw Exception('Failed to load top scorers: $e');
    }
  }
}
