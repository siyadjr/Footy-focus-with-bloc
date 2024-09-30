import 'package:flutter/material.dart';
import 'package:footy_focus/Controllers/Api/football_api.dart';
import 'package:footy_focus/Views/Screens/player_details.dart';

class TeamPlayers extends StatefulWidget {
  final int teamId;

  const TeamPlayers({
    Key? key,
    required this.teamId,
  }) : super(key: key);

  @override
  _TeamPlayersState createState() => _TeamPlayersState();
}

class _TeamPlayersState extends State<TeamPlayers> {
  late Future<List<dynamic>> playersFuture;
  List<dynamic> allPlayers = [];
  List<dynamic> displayedPlayers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    playersFuture = FootballApi().fetchPlayersForTeam(widget.teamId);
    playersFuture.then((players) {
      setState(() {
        allPlayers = players;
        displayedPlayers = allPlayers;
      });
    });
  }

  void filterPlayers(String query) {
    setState(() {
      displayedPlayers = allPlayers
          .where((player) =>
              player['name'].toLowerCase().contains(query.toLowerCase()) ||
              player['position'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Players'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search players...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: filterPlayers,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: playersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No players found.'));
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
                    itemCount: displayedPlayers.length,
                    itemBuilder: (context, index) {
                      final player = displayedPlayers[index];
                      return PlayerCard(player: player);
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

class PlayerCard extends StatelessWidget {
  final dynamic player;

  const PlayerCard({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => PlayerDetails(
                      playerId: player['id'],
                    )),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: player['photo'] != null
                  ? NetworkImage(player['photo'])
                  : null,
              child: player['photo'] == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              player['name'] ?? 'No name available',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              player['position'] ?? 'Position unavailable',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
