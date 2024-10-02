import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footy_focus/Controllers/Bloc/PlayersBloc/players_bloc_bloc.dart'; // Ensure this path is correct
import 'package:footy_focus/Views/Screens/PlayerScreens/player_details.dart'; // Ensure this path is correct

class TeamPlayers extends StatelessWidget {
  final int teamId;

  const TeamPlayers({
    Key? key,
    required this.teamId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dispatch the FetchPlayer event when this widget builds
    context.read<PlayersBloc>().add(FetchPlayer(teamId));

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
              onChanged: (query) {
                context.read<PlayersBloc>().add(
                    FilterPlayer(query)); // Ensure this event name is correct
              },
              decoration: InputDecoration(
                hintText: 'Search players...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<PlayersBloc, PlayersBlocState>(
              builder: (context, state) {
                if (state is PlayerLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PlayerLoadingError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else if (state is PlayerLoaded) {
                  final displayedPlayers = state.players;
                  if (displayedPlayers.isEmpty) {
                    return const Center(child: Text('No players found.'));
                  }
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
                return const Center(child: Text('Unexpected state.'));
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
                playerId:
                    player['id'], // Ensure player data is structured correctly
              ),
            ),
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
