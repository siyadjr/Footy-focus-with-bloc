import 'package:flutter/material.dart';
import 'package:footy_focus/Controllers/Api/football_api.dart';
import 'package:footy_focus/Models/player_model.dart';
import 'package:footy_focus/constant.dart';

class PlayerDetails extends StatefulWidget {
  final int playerId;

  const PlayerDetails({super.key, required this.playerId});

  @override
  _PlayerDetailsState createState() => _PlayerDetailsState();
}

class _PlayerDetailsState extends State<PlayerDetails> {
  late Future<PlayerModel?> _playerStatsFuture;

  @override
  void initState() {
    super.initState();
    _playerStatsFuture = FootballApi().getPlayerStats(widget.playerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: FutureBuilder<PlayerModel?>(
        future: _playerStatsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No player data found.'));
          }

          final player = snapshot.data!;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    player.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        player.currentTeamCrest,
                        fit: BoxFit.scaleDown,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.sports_soccer,
                              size: 100, color: Colors.white);
                        },
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildQuickInfo(player),
                      const SizedBox(height: 24),
                      _buildInfoCard('Personal Information', [
                        _buildInfoRow('Full Name', player.name),
                        _buildInfoRow('Date of Birth', player.dateOfBirth),
                        _buildInfoRow('Nationality', player.nationality),
                        _buildInfoRow('Age', _calculateAge(player.dateOfBirth)),
                      ]),
                      const SizedBox(height: 16),
                      _buildInfoCard('Professional Information', [
                        _buildInfoRow('Position', player.position),
                        _buildInfoRow(
                            'Shirt Number', player.shirtNumber.toString()),
                        _buildInfoRow('Current Team', player.currentTeamName),
                      ]),
                      const SizedBox(height: 16),
                      _buildCareerHighlights(player),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildQuickInfo(PlayerModel player) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildInfoChip(Icons.sports_soccer, player.position),
        _buildInfoChip(Icons.numbers, '${player.shirtNumber}'),
        _buildInfoChip(Icons.flag, player.nationality),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, color: Colors.white),
      label: Text(label),
      backgroundColor: Colors.blue,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(thickness: 2),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildCareerHighlights(PlayerModel player) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Career Highlights',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(thickness: 2),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.amber),
              title: const Text('Joined Current Team'),
              subtitle: Text(player.currentTeamName),
            ),
        
          ],
        ),
      ),
    );
  }

  String _calculateAge(String dateOfBirth) {
    final dob = DateTime.parse(dateOfBirth);
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return '$age years';
  }
}
