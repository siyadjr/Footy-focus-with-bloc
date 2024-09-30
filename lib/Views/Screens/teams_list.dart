import 'package:flutter/material.dart';
import 'package:footy_focus/Controllers/Api/football_api.dart';
import 'package:footy_focus/Models/team_model.dart';
import 'package:footy_focus/Views/Screens/team_players.dart';

class TeamsList extends StatefulWidget {
  final String leagueId;

  const TeamsList({
    Key? key,
    required this.leagueId,
  }) : super(key: key);

  @override
  _TeamsListState createState() => _TeamsListState();
}

class _TeamsListState extends State<TeamsList> {
  late Future<List<TeamModel>> teamsFuture;
  List<TeamModel> allTeams = [];
  List<TeamModel> displayedTeams = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    teamsFuture = FootballApi().fetchTeamsForLeague(int.parse(widget.leagueId));
    teamsFuture.then((teams) {
      setState(() {
        allTeams = teams;
        displayedTeams = allTeams;
      });
    });
  }

  void filterTeams(String query) {
    setState(() {
      displayedTeams = allTeams
          .where((team) =>
              team.name.toLowerCase().contains(query.toLowerCase()) ||
              team.country.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teams'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search teams...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: filterTeams,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<TeamModel>>(
              future: teamsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No teams found.'));
                } else {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: displayedTeams.length,
                    itemBuilder: (context, index) {
                      final team = displayedTeams[index];
                      return TeamCard(team: team);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TeamCard extends StatelessWidget {
  final TeamModel team;

  const TeamCard({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => TeamPlayers(teamId: team.id)),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: team.crest != null
                  ? Image.network(
                      team.crest!,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.shield, size: 60);
                      },
                    )
                  : const Icon(Icons.shield, size: 60),
            ),
            const SizedBox(height: 16),
            Text(
              team.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              team.country,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
