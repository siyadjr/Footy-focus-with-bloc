import 'package:flutter/material.dart';
import 'package:footy_focus/Controllers/Api/football_api.dart'; // Assuming API is here

class TeamPlayers extends StatefulWidget {
  final int teamId; // Accept the team ID as a parameter

  const TeamPlayers( {
    super.key,
    required this.teamId, // Required parameter
  });

  @override
  _TeamPlayersState createState() => _TeamPlayersState();
}

class _TeamPlayersState extends State<TeamPlayers> {
  late Future<List<dynamic>> playersFuture;

  @override
  void initState() {
    super.initState();
    // Fetch players for the team using teamId
    playersFuture = FootballApi().fetchPlayersForTeam(widget.teamId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Players'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: playersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No players found.'));
          } else {
            final players = snapshot.data!;
            return ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];
                return ListTile(
                  title: Text(player['name'] ?? 'No name available'),
                  subtitle: Text(player['position'] ?? 'Position unavailable'),
                  leading: player['photo'] != null
                      ? Image.network(
                          player['photo'], // Player photo
                          width: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.person); // Fallback icon
                          },
                        )
                      : const Icon(Icons.person), // Default icon if no photo is available
                  onTap: () {
                    // Handle player tap (e.g., navigate to a player detail screen)
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
