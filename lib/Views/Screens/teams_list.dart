import 'package:flutter/material.dart';
import 'package:footy_focus/Controllers/Api/football_api.dart';
import 'package:footy_focus/Models/team_model.dart';
import 'package:footy_focus/Views/Screens/team_players.dart';

class TeamsList extends StatefulWidget {
  final String leagueId;

  const TeamsList({
    super.key,
    required this.leagueId,
  });

  @override
  _TeamsListState createState() => _TeamsListState();
}

class _TeamsListState extends State<TeamsList> {
  late Future<List<TeamModel>> teamsFuture;

  @override
  void initState() {
    super.initState();
    teamsFuture = FootballApi().fetchTeamsForLeague(int.parse(widget.leagueId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teams'),
      ),
      body: FutureBuilder<List<TeamModel>>(
        future: teamsFuture, // Corrected Future type to List<TeamModel>
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No teams found.'));
          } else {
            final teams = snapshot.data!;
            return ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index]; // Now it's a TeamModel object
                return ListTile(
                  title: Text(team.name), // Accessing TeamModel properties
                  subtitle:
                      Text(team.country), // Accessing TeamModel properties
                  leading: team.crest != null
                      ? Image.network(
                          team.crest!, // Team logo
                          width: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.shield); // Fallback icon
                          },
                        )
                      : const Icon(Icons.shield),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => TeamPlayers(teamId: team.id)));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
